package com.vanroid.transopt.service;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.model.Standard;

/**
 * 商品管理业务逻辑类crud
 * 
 * @author Jerry
 * 
 */
public class GoodsManageService {
	static Logger logger = Logger.getLogger(GoodsManageService.class);

	/**
	 * 
	 * 创建商品，同时添加规格，在一个事务中
	 */
	@Before(Tx.class)
	public boolean createGoods(String gname, Integer[] sids) {
		List<GRGoods> list = GRGoods.dao.find(
				"select * from grgoods where gname=?", gname);
		if (list.size() > 0)
			return false;
		new GRGoods().set("gname", gname).save();
		// logger.info("插入1成功");
		GRGoods g = GRGoods.dao.findFirst(
				"select gid from grgoods where gname=?", gname);
		logger.info("gid:" + g.getInt("gid"));
		for (int sid : sids) {
			Record r = new Record().set("gid", g.getInt("gid")).set("sid", sid);
			Db.save("goods_standard", r);
		}
		return true;
	}

	@Before(Tx.class)
	public void delectByGid(int gid) {
		GRGoods.dao.deleteById(gid);
		// Db.deleteById("goods_standard", gid); //数据库已经做了级联
	}

	@Before(Tx.class)
	public void updateByGid(int gid, String gname, Integer[] sids) {
		GRGoods goods = GRGoods.dao.findById(gid);
		goods.set("gname", gname).update();
		List<Record> list = Db.find(
				"select sid from goods_standard where gid=?", gid);
		int[] dbsids = new int[list.size()];// 数据库中的
		int i = 0;
		for (Record record : list) {
			dbsids[i++] = record.getInt("sid");
		}
		// 新的中有的，旧的没有-->插入数据库
		// 新的中没有的，旧的有的-->删除数据库国
		for (int j = 0; j < dbsids.length; j++) {
			if (!ArrayUtils.contains(sids, dbsids[j])) {
				Db.deleteById("goods_standard", "gid,sid", gid, dbsids[j]);
			}
		}
		for (int j = 0; j < sids.length; j++) {
			if (!ArrayUtils.contains(dbsids, sids[j])) {
				Record re = new Record().set("sid", sids[j]).set("gid", gid);
				Db.save("goods_standard", "gid, sid", re);
			}
		}
	}

	/**
	 * 获取全部的商品
	 * 
	 * @return
	 */
	public List<GRGoods> getAllGoods() {
		return GRGoods.dao.find("select * from grgoods");
	}

	/**
	 * 分页显示商品列表
	 * 
	 * @param index
	 *            从第几个开始
	 * @return
	 */
	public Page<GRGoods> getPage(int index) {
		Page<GRGoods> page = GRGoods.dao.paginate(index, 10, "select *",
				"from grgoods order by gid desc");
		for (GRGoods goods : page.getList()) {
			/**
			 * 注意！！！这里要触发获取商品规格的方法，将商品规格put进属性里， 否则el找不到规格属性（规格不属于数据库中）
			 */
			goods.getStandard();
		}
		return page;
	}

	/**
	 * 删除某个商品下的某个规格
	 * 
	 * @param gid
	 * @param sid
	 */
	public void delSta(int gid, int sid) {
		Db.deleteById("goods_standard", "gid,sid", gid, sid);
	}

	/**
	 * 增加商品规格
	 * 
	 * @param sta
	 */
	public void addSta(String sta) {
		Standard s = Standard.dao.findFirst(
				"select count(*) from standard where sname=?", sta);
		if (s.getLong("count(*)") == 0)
			new Standard().set("sname", sta).save();
	}

	/**
	 * 获取全局规格
	 * 
	 * @return
	 */
	public List<Standard> getAllSta() {
		return Standard.dao.find("select * from standard");
	}

	/**
	 * 删除全局规格中某一个
	 * 
	 * @param sid
	 */
	public void delGrobleSta(int sid) {
		Standard.dao.deleteById(sid);
	}

	/**
	 * 得到指定商品信息
	 * 
	 * @return
	 */
	public GRGoods getGoods(int gid) {
		return GRGoods.dao.findById(gid);
	}
}