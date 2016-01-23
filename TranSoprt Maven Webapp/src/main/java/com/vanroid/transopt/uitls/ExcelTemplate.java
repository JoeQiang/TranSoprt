package com.vanroid.transopt.uitls;

import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * Excel模板操作接口
 * 
 * @author Joe_Huang
 * 
 */
public interface ExcelTemplate {
	/**
	 * 创建Excel模板文件
	 * 
	 * @return
	 */
	public File createExcelTemplate();

	/**
	 * 解析Excel文件，获取里面内容
	 * 
	 * @param file
	 * @return
	 */
	public List<Map<String, Object>> pasreExcel(File file);

	/**
	 * 设置模板名称
	 * 
	 * @param templateName
	 */
	public void setTemplateName(String templateName);
}
