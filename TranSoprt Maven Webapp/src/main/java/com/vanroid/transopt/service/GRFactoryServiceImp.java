package com.vanroid.transopt.service;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.uitls.Constant;
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

	@Override
	public Page<GROrder> getFactoryOrder(int pageNum, int fid) {
		Page<GROrder> pager = GROrder.dao.paginate(pageNum, 5, "select *",
				"from grorder where factoryid =?", fid);
		for (GROrder order : pager.getList()) {
			order.getAttrFromOtherTable();
		}
		return pager;
	}

	@Override
	public List<GROrder> getAllOrders(int fid, String filter, String search) {
		List<GROrder> list = GROrder.dao.find(
				"select * from grorder where factoryid = ?", fid);
		for (GROrder order : list) {
			order.getAttrFromOtherTable();
		}
		return list;
	}

	@Override
	public List<GROrder> getDownloadOrder(Integer[] oid) {
		List<GROrder> list = new ArrayList<GROrder>();
		for (int i = 0; i < oid.length; i++) {
			GROrder order = GROrder.dao.findById(oid[i]);
			order.getAttrFromOtherTable();
			list.add(order);
		}
		return list;
	}

	/**
	 * 搜索筛选订单
	 */
	@Override
	public List<GROrder> searchOrder(int fid, int option, String search) {
		StringBuilder sql = new StringBuilder(
				"select * from grorder where factoryid = ? ");
		List<GROrder> list = null;
		// 根据省份模糊查找
		if (Constant.SEARCH_TYPE_PROVINCE == option) {
			Dealer dealer = null;
			list = GROrder.dao.find(sql.toString(), fid);
			for (GROrder order : list) {
				order.getGoodName();
				order.getStandardName();
				order.getFactory();
				dealer = order.getDealer(search);
			}
			if (dealer == null)
				list = null;
		}// 根据货品数量模糊查询
		else if (Constant.SEARCH_TYPE_NUM == option) {
			sql.append(" and num like ?");
			list = GROrder.dao.find(sql.toString(), fid, search + "%");
			for (GROrder order : list) {
				order.getAttrFromOtherTable();
			}
		}// 根据 货品品类模糊搜索
		else if (Constant.SEARCH_TYPE_GNAME == option) {
			String goodName = null;
			list = GROrder.dao.find(sql.toString(), fid);
			for (GROrder order : list) {
				goodName = order.getGoodName(search);
				order.getStandardName();
				order.getFactory();
				order.getDealer();
			}
			if (goodName == null)
				list = null;
		}// 根据货品规格进行模糊查询
		else if (Constant.SEARCH_TYPE_SNAME == option) {
			String standardName = null;
			list = GROrder.dao.find(sql.toString(), fid);
			for (GROrder order : list) {
				order.getGoodName();
				standardName = order.getStandardName(search);
				order.getFactory();
				order.getDealer();
			}
			if (standardName == null)
				list = null;
		}

		return list;
	}

	@Override
	public List<GROrder> dateOrder(int fid, int type, String beginDay,
			String endDay) {
		StringBuilder sql = new StringBuilder(
				"select * from grorder where factoryid = ? ");
		if (Constant.DAY_TYPE_ARRIVED == type) {
			sql.append("and arriveday between ? and ?");
		} else if (Constant.DAY_TYPE_CREATE == type) {
			sql.append("and createday between ? and ?");
		} else if (Constant.DAY_TYPE_SEND == type) {
			sql.append("and sendday between ? and ?");
		}
		List<GROrder> list = GROrder.dao.find(sql.toString(), fid, beginDay,
				endDay);
		for (GROrder order : list) {
			order.getAttrFromOtherTable();
		}
		return list;
	}
}
