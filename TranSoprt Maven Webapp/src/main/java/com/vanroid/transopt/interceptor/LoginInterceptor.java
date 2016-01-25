package com.vanroid.transopt.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.render.Render;

/**
 * 登录拦截器，未登录跳转登录页
 * 
 * @author Joe_Huang
 * 
 */
public class LoginInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		Controller c = inv.getController();
		Object user = c.getSessionAttr("user");
		if (user == null) {
			c.render("/account");
		}
		inv.invoke();
	}
}
