package com.vanroid.transopt.controller;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.model.Standard;
import com.vanroid.transopt.service.GoodsManageService;

/**
 * 商品管理的action类
 * 
 * @author Jerry
 * 
 */
public class GoodsControlller extends Controller {
	private GoodsManageService gs = Duang.duang(GoodsManageService.class);

	// 获取商品列表
	public void list() {
		Page<GRGoods> page = gs.getGoodsFrom(1);
		List<GRGoods> list = page.getList();
		setAttr("goodslist", list);
		render("/jsp/goodsmanage.jsp");
	}

	// ajax删除商品
	public void delete() {
		try {
			gs.delectByGid(getParaToInt("gid"));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}

	// ajax删除商品下某个规格
	public void delsta() {
		try {
			gs.delSta(getParaToInt("gid"), getParaToInt("sid"));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}

	// 添加商品
	public void addgoods() {
		gs.createGoods(getPara("gname"), getParaValuesToInt("weight"));
		redirect("/goods/list");

	}
	//修改商品ajax
	public void updgoods(){
		gs.updateByGid(getParaToInt("gid"), getPara("gname"), getParaValuesToInt("weight"));
		redirect("/goods/list");
	}
	// 增加商品规格
	public void addsta() {
		gs.addSta(getPara("sname"));
		redirect("/goods/list");
	}

	// 查询所有的规格ajax
	public void getallsta() {
		List<Standard> allSta = gs.getAllSta();
		renderJson(allSta);
	}

	// 删除某个规格ajax
	public void delgroblesta() {
		try {
			gs.delGrobleSta(getParaToInt("sid"));
			renderJson(1);
		} catch (Exception e) {
			renderJson(0);
		}
	}
	//查询某个商品下的所有规格ajax
	public void getstabygid(){
		GRGoods goods=GRGoods.dao.findById(getParaToInt("gid"));
		goods.getStandard();
		renderJson(goods);
	}
	

}
