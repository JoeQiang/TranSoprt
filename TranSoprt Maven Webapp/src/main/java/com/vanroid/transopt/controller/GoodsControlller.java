package com.vanroid.transopt.controller;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.service.GoodsManageService;

/**
 * 商品管理的action类
 * 
 * @author Jerry
 * 
 */
public class GoodsControlller extends Controller {
	private GoodsManageService gs = new GoodsManageService();

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
				gs.delSta(getParaToInt("gid"),getParaToInt("sid"));
				renderJson(1);
			} catch (Exception e) {
				renderJson(0);
			}
		}
		//添加商品
		public void addgoods(){
			gs.createGoods(getPara("gname"),getParaValuesToInt("weight"));
			redirect("/goods/list");
			
		}
}
