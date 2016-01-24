package com.vanroid.transopt.service;

import com.vanroid.transopt.model.Admin;

public interface AdminService {
	/**
	 * 帐号登录操作
	 * 
	 * @param user
	 * @return
	 */
	public boolean doLogin(Admin admin);

	/**
	 * 根据用户名取得用户信息
	 * 
	 * @param username
	 * @return
	 */
	public Admin getByName(String username);
}
