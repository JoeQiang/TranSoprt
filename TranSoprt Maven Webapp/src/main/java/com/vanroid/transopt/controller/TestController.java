package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;
import com.vanroid.transopt.model.User;
import com.vanroid.transopt.service.TestService;
/**
 * 测试Controller
 * @author Joe_Huang
 *
 */
public class TestController extends Controller {
	TestService testService = new TestService();

	public void index() {
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
