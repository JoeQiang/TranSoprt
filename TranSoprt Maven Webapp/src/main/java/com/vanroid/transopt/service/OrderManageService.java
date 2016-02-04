package com.vanroid.transopt.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.mysql.fabric.xmlrpc.base.Data;
import com.taobao.api.ApiException;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import com.vanroid.transopt.dto.OrderParam;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.model.NoteTemplate;
import com.vanroid.transopt.uitls.NoteUtil;

/**
 * 订单管理的业务逻辑类
 * 
 * @author Jerry
 * 
 */
@Before(Tx.class)
public class OrderManageService {
	Logger logger = Logger.getLogger(OrderManageService.class);

	/**
	 * 经销商下确认订单
	 */
	public boolean makeOrder(int did, int gid, int sid, int num) {

		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		Dealer dealer = Dealer.dao.findById(did);
		GROrder order = new GROrder().set("dealerid", did)
				.set("createday", today).set("status", "可撤销").set("gid", gid)
				.set("sid", sid).set("num", num)
				// 默认订单的规定到达时间是经销商的设定的时限
				.set("reqarrday", dealer.getInt("limitdays"));
		return order.save();
	}

	/**
	 * 管理员管理的新下的订单的分页
	 */
	public Page<GROrder> getNewOrderPage(int pageNum) {
		// 查询为分配厂家的订单
		Page<GROrder> page = GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where factoryid is null");
		for (GROrder order : page.getList()) {
			order.getAttrFromOtherTable();
		}
		return page;
	}

	/**
	 * 管理员管理的给新订单分配厂家 ajax 更新成功返回1，失敗返回0
	 */
	public int distributeFactory(int oid, int fid, int arrdays) {
	 
		boolean update = GROrder.dao.findById(oid).set("factoryid", fid)
				.set("status", "未发货").set("reqarrday", arrdays).update();
		if (update)
			return 1;
		return 0;
	}

	/**
	 * 显示各厂家自己的订单
	 */
	public List<GROrder> getOrderByFid(int fid) {
		String sql = "select * from grorder where factoryid=?";
		return GROrder.dao.find(sql, fid);
	}

	/**
	 * 管理员下所有的订单
	 */
	public List<GROrder> getAllOrder() {
		return GROrder.dao.find("select * from grorder");
	}

	/**
	 * 获取所有的厂家
	 * 
	 * @return
	 */
	public List<GRFactory> getAllFactory() {
		return GRFactory.dao.find("select fid,fname from grfactory");
	}

	/**
	 * 管理员角色登陆下 经销商模块下（发货和发送信息）的订单列表，
	 * 
	 * @return
	 */
	public Page<GROrder> getDelivOrder(int pageNum) {
		Page<GROrder> page = GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where status=?", "未发货");
		for (GROrder order : page.getList()) {
			order.getAttrFromOtherTable();
		}
		return page;
	}

	/**
	 * 厂家角色登陆下 经销商模块下（发货和发送信息）的订单列表
	 * 
	 * @return
	 */
	public Page<GROrder> getDelivOrder(int fid, int pageNum) {
		Page<GROrder> page = GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where factoryid =? and status=?", fid, "未发货");
		for (GROrder order : page.getList()) {
			order.getAttrFromOtherTable();
		}
		return page;
	}

	/**
	 * 订单发货
	 * 
	 * @param gid
	 * @return
	 * @throws ApiException
	 * @throws IOException
	 */
	public int deliverGoods(int oid) throws IOException, ApiException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());
		GROrder.dao.findById(oid).set("status", "已发货").set("sendday", today)
				.update();
		return inform(oid);// 短信通知
	}

	/**
	 * 短信信息通知
	 * 
	 * @param oid
	 * @param phone
	 * @return
	 * @throws IOException
	 * @throws ApiException
	 *             ${dname}老板，您好！您预订的${order}已经于${sendday}在${fname}厂发货了，
	 *             大概于${arriveday}，请注意收货，谢谢！
	 */
	public int inform(int oid) throws IOException, ApiException {
		GROrder order = GROrder.dao.findById(oid);
		order.getAttrFromOtherTable();
		TaobaoClient client = new NoteUtil().getTaobaoClient();
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setSmsType("normal");
		req.setSmsFreeSignName(NoteUtil.getSignName());
		/* req.setSmsFreeSignName("港荣"); */
		/**
		 * 短信模板內容組合
		 */
		NoteTemplate nt = new NoteTemplate();
		nt.setDname(((Dealer) order.get("dealer")).getStr("dname"));
		nt.setFname(order.getStr("factoryname"));
		String goods = order.getInt("num") + "箱" + order.getStr("sname") + "的"
				+ order.getStr("gname");
		nt.setOrder(goods);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		Date arriveDay = DateUtils.addDays(today,
				((Dealer) order.get("dealer")).getInt("limitdays"));
		nt.setSendday(sdf.format(today));
		nt.setArriveday(sdf.format(arriveDay));
		Gson gson = new Gson();
		req.setSmsParamString(gson.toJson(nt));
		logger.info("gsonstr:" + gson.toJson(nt));
		req.setRecNum(((Dealer) order.get("dealer")).getStr("phone"));
		req.setSmsTemplateCode(NoteUtil.getTemplate());
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		logger.info("notemes:" + rsp.getBody());
		if (rsp.getBody().contains("success"))
			return 1;
		return 0;
	}

	/**
	 * 客户端下，经销看到自己的所有订单
	 * 
	 * @param pageNum
	 * @param did
	 * @return
	 */
	public Page<GROrder> getOrderByDealer(int pageNum, int did) {
		return GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where dealerid=? order by oid desc", did);
	}

	/**
	 * 客户端下的确认收货
	 * 
	 * @param oid
	 */
	public boolean confirmArrive(int oid) {
		/*
		 * SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); String
		 * today = sdf.format(new Date());
		 */
		return GROrder.dao.findById(oid).set("status", "已确认签收").update();
	}
}
