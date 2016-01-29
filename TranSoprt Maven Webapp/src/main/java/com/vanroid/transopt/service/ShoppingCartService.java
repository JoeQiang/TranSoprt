package com.vanroid.transopt.service;

import java.util.List;

import com.vanroid.transopt.model.ShoppingCart;

/**
 * 经销商客户端的购物车业务类
 * 
 * @author Jerry
 * 
 */
public class ShoppingCartService {
	/**
	 * 商品数量在购物车中的变化 每天每个经销商只能下一单
	 * 
	 * @param shoppingCart
	 */
	public void upInCart(int did, int gid, int sid, int num) {

	}

	/**
	 * 根据经销商did获取购物车内容
	 * 
	 * @param did
	 * @return
	 */
	public List<ShoppingCart> showShoppingCart(int did) {
		return ShoppingCart.dao.find("select * from shoppingcart where did=?",
				did);

	}

	/**
	 * 删除单个购物项
	 * 
	 * @param shid
	 */
	public void deleteOne(int shid) {
		ShoppingCart.dao.deleteById(shid);
	}

	/**
	 * 清空购物车
	 * 
	 * @param did
	 */
	public void deleteAll(int did) {
		List<ShoppingCart> list = ShoppingCart.dao.find(
				"select * from shoppingcart where did=?", did);
		for (ShoppingCart shoppingCart : list) {
			shoppingCart.delete();
		}
	}
}