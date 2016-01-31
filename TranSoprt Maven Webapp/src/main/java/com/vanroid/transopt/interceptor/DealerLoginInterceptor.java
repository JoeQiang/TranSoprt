package com.vanroid.transopt.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
/**
 * 客户端经销商登陆拦截器
 * @author Jerry
 *
 */
public class DealerLoginInterceptor implements Interceptor{

	@Override
	public void intercept(Invocation inv) {
		// TODO 自动生成的方法存根
		Controller c = inv.getController();
		Object user = c.getSessionAttr("user");
		if (user == null) {
			c.redirect("/dealer/login");
		} else
			inv.invoke();
		
	}

}
