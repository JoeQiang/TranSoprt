package com.vanroid.transopt.service;

import com.vanroid.transopt.model.Dealer;

/**
 * 经销商服务层接口
 * 
 * @author Joe_Huang
 * 
 */
public interface DealerService {
	/**
	 * 经销商登陆
	 * 
	 * @param dealer
	 *            经销商实体
	 * @return
	 */
	public boolean doLogin(Dealer dealer);

	/**
	 * 根据名称查找经销商
	 * 
	 * @param username
	 * @return
	 */
	public Dealer getByName(String username);

}
