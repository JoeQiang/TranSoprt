package com.vanroid.transopt.service;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.mysql.fabric.xmlrpc.base.Data;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
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
public class OrderManageService {
	Logger logger=Logger.getLogger(OrderManageService.class);
	/**
	 * 管理员管理的新下的订单的分页
	 */
	public Page<GROrder> getNewOrderPage(int pageNum) {
		// 查询为分配厂家的订单
		Page<GROrder> page = GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where factoryid is null");
		for (GROrder order : page.getList()) {
			order.getDealer();
			// order.getFactory();
			order.getGoods();
		}
		return page;
	}

	/**
	 * 管理员管理的给新订单分配厂家 ajax 更新成功返回1，失敗返回0
	 */
	@Before(Tx.class)
	public int distributeFactory(int oid, int fid) {
		try {
			new GROrder().findById(oid).set("factoryid", fid).update();
			GROrder.dao.findById(oid).set("status", "未发货").update();
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 显示各厂家自己的订单
	 */
	public List<GROrder> getOrderByFid(int fid) {
		String sql = "select * from grorder where factoryid=?";
		return GROrder.dao.find(sql, fid);
	}

	/**
	 * 厂家账户下的经销商板块下的订单
	 */
	public void getNewOrderByFid(int fid) {
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
			order.getDealer();
			order.getFactory();
			order.getGoods();
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
			order.getDealer();
			order.getFactory();
			order.getGoods();
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
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		String today=sdf.format(new Date());
		GROrder.dao.findById(oid).set("status", "已发货").set("sendday",today).update();
		return inform(oid);//短信通知
	}

	/**
	 * 短信信息通知
	 * 
	 * @param oid
	 * @param phone
	 * @return
	 * @throws IOException
	 * @throws ApiException
	 * ${dname}老板，您好！您预订的${order}已经于${sendday}在${fname}厂发货了，
	 * 大概于${arriveday}，请注意收货，谢谢！
	 */
	public int inform(int oid) throws IOException,
			ApiException {
		GROrder order=GROrder.dao.findById(oid);
		order.getAttrFromOtherTable();
		TaobaoClient client = new NoteUtil().getTaobaoClient();
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setSmsType("normal");
		req.setSmsFreeSignName("活动验证");
		/**
		 * 短信模板內容組合
		 */
		NoteTemplate nt=new NoteTemplate();
		nt.setDname(((Dealer)order.get("dealer")).getStr("dname"));
		nt.setFname(order.getStr("factoryname"));
		String goodsListString="";
		List<HashMap<String, Object>> list = order.get("goodsList");
		for (HashMap<String, Object> hashMap : list) {
			goodsListString+=hashMap.get("num")+"*"+hashMap.get("sname")+"的"+hashMap.get("gname")+",";
		}
		nt.setOrder(goodsListString);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date today=new Date();
		Date arriveDay=DateUtils.addDays(today, ((Dealer)order.get("dealer")).getInt("limitdays"));
		nt.setSendday(sdf.format(today));
		nt.setArriveday(sdf.format(arriveDay));
		Gson gson=new Gson();
		req.setSmsParamString(gson.toJson(nt));
		logger.info("gsonstr:"+gson.toJson(nt));
		req.setRecNum(((Dealer)order.get("dealer")).getStr("phone"));
		req.setSmsTemplateCode("SMS_4955204");
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		logger.info("notemes:"+rsp.getBody());
		if(rsp.getBody().contains("success"))
			return 1;
		return 0;
	}
	/**
	 *客户端下，经销看到自己的所有订单
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
	 * @param oid
	 */
	public void  confirmArrive(int oid){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-mm-dd");
		String today=sdf.format(new Data());
		GROrder.dao.findById(oid).set("status","已收货").set("arriveday",today).update();
	}
}
