package com.vanroid.transopt.service;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.uitls.MD5Utils;

@Before(Tx.class)
public class GRFactoryServiceImp implements GRFactoryService {

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

	@Override
	public boolean saveFactory(String fname, String fpwd) {
		GRFactory factory = new GRFactory();
		return factory.set("fname", fname).set("fpwd", MD5Utils.MD5(fpwd))
				.save();
	}

	public Page<GRFactory> getFactoryList(int pageNum) {
		return GRFactory.dao.paginate(pageNum, 10, "select *",
				"from grfactory where 1=1 order by fid desc");
	}

	@Override
	public GRFactory getFactoryById(int fid) {
		return GRFactory.dao.findById(fid);
	}

	@Override
	public boolean updateFactory(int fid, String fname, String fpwd) {
		GRFactory factory = GRFactory.dao.findById(fid);
		return factory.set("fname", fname).set("fpwd", MD5Utils.MD5(fpwd))
				.update();
	}
}
