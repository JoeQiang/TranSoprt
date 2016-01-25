package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.service.GRFactoryService;
import com.vanroid.transopt.service.GRFactoryServiceImp;

/**
 * 厂家控制类
 * 
 * @author Joe_Huang
 * 
 */
public class GRFactoryController extends Controller {

	private GRFactoryService service = new GRFactoryServiceImp();

	public void manager() {
		int pageNum = getParaToInt(0);
		if (pageNum <= 0) {
			pageNum = 1;
		}
		Page<GRFactory> pager = service.getFactoryList(pageNum);
		setAttr("pager", pager);
		render("/jsp/factory_manager.jsp");
	}

	/**
	 * 跳转账号设置页面
	 */
	public void setting() {
		int pageNum = getParaToInt(0);
		if (pageNum <= 0) {
			pageNum = 1;
		}
		Page<GRFactory> pager = service.getFactoryList(pageNum);
		setAttr("pager", pager);
		render("/jsp/acount_setting.jsp");
	}

	/**
	 * 保存修改账号
	 */
	public void saveFactory() {
		String fname = getPara("fname");
		String fpwd = getPara("fpwd");
		String rpwd = getPara("rpwd");
		boolean flag = service.saveFactory(fname, fpwd);
		renderJson("info", flag);
	}

	/**
	 * 更新账号
	 */
	public void updateFactory() {
		int fid = getParaToInt("fid");
		String fname = getPara("fname");
		String fpwd = getPara("fpwd");
		boolean flag = service.updateFactory(fid, fname, fpwd);
		renderJson("info", flag);
	}

	public void getFactoryById() {
		int fid = getParaToInt("fid");
		GRFactory factory = service.getFactoryById(fid);
		renderJson(factory.toJson());
	}

}
