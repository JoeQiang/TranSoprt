package com.vanroid.transopt.service;

import com.vanroid.transopt.model.Admin;
import com.vanroid.transopt.uitls.MD5Utils;

public class AdminServiceImp implements AdminService {

	@Override
	public boolean doLogin(Admin admin) {
		String username = admin.get("username");
		String password = admin.get("password");

		// MD5加密
		password = MD5Utils.MD5(password);
		System.out.println("password:" + password);
		Admin am = getByName(username);
		boolean flag = false;

		if (am != null && password.equals(am.get("password"))) {
			flag = true;
		}
		return flag;
	}

	@Override
	public Admin getByName(String username) {
		return Admin.dao.findFirst("select * from admin where username=?",
				username);
	}

}
