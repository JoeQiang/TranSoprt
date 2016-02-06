package com.vanroid.transopt.service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
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
	public List<GROrder> searchOrder(String operation, int fid, int option,
			String search) {
		StringBuilder sql = new StringBuilder(
				" select * from grorder,grfactory,dealer,standard,grgoods ")
				.append(" where 1=1 and grorder.dealerid = dealer.did ")
				.append(" and grorder.factoryid = grfactory.fid and grorder.gid = grgoods.gid  ")
				.append(" and grorder.sid = standard.sid");
		List<Object> params = new ArrayList<Object>();
		if (fid > 0) {
			sql.append("  and grorder.factoryid = ?  ");
			params.add(fid);
		}
		if (operation != null && operation.equals(Constant.SEARCH_FILTER)) {
			sql.append(" and grorder.status = ?");
			params.add(Constant.ORDER_STATUS);
		}
		switch (option) {
		case Constant.SEARCH_TYPE_GNAME:
			sql.append(" and grgoods.gname like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_NUM:
			sql.append(" and grorder.num = ?");
			params.add(search);
			break;
		case Constant.SEARCH_TYPE_PROVINCE:
			sql.append(" and dealer.province like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_SNAME:
			sql.append(" and standard.sname like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_STATUS:
			sql.append(" and grorder.status like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_SUQNUM:
			sql.append(" and grorder.seqnum like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_DNAME:
			sql.append(" and dealer.dname like ?");
			params.add("%" + search + "%");
			break;
		case Constant.SEARCH_TYPE_PHONE:
			sql.append(" and dealer.phone like ?");
			params.add("%" + search + "%");
			break;
		default:
			break;
		}
		List<Record> records = Db.find(sql.toString(), params.toArray());
		List<GROrder> orders = new ArrayList<GROrder>();
		for (Record record : records) {
			Dealer dealer = new Dealer()
					.put("province", record.getStr("province"))
					.put("phone", Long.valueOf(record.getStr("phone")))
					.put("dname", record.getStr("dname"));
			GROrder order = new GROrder()
					.put("status", record.getStr("status"))
					.put("num", record.getInt("num"))
					.put("sendday", record.getDate("sendday"))
					.put("createtime", record.get("createtime"))
					.put("factoryname", record.getStr("fname"))
					.put("gname", record.get("gname"))
					.put("sname", record.get("sname")).put("dealer", dealer)
					.put("reqarrday", record.getInt("reqarrday"))
					.put("seqnum", record.getStr("seqnum"));
			orders.add(order);
		}
		return orders;

	}

	@Override
	public List<GROrder> dateOrder(String option, int fid, int type,
			String beginDay, String endDay) {
		StringBuilder sql = new StringBuilder(
				"select * from grorder where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if (fid > 0) {
			sql.append("and factoryid = ? ");
			params.add(fid);
		}
		if (option != null && option.equals(Constant.SEARCH_FILTER)) {
			sql.append(" and status = ? ");
			params.add(Constant.ORDER_STATUS);
		}
		if (Constant.DAY_TYPE_CREATE == type) {
			String edate = Constant.concatDate(endDay);
			String bdate = Constant.concatDate(beginDay);
			params.add(Timestamp.valueOf(bdate));
			params.add(Timestamp.valueOf(edate));
			sql.append(" and createtime between ? and ? ");
		} else if (Constant.DAY_TYPE_SEND == type) {
			params.add(beginDay);
			params.add(endDay);
			sql.append(" and sendday between ? and ? ");
		}
		List<GROrder> list = GROrder.dao.find(sql.toString(), params.toArray());
		for (GROrder order : list) {
			order.getAttrFromOtherTable();
		}
		return list;
	}
}
