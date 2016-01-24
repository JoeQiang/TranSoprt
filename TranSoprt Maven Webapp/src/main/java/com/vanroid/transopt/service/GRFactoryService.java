package com.vanroid.transopt.service;

import com.vanroid.transopt.model.GRFactory;

/**
 * 经销商服务层接口
 * 
 * @author Joe_Huang
 * 
 */
public interface GRFactoryService {
	/**
	 * 港荣厂家登录
	 * 
	 * @param factory
	 *            厂家实体
	 * @return
	 */
	public boolean doLogin(GRFactory factory);

	/**
	 * 港荣厂家根据名称查询
	 * 
	 * @param username
	 *            厂家帐号
	 * @return
	 */
	public GRFactory getByName(String username);
}
