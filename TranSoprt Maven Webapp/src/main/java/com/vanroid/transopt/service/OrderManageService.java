package com.vanroid.transopt.service;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;

/**
 * 订单管理的业务逻辑类
 * 
 * @author Jerry
 * 
 */
public class OrderManageService {
	/**
	 * 管理员管理的新下的订单的分页
	 */
	public  Page<GROrder> getNewOrderPage(int pageNum) {
		// 查询为分配厂家的订单
		Page<GROrder> page = GROrder.dao.paginate(pageNum, 10, "select *",
				"from grorder where factoryid is null");
		for (GROrder order : page.getList()) {
			order.getDealer();
//			order.getFactory();
			order.getGoods();
		}
		return page;
	}

	/**
	 * 管理员管理的给新订单分配厂家 ajax 更新成功返回1，失敗返回0
	 */
	@Before(Tx.class)
	public int distributeFactory(int oid, int fid) {
		try {
			new GROrder().findById(oid).set("factoryid", fid).update();
			new GROrder().set("status", "未发货").update();
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 显示各厂家自己的订单
	 */
	public  List<GROrder> getOrderByFid(int fid) {
		String sql="select * from grorder where factoryid=?";
		return GROrder.dao.find(sql,fid);
	}

	/**
	 * 厂家账户下的经销商板块下的订单
	 */
	public  void getNewOrderByFid(int fid) {
	}

	/**
	 * 管理员下所有的订单
	 */
	public List<GROrder> getAllOrder() {
		return GROrder.dao.find("select * from grorder");
	}
	/**
	 * 获取所有的厂家
	 * @return
	 */
	public List<GRFactory> getAllFactory(){
		return GRFactory.dao.find("select fid,fname from grfactory" );
	}
}
