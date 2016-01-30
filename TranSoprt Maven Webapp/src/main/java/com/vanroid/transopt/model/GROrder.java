package com.vanroid.transopt.model;

import java.util.HashMap;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.vanroid.transopt.uitls.Constant;

/**
 * 港荣订单的实体类
 * 
 * @author Jerry
 * 
 */
public class GROrder extends Model<GROrder> {

	public static final GROrder dao = new GROrder();

	// 该订单的发起经销商
	public Dealer getDealer() {
		Dealer dealer = Dealer.dao.findById(getInt("dealerid"));
		put("dealer", dealer);
		return dealer;
	}

	// 根据省份查询经销商
	public Dealer getDealer(String province) {
		String sql = "select * from dealer where did = ? and province like ?";
		List<Dealer> list = Dealer.dao.find(sql, getInt("dealerid"), "%"
				+ province + "%");
		if (list.size() == 0) {
			return null;
		}
		Dealer dealer = list.get(0);
		put("dealer", dealer);
		return dealer;

	}

	// 负责该订单发货的厂家
	public GRFactory getFactory() {
		try {
			GROrder order = GROrder.dao.findById(getInt("oid"));
			GRFactory factory = GRFactory.dao.findById(order
					.getInt("factoryid"));
			put("factoryname", factory.get("fname"));
			return factory;
		} catch (NullPointerException e) {
			return null;
		}

	}

	/*
	 * // 订单下所有货物的种类，规格和数量 public List<HashMap<String, Object>> getGoods() {
	 * List<HashMap<String, Object>> goods = new ArrayList<HashMap<String,
	 * Object>>(); String sql =
	 * "select og.num,g.gname,s.sname from order_goods og inner join grgoods g inner join standard s where og.oid=? and s.sid=og.sid and g.gid=og.gid"
	 * ; List<Record> list = Db.find(sql, getInt("oid")); for (Record record :
	 * list) { HashMap<String, Object> map = new HashMap<String, Object>();
	 * map.put("gname", record.getStr("gname")); map.put("sname",
	 * record.getStr("sname")); map.put("num", record.getInt("num"));
	 * goods.add(map); } put("goodsList", goods); return goods; }
	 */
	/**
<<<<<<< HEAD
	 * 得到商品名称
=======
	 * 
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
	 * 
	 * @return
	 */
	public String getGoodName() {
		GRGoods good = GRGoods.dao.findFirst(
				"select gname from grgoods where gid=?", getInt("gid"));
		put("gname", good.getStr("gname"));
		return good.getStr("gname");
	}

	/**
<<<<<<< HEAD
=======
	 * 根据搜索模糊查询品类名
	 * 
	 * @param search
	 * @return
	 */
	public String getGoodName(String search) {
		List<GRGoods> list = GRGoods.dao.find(
				"select gname from grgoods where gid=? and gname like ?",
				getInt("gid"), "%" + search + "%");
		if (list.size() != 0) {
			GRGoods good = list.get(0);
			put("gname", good.getStr("gname"));
			return good.getStr("gname");
		}
		return null;
	}

	/**
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
	 * 获取重量规格名称
	 * 
	 * @return
	 */
	public String getStandardName() {
		Standard standard = Standard.dao.findFirst(
<<<<<<< HEAD
				"select sid,sname from standard where sid=?", getInt("sid"));
		put("sid", standard.getInt("sid"));
		put("sname", standard.getStr("sname"));
		return standard.getStr("sname");
=======
				"select sname from standard where sid=?", getInt("sid"));
		put("sname", standard.getStr("sname"));
		return standard.getStr("sname");
	}

	/**
	 * 根据查询结果模糊查询规格量
	 * 
	 * @param search
	 * @return
	 */
	public String getStandardName(String search) {
		List<Standard> list = Standard.dao.find(
				"select sname from standard where sid=? and sname like ?",
				getInt("sid"), search + "%");
		if (list.size() != 0) {
			Standard standard = list.get(0);
			put("sname", standard.getStr("sname"));
			return standard.getStr("sname");
		}
		return null;
	}

	public long getCountOfRecord(int option, String search) {
		StringBuilder sql = new StringBuilder();
		long count = 0;
		if (Constant.SEARCH_TYPE_GNAME == option) {
			sql.append(" select count(*) from grorder,grgoods ")
					.append(" where grorder.gid = grgoods.gid ")
					.append(" and grorder.factoryid = ? ")
					.append(" and grgoods.gname like ?");
		} else if (Constant.SEARCH_TYPE_PROVINCE == option) {
			sql.append(" select count(*) from grorder,dealer ")
					.append(" where grorder.dealerid = dealer.did ")
					.append(" and grorder.factoryid=? ")
					.append(" and dealer.province like ? ");
			// GROrder order = GROrder.dao.findById(getInt("oid"));
		} else if (Constant.SEARCH_TYPE_SNAME == option) {
			sql.append(" select count(*) from grorder,standard ")
					.append(" where grorder.sid = standard.sid ")
					.append(" and grorder.factoryid = ? ")
					.append(" and grorder.sid = ? ")
					.append(" and standard.sname like ? ");
		}
		count = Db.queryLong(sql.toString(), getInt("factoryid"),
				getInt("sid"), "%" + search + "%");
		return count;
>>>>>>> 8a252c50ec55153ff486ad7a4a233ce1b0aedeb2
	}

	/**
	 * 触发三个方法，将数据put到GROrder的实例里面
	 */
	public void getAttrFromOtherTable() {
		getGoodName();
		getStandardName();
		getFactory();
		getDealer();
	}

	// 下订单
	public void setGoods(List<HashMap<String, Object>> list) {
		for (HashMap<String, Object> map : list) {
			Record record = new Record().set("oid", getInt("oid"))
					.set("gid", map.get("gid")).set("sid", map.get("sid"))
					.set("num", map.get("num"));
			Db.save("shoppingcart", "did", record);
		}

	}

}