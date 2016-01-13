package com.vanroid.transopt.service;

import com.vanroid.transopt.model.User;

/**
 * 测试Service
 * 
 * @author Joe_Huang
 * 
 */
public class TestService {

	public boolean dologin(User user) {
		String username = user.get("username");
		String password = user.get("password");
		User u = getByName(username);
		boolean flag = false;

		if (u != null && password.equals(u.get("password"))) {
			flag = true;
		}
		return flag;
	}

	public User getByName(String username) {
		return User.dao.findFirst("select * from user where username=?",
				username);
	}
}
