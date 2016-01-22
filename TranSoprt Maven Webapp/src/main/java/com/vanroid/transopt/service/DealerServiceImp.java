package com.vanroid.transopt.service;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.uitls.MD5Utils;

@Before(Tx.class)
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

	@Override
	public void saveDealer(String dname, String dpwd, long phone,
			String province, int limitdays) {
		new Dealer().set("dname", dname).set("phone", phone)
				.set("province", province).set("limitdays", limitdays)
				.set("dpwd", dpwd).save();
	}

	@Override
	public Page<Dealer> dealerList(int curPage, int pageSize) {
		return Dealer.dao.dealerList(curPage, pageSize);
	}

	@Override
	public Dealer findById(int did) {
		return Dealer.dao.findById(did);
	}

	@Override
	public void updateDealer(int did, String dname, long phone,
			String province, int limitdays) {
		Dealer.dao.findById(did).set("dname", dname).set("phone", phone)
				.set("province", province).set("limitdays", limitdays).update();
	}

	@Override
	public void deleteDealer(int did) {
		Dealer.dao.deleteById(did);
	}
}
