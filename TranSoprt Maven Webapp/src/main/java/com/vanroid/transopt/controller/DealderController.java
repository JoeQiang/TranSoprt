package com.vanroid.transopt.controller;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;
import com.vanroid.transopt.interceptor.DealerValidate;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.service.DealerService;
import com.vanroid.transopt.service.DealerServiceImp;
import com.vanroid.transopt.uitls.MD5Utils;

public class DealderController extends Controller {
	private DealerService service = new DealerServiceImp();

	public void index() {
		Integer pageNumber = getParaToInt(0);
		Integer pageSize = getParaToInt(1);
		if (pageNumber == null || pageNumber <= 0) {
			pageNumber = 1;
		}
		if (pageSize == null || pageSize == 0) {
			pageSize = 10;
		}
		Page<Dealer> pager = service.dealerList(pageNumber, pageSize);
		setAttr("pager", pager);
		render("/jsp/dealder_manager.jsp");
	}

	/**
	 * 跳转经销商插入页
	 */
	public void insert_page() {
		render("/jsp/dealder_insert.jsp");
	}

	/**
	 * 单条保存经销商信息
	 */
	@Before(DealerValidate.class)
	public void singleInsert() {
		String dname = getPara("dname");
		long phone = getParaToLong("phone");
		String province = getPara("province");
		int limitdays = getParaToInt("limitdays");
		String dpwd = MD5Utils.MD5("123456");
		service.saveDealer(dname, dpwd, phone, province, limitdays);
		forwardAction("/manager/dealer");
	}

	// Excel批量保存经销商信息
	public void excelInsert() {
		UploadFile file = getFile("excelfile", PathKit.getWebRootPath()
				+ "/upload");
		renderText("file:" + file.getFileName());
	}

	/**
	 * 跳转经销商详情页
	 */
	public void detial() {
		int did = getParaToInt("did");
		Dealer dealer = service.findById(did);
		setAttr("dealer", dealer);
		render("/jsp/dealder_show.jsp");
	}

	/**
	 * 跳转更新经销商页面
	 */
	public void update() {
		int did = getParaToInt("did");
		Dealer dealer = service.findById(did);
		setAttr("dealer", dealer);
		render("/jsp/dealder_update.jsp");
	}

	/**
	 * 执行更新经销商操作
	 */
	@Before(DealerValidate.class)
	public void doUpdate() {
		int did = getParaToInt("did");
		String dname = getPara("dname");
		long phone = getParaToLong("phone");
		String province = getPara("province");
		int limitdays = getParaToInt("limitdays");
		service.updateDealer(did, dname, phone, province, limitdays);
		forwardAction("/manager/dealer");
	}

	/**
	 * 删除供应商操作
	 */
	public void delete() {
		int did = getParaToInt("did");
		service.deleteDealer(did);
		forwardAction("/manager/dealer");
	}

}