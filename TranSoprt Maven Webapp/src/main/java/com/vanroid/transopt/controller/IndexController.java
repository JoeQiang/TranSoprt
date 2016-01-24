package com.vanroid.transopt.controller;

import com.jfinal.core.Controller;

public class IndexController extends Controller {
	public void index() {
		render("/jsp/index.jsp");
	}
}
