package com.vanroid.transopt.model;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * 港荣的经销商实体类
 * 
 * @author Jerry
 * 
 */
public class Dealer extends Model<Dealer> {

	public static final Dealer dao = new Dealer();

	public Page<Dealer> dealerList(int curPage, int pageSize) {
		Page<Dealer> dealerPage = dao.paginate(curPage, pageSize, "select *",
				"from dealer where 1=1 order by did asc");
		return dealerPage;
	};
}
