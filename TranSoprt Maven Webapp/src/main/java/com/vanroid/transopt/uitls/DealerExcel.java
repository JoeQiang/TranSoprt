package com.vanroid.transopt.uitls;

public class DealerExcel extends BaseExcel {

	@Override
	public String sheetName() {
		// TODO Auto-generated method stub
		return "经销商批量导入";
	}

	@Override
	public String[] cellKeys() {
		return new String[] { "dname", "phone", "province", "limitdays" };
	}
}
