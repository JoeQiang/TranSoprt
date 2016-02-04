package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;
import com.vanroid.transopt.model.Public;
/**
 * 公告控制器
 * @author Jerry
 *
 */
public class PublicController extends Controller {
	public void index() {
		setAttr("li_id", "li_public");
		setAttr("cont", Public.dao.findById(1).getStr("content"));
		render("/jsp/public.jsp");
	}
	//公布栏上的内容更新ajax
	public void update(){
		boolean success=Public.dao.findById(1).set("content", getPara("content")).update();
		if(success)
			renderJson(1);
		else
			renderJson(0);
	}
}
