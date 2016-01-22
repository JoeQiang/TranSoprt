package com.vanroid.transopt.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

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
		put("dealer",dealer);
		return dealer;
	}

	// 负责该订单发货的厂家
	public GRFactory getFactory() {
		try{
			GRFactory factory = GRFactory.dao.findById(getInt("oid"));
			put("factoryname",factory.get("fname"));
			return factory;
		}catch(NullPointerException e){
			 return null;
		}

	}
	//订单下所有货物的种类，规格和数量
	public List<HashMap<String, Object>> getGoods() {
		List<HashMap<String, Object>> goods = new ArrayList<HashMap<String, Object>>();
		String sql="select og.num,g.gname,s.sname from order_goods og inner join grgoods g inner join standard s where og.oid=? and s.sid=og.sid and g.gid=og.gid";
		List<Record> list=Db.find(sql,getInt("oid"));
		for (Record record : list) {
			HashMap<String,Object> map=new HashMap<String,Object>();
			map.put("gname", record.getStr("gname"));
			map.put("sname", record.getStr("sname"));
			map.put("num", record.getInt("num"));
			goods.add(map);
		}
		put("goodsList",goods);
		return goods;
	}

}
