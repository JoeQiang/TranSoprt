package com.vanroid.transopt.uitls;

/**
 * 经销商批量增加模板
 * 
 * @author Joe_Huang
 * 
 */
public class DealerExcel extends BaseExcel {

	@Override
	public String sheetName() {
		// TODO Auto-generated method stub
		return "经销商批量导入";
	}

	@Override
	public String[] colunmName() {
		String[] columnName = { "dname", "phone", "province", "limitdays" };
		return columnName;
	}
}
