package com.vanroid.transopt.service;

import com.jfinal.plugin.activerecord.Page;
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

	/**
	 * 保存厂家
	 * 
	 * @param fname
	 * @param fpwd
	 * @return
	 */
	public boolean saveFactory(String fname, String fpwd);

	/**
	 * 分页取得厂家
	 * 
	 * @param pageNum
	 * @return
	 */
	public Page<GRFactory> getFactoryList(int pageNum);

	/**
	 * 根据Id获取Factory
	 * 
	 * @param fid
	 */
	public GRFactory getFactoryById(int fid);

	public boolean updateFactory(int fid, String fname, String fpwd);
}
