package com.vanroid.transopt.controller;

import java.util.List;

import org.apache.log4j.Logger;

import com.jfinal.aop.Before;
import com.jfinal.aop.Duang;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
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
	Logger logger = Logger.getLogger(GoodsControlller.class);

	// 获取商品列表
	public void list() {
		int pageNum = getParaToInt("page");
		Page<GRGoods> page = gs.getPage(pageNum);
		List<GRGoods> list = page.getList();
		setAttr("goodslist", list);
		setAttr("totalPage", page.getTotalPage());// 多少页
		setAttr("pageNum", page.getPageNumber());// 当前页
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
		redirect("/goods/list?page=1");

	}

	// 修改商品ajax
	
	public void updgoods() {
		gs.updateByGid(getParaToInt("gid"), getPara("gname"),
				getParaValuesToInt("weight"));
		redirect("/goods/list?page="+getParaToInt("page"));
	}

	// 增加商品规格
	public void addsta() {
		gs.addSta(getPara("sname"));
		redirect("/goods/list?page=1");
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

	// 查询某个商品下的所有规格ajax
	public void getstabygid() {
		GRGoods goods = GRGoods.dao.findById(getParaToInt("gid"));
		goods.getStandard();
		renderJson(goods);
	}

}
