package com.vanroid.transopt.uitls;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;

public class Constant {
	private static Logger logger = Logger.getLogger(Constant.class);
	// Excel单元格数据类型
	public static final String CELL_TYPE_STRING = "string";
	public static final String CELL_TYPE_DATE = "date";
	public static final String CELL_TYPE_NUMERIC = "numeric";
	// 用户权限
	public static final String USER_TYPE_ADMIN = "admin";
	public static final String USER_TYPE_FACTORY = "factory";
	public static final String USER_TYPE_DEALER = "dealer";
	// 操作类型
	public static final String OPERATION_TYPE_INSERT = "insert";
	public static final String OPERATION_TYPE_UPDATE = "update";
	public static final String OPERATION_TYPE_DELETE = "delete";
	// 时间判断
	public static final int DAY_TYPE_CREATE = 1;
	public static final int DAY_TYPE_SEND = 2;
	public static final int DAY_TYPE_ARRIVED = 3;
	// 搜索条件
	public static final int SEARCH_TYPE_PROVINCE = 4;
	public static final int SEARCH_TYPE_NUM = 5;
	public static final int SEARCH_TYPE_GNAME = 6;
	public static final int SEARCH_TYPE_SNAME = 7;
	public static final int SEARCH_TYPE_STATUS = 8;
	public static final int SEARCH_TYPE_SUQNUM = 9;
	public static final int SEARCH_TYPE_DNAME = 10;
	public static final int SEARCH_TYPE_PHONE = 11;
	
	//过滤筛选
	public static final String SEARCH_FILTER = "filter";
	public static final String ORDER_STATUS = "未发货";
	
	public static String concatDate(String date) {
		StringBuilder formateDate = new StringBuilder(date).append(" 00:00:00");
		// DateFormat formater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// Date nDate = null;
		// try {
		// nDate = formater.parse(formateDate.toString());
		// } catch (ParseException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		return formateDate.toString();
	}

	/**
	 * 拼接字符串
	 * 
	 * @return
	 */
	public static String concat(Date date, int id) {

		String[] dates = new SimpleDateFormat("yyyy-MM-dd").format(date).split(
				"-");
		StringBuilder fomatDate = new StringBuilder();
		for (int i = 0; i < dates.length; i++) {
			fomatDate.append(dates[i]);
		}
		String oid = String.valueOf(id);
		String seqNum = "";
		switch (oid.length()) {
		case 1:
			seqNum = "00".concat(oid);
			break;
		case 2:
			seqNum = "0".concat(oid);
			break;
		default:
			seqNum = oid;
			break;
		}
		StringBuilder seq = new StringBuilder(fomatDate).append(seqNum);
		logger.info("序号:" + seq.toString());
		logger.debug("序号:" + seq.toString());
		return seq.toString();
	}
}
