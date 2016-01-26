package com.vanroid.transopt.service;

import java.io.IOException;

import com.jfinal.plugin.activerecord.Page;
import com.taobao.api.ApiException;
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
	public int doLogin(String phone,String pwd);

	/**
	 * 根据名称查找经销商
	 * 
	 * @param username
	 * @return
	 */
	public Dealer getByName(String username);

	/**
	 * 单独新增经销商
	 * 
	 * @param dname
	 * @param dpwd
	 * @param phone
	 * @param province
	 * @param limitdays
	 */
	public void saveDealer(String dname, String dpwd, long phone,
			String province, int limitdays);

	/**
	 * 列表显示经销商
	 * 
	 * @param curPage
	 * @param pageSize
	 * @return
	 */
	public Page<Dealer> dealerList(int curPage, int pageSize);

	/**
	 * 根据did查找经销商
	 * 
	 * @param did
	 * @return
	 */
	public Dealer findById(int did);

	/**
	 * 更新经销商信息
	 * 
	 * @param did
	 * @param dname
	 * @param phone
	 * @param province
	 * @param limitdays
	 */
	public void updateDealer(int did, String dname, long phone,
			String province, int limitdays);

	/**
	 * 删除经销商信息
	 * 
	 * @param did
	 */
	public void deleteDealer(int did);
	public void getDynamPwd(String phone) throws IOException, ApiException ;
}