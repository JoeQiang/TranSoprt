package com.vanroid.transopt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.interceptor.DealerLoginInterceptor;
import com.vanroid.transopt.interceptor.LoginInterceptor;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.model.Public;
import com.vanroid.transopt.model.Standard;
import com.vanroid.transopt.service.GoodsManageService;
import com.vanroid.transopt.service.PublicService;

/**
 * 商品管理的action类
 * 
 * @author Jerry
 * 
 */
@Before(LoginInterceptor.class)
public class GoodsControlller extends Controller {
	private GoodsManageService gs = Duang.duang(GoodsManageService.class);
	Logger logger = Logger.getLogger(GoodsControlller.class);

	// 经销商客户端下单页面，即显示所有的货物和规格
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void totalgoods() {
		List<GRGoods> allGoods = gs.getAllGoods();
		List<HashMap<String, Object>> standard=null;
		try{
	standard = allGoods.get(0).getStandard();
		
		}catch(Exception e){
			standard=new ArrayList<HashMap<String,Object>>();
		}
		setAttr("g1standard", standard);
		setAttr("allgoods", allGoods);
		setAttr("info_public",Public.dao.findById(1).getStr("content"));
		render("/jsp/booking.jsp");
	}

	// 根据gid显示所有的重量规格ajax
	@Clear(LoginInterceptor.class)
	@Before(DealerLoginInterceptor.class)
	public void getStandardByGid() {
		List<HashMap<String, Object>> standard = GRGoods.dao.findById(
				getParaToInt(0)).getStandard();
		renderJson(standard);
	}

	// 获取商品列表
	public void list() {
		int pageNum = getParaToInt(0);
		Page<GRGoods> page = gs.getPage(pageNum);
		List<GRGoods> list = page.getList();
		setAttr("goodslist", list);
		setAttr("totalPage", page.getTotalPage());// 多少页
		setAttr("pageNum", page.getPageNumber());// 当前页
		setAttr("li_id","li_goods");
		render("/jsp/goods_manage.jsp");
	}

	// ajax删除商品
	public void delete() {
		try {
			gs.delectByGid(getParaToInt(0));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}

	// ajax删除商品下某个规格
	public void delsta() {
		try {
			gs.delSta(0, 1);
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}

	// 添加商品
	public void addgoods() {
		try {
			gs.createGoods(getPara("gname"), getParaValuesToInt("weight"));
		} catch (NullPointerException e) {
			gs.createGoods(getPara("gname"), null);
		}
		redirect("/goods/list/1");

	}

	// 修改商品ajax

	public void updgoods() {
		try {
			gs.updateByGid(getParaToInt("gid"), getPara("gname"),
					getParaValuesToInt("weight"));
		} catch (NullPointerException e) {
			gs.updateByGid(getParaToInt("gid"), getPara("gname"), null);
		}
		redirect("/goods/list/" + getParaToInt("page"));
	}

	// 增加商品规格
	public void addsta() {
		gs.addSta(getPara("sname"));
		redirect("/goods/list/1");
	}

	// 查询所有的规格ajax
	public void getallsta() {
		List<Standard> allSta = gs.getAllSta();
		renderJson(allSta);
	}

	// 删除某个规格ajax
	public void delgroblesta() {
		try {
			gs.delGrobleSta(getParaToInt(0));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}

	// 查询某个商品下的所有规格ajax
	public void getstabygid() {
		GRGoods goods = GRGoods.dao.findById(getParaToInt(0));
		goods.getStandard();
		renderJson(goods);
	}

}