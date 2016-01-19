package com.vanroid.transopt.service;

import java.util.List;

import com.vanroid.transopt.model.GROrder;

/**
 * 订单管理的业务逻辑类
 * 
 * @author Jerry
 * 
 */
public class OrderManageService {
	/**
	 * 管理员管理的新下的订单
	 */
	public static List<GROrder> getNewOrder() {
		// 查询为分配厂家的订单
		String sql = "select * from grorder where factoryid is null";
		return GROrder.dao.find(sql);
	}

	/**
	 * 管理员管理的给新订单分配厂家 ajax 更新成功返回1，失敗返回0
	 */
	public static int distributeFactory(int oid, int fid) {
		try {
			new GROrder().findById(oid).set("factoryid", fid).update();
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 显示各厂家自己的订单
	 */
	public static List<GROrder> getOrderByFid(int fid) {
		String sql="select * from grorder where factoryid=?";
		return GROrder.dao.find(sql,fid);
	}

	/**
	 * 厂家账户下的经销商板块下的订单
	 */
	public static void getNewOrderByFid(int fid) {
	}

	/**
	 * 管理员下所有的订单
	 */
	public static List<GROrder> getAllOrder() {
		return GROrder.dao.find("select * from grorder");
	}
}
