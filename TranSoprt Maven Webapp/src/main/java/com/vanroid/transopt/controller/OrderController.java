package com.vanroid.transopt.controller;

import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.service.OrderManageService;

public class OrderController extends Controller {
	private OrderManageService om = Duang.duang(OrderManageService.class);

	// 分配订单
	public void distorder() {
		Page<GROrder> page = om.getNewOrderPage(1);// 查询未分配的订到分页
		setAttr("newOrder", page.getList());
		setAttr("factorys", om.getAllFactory());
		render("/jsp/ordermanage.jsp");
	}

	// 分配厂家ajax
	public void distfactory() {
		int result = om.distributeFactory(getParaToInt(1),
				getParaToInt(0));
		renderJson(result);
	}
}