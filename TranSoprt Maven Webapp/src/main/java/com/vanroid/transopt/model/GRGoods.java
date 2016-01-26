package com.vanroid.transopt.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class GRGoods extends Model<GRGoods> {
	
	public List<HashMap<String, Object>> getStandard() {
		String sql = "select s.sid,s.sname from goods_standard gs inner join standard s where gs.sid=s.sid and gs.gid=?";
		List<Record> std = Db.find(sql, get("gid"));
		List<HashMap<String,Object>> list=new ArrayList<HashMap<String,Object>>();
		for (Record record : std) {
			HashMap<String,Object> map=new HashMap<String,Object>();
			map.put("sname",record.getStr("sname"));
			map.put("sid", record.getInt("sid"));
			list.add(map);
		}
		put("standard", list);
		return list;
	}
	public static final GRGoods dao = new GRGoods();
}
