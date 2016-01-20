package com.vanroid.transopt.service;

import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.uitls.MD5Utils;

public class GRFActoryServiceImp implements GRFactoryService {

	@Override
	public boolean doLogin(GRFactory factory) {
		String username = factory.get("fname");
		String password = factory.get("fpwd");

		// MD5加密
		password = MD5Utils.MD5(password);
		GRFactory grf = getByName(username);
		boolean flag = false;

		if (grf != null && password.equals(grf.get("fpwd"))) {
			flag = true;
		}
		return flag;
	}

	@Override
	public GRFactory getByName(String username) {
		return GRFactory.dao.findFirst("select * from grfactory where fname=?",
				username);
	}

}
