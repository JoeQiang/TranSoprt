package com.vanroid.transopt.service;

import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.uitls.MD5Utils;

public class DealerServiceImp implements DealerService {

	@Override
	public boolean doLogin(Dealer dealer) {
		String username = dealer.get("dname");
		String password = dealer.get("dpwd");

		// MD5加密
		password = MD5Utils.MD5(password);
		Dealer dl = getByName(username);
		boolean flag = false;

		if (dl != null && password.equals(dl.get("dpwd"))) {
			flag = true;
		}
		return flag;
	}

	@Override
	public Dealer getByName(String username) {
		return Dealer.dao.findFirst("select * from dealer where dname=?",
				username);
	}

}
