package com.vanroid.transopt.controller;

import java.io.File;

import org.dom4j.DocumentException;

import com.jfinal.core.Controller;
import com.vanroid.transopt.uitls.ExcelTemplateFactory;

public class UpDownloadController extends Controller {
	// 上传Excel模版
	public void upload() {

	}

	// 下载Excel模版
	public void supplierTemplate() {
		try {
			File file = ExcelTemplateFactory.getInstance()
					.getTemplate("dealer").createExcelTemplate();
			renderFile(file);
		} catch (DocumentException e) {
			setAttr("error", "没有对应Excel模版下载");
			render("/jsp/dealder_insert.jsp");
			throw new RuntimeException("没有找到对应Excel模版", e);
		}
	}
}
