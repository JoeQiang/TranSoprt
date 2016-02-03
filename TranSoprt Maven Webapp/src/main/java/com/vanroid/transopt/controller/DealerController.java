package com.vanroid.transopt.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;
import com.taobao.api.ApiException;
import com.vanroid.transopt.interceptor.DealerLoginInterceptor;
import com.vanroid.transopt.interceptor.DealerValidate;
import com.vanroid.transopt.interceptor.LoginInterceptor;
import com.vanroid.transopt.interceptor.UploadExcelValidate;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.service.DealerService;
import com.vanroid.transopt.service.DealerServiceImp;
import com.vanroid.transopt.uitls.MD5Utils;

@Before(LoginInterceptor.class)
public class DealerController extends Controller {

	private DealerService service = Duang.duang(DealerServiceImp.class);

	@Clear(LoginInterceptor.class)
	public void login() {
		render("/jsp/dealer_login.jsp");

	}

	/**
	 * 根据手机号判断是否是经销商身份
	 */
	@Clear(LoginInterceptor.class)
	public void isdealer() {

		Dealer dealer = Dealer.dao.findFirst(
				"select * from dealer where phone=?", getPara(0));
		if (dealer == null)
			renderJson(0);
		else
			renderJson(1);
	}

	/**
	 * 经销商客户端登陆ajax
	 */
	@Clear(LoginInterceptor.class)
	public void logininput() {
		String phone = getPara("phone");
		int result = service.doLogin(phone, getPara("pwd"));
		if (result == 1) {
			setSessionAttr("user", phone);
		}
		renderJson(result);
	}

	/**
	 * 客端点注销
	 */
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void logout() {
		removeSessionAttr("user");
		redirect("/dealer/login");
	}

	/**
	 * 动态密码登陆ajax
	 * 
	 * @throws IOException
	 * @throws ApiException
	 */
	@Clear(LoginInterceptor.class)
	public void getdynamic() throws IOException, ApiException {

		int res = service.getDynamPwd(getPara(0));
		renderJson(res);
	}

	/**
	 * 跳转修改密码页面
	 */
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void changepwdpage() {
		render("/jsp/modify.jsp");
	}

	/**
	 * 修改固定密码ajax
	 */
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void changepwd() {
		int res = service.changePwd((String) getSessionAttr("user"),
				getPara("newPwd"));
		renderJson(res);

	}

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
		setAttr("li_id", "li_dealer");
		render("/jsp/dealder_manager.jsp");
	}

	/**
	 * 跳转经销商插入页
	 */
	public void insert_page() {
		setAttr("li_id", "li_dealer");
		render("/jsp/dealder_insert.jsp");
	}

	/**
	 * 保存经销商信息
	 */
	@Before(DealerValidate.class)
	public void singleInsert() {
		getSession().removeAttribute("token");
		String dname = getPara("dname");
		long phone = getParaToLong("phone");
		String province = getPara("province");
		int limitdays = getParaToInt("limitdays");
		String dpwd = MD5Utils.MD5("123456");
		service.saveDealer(dname, dpwd, phone, province, limitdays);
		forwardAction("/manager/dealer");
	}

	@Before(UploadExcelValidate.class)
	public void excelInsert() {
		UploadFile uploadFile = getFile("excel");
		File file = uploadFile.getFile();
		boolean validate = service.batchSaveDealer(file, getRequest());
		if (validate) {
			forwardAction("/manager/dealer");
		} else {
			render("/jsp/dealder_insert.jsp");
		}
	}

	/**
	 * 跳转经销商详情页
	 */
	public void detial() {
		int did = getParaToInt("did");
		Dealer dealer = service.findById(did);
		setAttr("dealer", dealer);
		setAttr("li_id", "li_dealer");
		render("/jsp/dealder_show.jsp");
	}

	/**
	 * 跳转更新经销商页面
	 */
	public void update() {
		int did = getParaToInt("did");
		Dealer dealer = service.findById(did);
		setAttr("dealer", dealer);
		setAttr("li_id", "li_dealer");
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

	public void checkpwd() {
		String phone = getPara("phone");
		Map<String, Object> map;
		if ("".equals(phone) || phone != null) {
			String sql = "select * from dealer where phone = ?";
			List<Dealer> list = Dealer.dao.find(sql, phone);
			map = new HashMap<String, Object>();
			int count = list.size();
			if (count != 0) {
				map.put("status", "error");
				map.put("msg", "该手机号码已经被注册,请更换！");
				renderJson(map);
			} else {
				map.put("status", "success");
				map.put("msg", "恭喜你！该手机号码还没有注册,可以使用");
				renderJson(map);
			}
		}
	}
}
