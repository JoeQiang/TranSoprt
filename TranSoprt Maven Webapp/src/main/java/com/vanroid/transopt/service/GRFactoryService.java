package com.vanroid.transopt.service;

import java.util.List;

import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;

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

	public Page<GROrder> getFactoryOrder(int pageNum, int fid);
	//取得所有的order
	public List<GROrder> getAllOrders(int fid, String filter, String search);
	//得到下载的list
	public List<GROrder> getDownloadOrder(Integer[] oid);
	//条件查询
	public List<GROrder> searchOrder(int fid, int option, String search);
	
	public List<GROrder> dateOrder(int fid,int type,String beginDay,String endDay);
}
