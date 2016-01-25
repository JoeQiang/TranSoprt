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

	public void setTemplateName(String templateName);

	/**
	 * 解析Excel文件
	 * 
	 * @param file
	 * @return
	 */
	public List<Map<String, Object>> pasreExcel(File file);
}
