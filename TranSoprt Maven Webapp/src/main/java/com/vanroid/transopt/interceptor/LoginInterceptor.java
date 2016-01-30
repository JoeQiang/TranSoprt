package com.vanroid.transopt.interceptor;

import org.apache.log4j.Logger;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

/**
 * 登录拦截器，未登录跳转登录页
 * 
 * @author Joe_Huang
 * 
 */
public class LoginInterceptor implements Interceptor {
<<<<<<< HEAD
	Logger logger = Logger.getLogger(LoginInterceptor.class);

=======
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
	@Override
	public void intercept(Invocation inv) {
		Controller c = inv.getController();
		Object user = c.getSessionAttr("user");
		if (user == null) {
<<<<<<< HEAD
			c.redirect("/");//默认就是登陆页面
		} else
			inv.invoke();
=======
			c.render("/jsp/login.jsp");
		} else {
			inv.invoke();
		}
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
	}
}
