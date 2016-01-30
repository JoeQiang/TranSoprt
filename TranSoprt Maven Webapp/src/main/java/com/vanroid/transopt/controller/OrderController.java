<<<<<<< HEAD
package com.vanroid.transopt.controller;

import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.taobao.api.ApiException;
import com.vanroid.transopt.dto.OrderParam;
import com.vanroid.transopt.interceptor.DealerLoginInterceptor;
import com.vanroid.transopt.interceptor.LoginInterceptor;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.service.OrderManageService;
import com.vanroid.transopt.uitls.Constant;

public class OrderController extends Controller {
	private OrderManageService om = Duang.duang(OrderManageService.class);
	private Logger logger = Logger.getLogger(OrderController.class);

	/**
	 * 下单ajax
	 */
	public void makeorder() {
		String phone=getSessionAttr("user");
		int did=Dealer.dao.findFirst("select did from dealer where phone=?",phone).getInt("did");
		boolean res = om.makeOrder(did,getParaToInt(0),getParaToInt(1),getParaToInt(2));
		if (res == true)
			renderJson(1);
		else
			renderJson(0);
	}

	// 分配订单
	public void distorder() {
		Page<GROrder> page = om.getNewOrderPage(getParaToInt(0));// 查询未分配的订到分页
		setAttr("newOrder", page.getList());
		setAttr("pageNum", page.getPageNumber());
		setAttr("totalPage", page.getTotalPage());
		setAttr("factorys", om.getAllFactory());
		render("/jsp/orderdistribute.jsp");
	}

	// 分配厂家ajax
	public void distfactory() {
		int result = om.distributeFactory(getParaToInt(1), getParaToInt(0));
		renderJson(result);
	}

	// 经销商模块下订单发货和信息通知的列表
	public void deliveryorder() {
		/**
		 * 管理员权限下可以看到未发货的订单
		 */
		if (getSessionAttr("rank").equals(Constant.USER_TYPE_ADMIN)) {
			Page<GROrder> page = om.getDelivOrder(getParaToInt(0));
			setAttr("delivOrder", page.getList());
			setAttr("pageNum", page.getPageNumber());
			setAttr("totalPage", page.getTotalPage());
			render("/jsp/ordersend.jsp");
		}
		/**
		 * 厂家权限下看到自己的未发货订单
		 */
		else if (getSessionAttr("rank").equals(Constant.USER_TYPE_FACTORY)) {
			GRFactory factory = getSessionAttr("user");
			Page<GROrder> page = om.getDelivOrder(factory.getInt("fid"),
					getParaToInt(0));
			setAttr("delivOrder", page.getList());
			setAttr("pageNum", page.getPageNumber());
			setAttr("totalPage", page.getTotalPage());
			render("/jsp/ordersend.jsp");
		}

	}

	// 发货ajax
	public void delivery() throws IOException, ApiException {
		int result = om.deliverGoods(getParaToInt(0));
		renderJson(result);
	}

	// 经销商获取自己所有的订单默认页（第一页）
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void getOrderbydealer() {
		String phone = getSessionAttr("user");
		int did = Dealer.dao.findFirst("select * from dealer where phone=?",
				phone).getInt("did");
		List<GROrder> list = om.getOrderByDealer(1, did).getList();
		for (GROrder grOrder : list) {
			grOrder.getAttrFromOtherTable();
		}
		setAttr("myorders", list);
		render("/jsp/order_dealer.jsp");
	}

	// 经销商根据页面数显示订单ajax
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void getOrderbydealerAjax() {
		String phone = getSessionAttr("user");
		int did = Dealer.dao.findFirst("select * from dealer where phone=?",
				phone).getInt("did");
		List<GROrder> list = om.getOrderByDealer(getParaToInt(0), did)
				.getList();
		for (GROrder grOrder : list) {
			grOrder.getAttrFromOtherTable();
		}
		renderJson(list);
	}

	// 经销商客户端确认收货ajax
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void confirmArrive() {
		if (om.confirmArrive(getParaToInt(0)))
			renderJson(1);
		else
			renderJson(0);
	}
}
=======
package com.vanroid.transopt.controller;

import java.io.IOException;

import org.apache.log4j.Logger;

import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.taobao.api.ApiException;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.service.OrderManageService;
import com.vanroid.transopt.uitls.Constant;

public class OrderController extends Controller {
	private OrderManageService om = Duang.duang(OrderManageService.class);
	private Logger logger = Logger.getLogger(OrderController.class);

	/**
	 * 下单ajax
	 */
	public void makeorder() {
		om.makeOrder(getParaToInt(0));
		renderJson(1);
	}

	// 分配订单
	public void distorder() {
		Page<GROrder> page = om.getNewOrderPage(getParaToInt(0));// 查询未分配的订到分页
		setAttr("newOrder", page.getList());
		setAttr("pageNum", page.getPageNumber());
		setAttr("totalPage", page.getTotalPage());
		setAttr("factorys", om.getAllFactory());
		render("/jsp/orderdistribute.jsp");
	}

	// 分配厂家ajax
	public void distfactory() {
		int result = om.distributeFactory(getParaToInt(1), getParaToInt(0));
		renderJson(result);
	}

	// 经销商模块下订单发货和信息通知的列表
	public void deliveryorder() {
		/**
		 * 管理员权限下可以看到未发货的订单
		 */
		if (getSessionAttr("rank").equals(Constant.USER_TYPE_ADMIN)) {
			Page<GROrder> page = om.getDelivOrder(getParaToInt(0));
			setAttr("delivOrder", page.getList());
			setAttr("pageNum", page.getPageNumber());
			setAttr("totalPage", page.getTotalPage());
			render("/jsp/ordersend.jsp");
		}
		/**
		 * 厂家权限下看到自己的未发货订单
		 */
		else if (getSessionAttr("rank").equals(Constant.USER_TYPE_FACTORY)) {
			GRFactory factory = getSessionAttr("user");
			Page<GROrder> page = om.getDelivOrder(factory.getInt("fid"),
					getParaToInt(0));
			setAttr("delivOrder", page.getList());
			setAttr("pageNum", page.getPageNumber());
			setAttr("totalPage", page.getTotalPage());
			render("/jsp/ordersend.jsp");
		}

	}

	// 发货ajax
	public void delivery() throws IOException, ApiException {
		int result = om.deliverGoods(getParaToInt(0));
		renderJson(result);
	}

	// 经销商获取自己所有的订单
	public void getOrderbydealer() {
		String phone = getSessionAttr("user");
		int did = Dealer.dao.findFirst("select * from dealer where phone=?",
				phone).getInt("did");
		om.getOrderByDealer(1, did);
		render("");
	}
}
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
