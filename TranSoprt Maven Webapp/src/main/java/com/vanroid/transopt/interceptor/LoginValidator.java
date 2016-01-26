package com.vanroid.transopt.interceptor;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * 经销商登陆拦截器
 * 
 * @author Jerry
 * 
 */
public class LoginValidator extends Validator {
	protected void validate(Controller c) {
		validateRequiredString("name", "nameMsg", "请输入用户名");
		validateRequiredString("pass", "passMsg", "请输入密码");
	}

	protected void handleError(Controller c) {
		c.keepPara("name");
		c.render("dealerlogin.html");
	}
}
