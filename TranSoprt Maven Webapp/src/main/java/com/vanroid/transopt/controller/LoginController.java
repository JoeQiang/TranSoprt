package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.vanroid.transopt.model.Admin;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.service.AdminService;
import com.vanroid.transopt.service.AdminServiceImp;
import com.vanroid.transopt.service.GRFactoryService;
import com.vanroid.transopt.service.GRFactoryServiceImp;
import com.vanroid.transopt.uitls.Constant;

public class LoginController extends Controller {
	public void index() {
		render("/jsp/login.jsp");
	}

	/**
	 * 登录操作
	 */
	public void login() {
		String username = getPara("username");
		String password = getPara("password");
		String type = getPara("type");
		boolean flag = false;
		if (Constant.USER_TYPE_ADMIN.equals(type)) {
			Admin admin = new Admin().set("username", username).set("password",
					password);
			AdminService as = new AdminServiceImp();
			flag = as.doLogin(admin);
			if (flag) {
				admin = as.getByName(username);
				setSessionAttr("user", admin);
				setSessionAttr("rank", Constant.USER_TYPE_ADMIN);
				forwardAction("/account/main");
			} else {
				setAttr("error", "帐号或密码不正确");
				forwardAction("/account");
			}
		} else if (Constant.USER_TYPE_FACTORY.equals(type)) {
			GRFactory factory = new GRFactory().set("fname", username).set(
					"fpwd", password);
			GRFactoryService fs = new GRFactoryServiceImp();
			flag = fs.doLogin(factory);
			if (flag) {
				factory = fs.getByName(username);
				setSessionAttr("user", factory);
				setSessionAttr("rank", Constant.USER_TYPE_FACTORY);
				forwardAction("/account/main");
			} else {
				setAttr("error", "帐号或密码不正确");
				forwardAction("/account");
			}

		}
	}

	public void logout() {
		getSession().removeAttribute("user");
		getSession().invalidate();
		forwardAction("/account");
	}

	public void main() {
		render("jsp/index.jsp");
	}
}
