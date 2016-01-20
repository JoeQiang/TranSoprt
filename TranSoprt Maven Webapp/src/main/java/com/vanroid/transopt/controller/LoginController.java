package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;
import com.jfinal.log.Log4jLogger;
import com.vanroid.transopt.model.Admin;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.service.AdminService;
import com.vanroid.transopt.service.AdminServiceImp;
import com.vanroid.transopt.service.DealerService;
import com.vanroid.transopt.service.DealerServiceImp;
import com.vanroid.transopt.service.GRFActoryServiceImp;
import com.vanroid.transopt.service.GRFactoryService;
import com.vanroid.transopt.uitls.Constant;

public class LoginController extends Controller {
	public void index() {
		render("jsp/login.jsp");
	}

	public void dologin() {
		String username = getPara("username");
		String password = getPara("password");
		String type = getPara("type");
		Log4jLogger.getLogger(getClass()).debug(
				"type:" + type + " type==admin"
						+ (type == Constant.USER_TYPE_ADMIN));

		if (Constant.USER_TYPE_ADMIN.equals(type)) {
			Admin admin = new Admin();
			admin.set("username", username);
			admin.set("password", password);
			AdminService adminService = new AdminServiceImp();
			boolean flag = adminService.doLogin(admin);
			if (flag) {
				Admin am = adminService.getByName(admin.getStr("username"));
				setSessionAttr("user", am);
				setSessionAttr("rank", Constant.USER_TYPE_ADMIN);
				forwardAction("/");
			} else {
				setAttr("error", "用户名或密码不正确");
				forwardAction("/login");
			}
		} else if (Constant.USER_TYPE_DEALER.equals(type)) {
			Dealer dealer = new Dealer();
			dealer.set("dname", username);
			dealer.set("dpwd", password);
			DealerService dealerService = new DealerServiceImp();
			boolean flag = dealerService.doLogin(dealer);
			if (flag) {
				Dealer dl = dealerService.getByName(dealer.getStr("dname"));
				setSessionAttr("user", dl);
				setSessionAttr("rank", Constant.USER_TYPE_DEALER);
				forwardAction("/");
			} else {
				setAttr("error", "用户名或密码不正确");
				forwardAction("/login");
			}
		} else if (Constant.USER_TYPE_FACTORY.equals(type)) {
			GRFactory factory = new GRFactory();
			factory.set("fname", username);
			factory.set("fpwd", password);
			GRFactoryService grFactoryService = new GRFActoryServiceImp();
			boolean flag = grFactoryService.doLogin(factory);
			if (flag) {
				GRFactory grf = grFactoryService.getByName(factory
						.getStr("fname"));
				setSessionAttr("user", grf);
				setSessionAttr("rank", Constant.USER_TYPE_FACTORY);
				forwardAction("/");
			} else {
				setAttr("error", "用户名或密码不正确");
				forwardAction("/login");
			}
		}
	}
}
