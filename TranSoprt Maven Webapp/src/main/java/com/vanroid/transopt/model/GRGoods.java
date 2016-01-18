package com.vanroid.transopt.model;

import java.util.ArrayList;
import java.util.List;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class GRGoods extends Model<GRGoods> {
	private List<String> standard;// 商品的规格种类

	public List<String> getStandard() {
		List<String> list = new ArrayList<String>();
		// 从中间表中获取该类商品有的规格
		String sql = "select s.sname from goods_standard gs inner join standard s where gs.sid=s.sid and gs.gid=?";
		List<Record> std = Db.find(sql, get("gid"));
		for (Record record : std) {
			list.add(record.getStr("sname"));
		}
		return list;
	}

	public void setStandard(List<String> standard) {
		this.standard = standard;
	}

	public static final GRGoods dao = new GRGoods();
}
