package com.vanroid.transopt.controller;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.jfinal.core.Controller;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.model.User;
import com.vanroid.transopt.service.OrderManageService;
import com.vanroid.transopt.service.TestService;
/**
 * 测试Controller
 * @author Joe_Huang
 *
 */
public class TestController extends Controller {
	TestService testService = new TestService();

	public void index() {
		List<GROrder> newOrder = OrderManageService.getNewOrder();
		System.out.println(newOrder.size());
		for (GROrder grOrder : newOrder) {
			System.out.println("--------------");
			System.out.println(grOrder.getStr("status"));
//			System.out.println(grOrder.getDealer().get("dname"));
			List<HashMap<String, Object>> goods = grOrder.getGoods();
			for (HashMap<String, Object> hashMap : goods) {
				System.out.println(hashMap.get("商品名称")+":"+hashMap.get("商品规格")+"x"+hashMap.get("商品数量"));
			}
			
		}
		render("page/login.jsp");
	}

	public void login() {
		User user = getModel(User.class);
		boolean flag = testService.dologin(user);
		if (flag) {
			User u = testService.getByName(user.getStr("username"));
			setAttr("nickname", u.get("username"));
			render("/page/show.jsp");
		} else {
			System.out.println("登陆失败");
			forwardAction("/test");

		}

	}
}
