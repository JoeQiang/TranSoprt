package com.vanroid.transopt.controller;

import javax.faces.view.facelets.Facelet;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.vanroid.transopt.interceptor.LoginInterceptor;
import com.vanroid.transopt.model.Admin;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.service.AdminService;
import com.vanroid.transopt.service.AdminServiceImp;
import com.vanroid.transopt.service.GRFactoryService;
import com.vanroid.transopt.service.GRFactoryServiceImp;
import com.vanroid.transopt.uitls.Constant;
import com.vanroid.transopt.uitls.MD5Utils;

public class LoginController extends Controller {
	@Clear(LoginInterceptor.class)
	public void index() {
		render("/jsp/login.jsp");
	}

	/**
	 * 登录操作
	 */
	@Clear(LoginInterceptor.class)
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
				redirect("/order/distorder/1");// 登陆成功跳转到首页
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
				redirect("/account/main");
			} else {
				setAttr("error", "帐号或密码不正确");
				forwardAction("/account");
			}

		}
	}

	@Before(LoginInterceptor.class)
	public void logout() {
		getSession().removeAttribute("user");
		getSession().invalidate();
		forwardAction("/account");
	}

	public void main() {
		render("jsp/index.jsp");
	}

	@Before(LoginInterceptor.class)
	public void pwdpage() {
		render("jsp/acount_pwd.jsp");
	}

	public void cheangepwd() {
		String pwd = getPara("pwd");
		String rank = getSessionAttr("rank");
		boolean isUpdate = false;
		if (Constant.USER_TYPE_ADMIN.equals(rank)) {
			Admin admin = getSessionAttr("user");
			isUpdate = admin.set("password", MD5Utils.MD5(pwd)).update();
		} else if (Constant.USER_TYPE_FACTORY.equals(rank)) {
			GRFactory factory = getSessionAttr("user");
			isUpdate = factory.set("fpwd", MD5Utils.MD5(pwd)).update();
		}
		if (isUpdate) {
			setAttr("msg", "修改密码成功");
		} else {
			setAttr("msg", "修改密码成功");
		}
		render("jsp/acount_pwd.jsp");
	}
}
