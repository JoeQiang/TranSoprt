package com.vanroid.transopt.model;

import java.util.Map;

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

	public Dealer() {
	}

	public Dealer(Map<String, Object> arrtubite) {
		Dealer dealer = new Dealer();
		dealer.set("dname", (String) arrtubite.get("dname"));
		dealer.set("phone", (Long) arrtubite.get("phone"));
		dealer.set("limitdays", (Integer) arrtubite.get("limitdays"));
		dealer.set("province", (String) arrtubite.get("province"));
	}

	public Page<Dealer> dealerList(int curPage, int pageSize) {
		Page<Dealer> dealerPage = dao.paginate(curPage, pageSize, "select *",
				"from dealer where 1=1 order by did desc");
		return dealerPage;
	};
}
