package com.vanroid.transopt.uitls;

import java.io.File;

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
	public File createExcelTemplate(String name);
}
