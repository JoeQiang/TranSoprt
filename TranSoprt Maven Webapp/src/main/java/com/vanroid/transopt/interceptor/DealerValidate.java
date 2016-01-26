package com.vanroid.transopt.interceptor;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.service.DealerServiceImp;
import com.vanroid.transopt.uitls.Constant;

public class DealerValidate extends Validator {

	@Override
	protected void validate(Controller c) {
		validateRequired("dname", "dnameMsg", "请输入经销商");
		validateRequired("province", "provinceMsg", "请输入所在省市");
		StringBuilder regex = new StringBuilder(
				"^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
		validateRegex("phone", regex.toString(), "phoneMsg", "联系方式请输入正确手机号");
		validateInteger("limitdays", "limitdaysMsg", "到达时间必须为整数");
	}

	@Override
	protected void handleError(Controller c) {
		String operation = c.getPara("operation");
		if (Constant.OPERATION_TYPE_INSERT.equals(operation)) {
			c.render("/jsp/dealder_insert.jsp");
		} else if (Constant.OPERATION_TYPE_UPDATE.equals(operation)) {
			int did = c.getParaToInt("did");
			Dealer dealer = new DealerServiceImp().findById(did);
			c.setAttr("dealer", dealer);
			c.render("/jsp/dealder_update.jsp");
		}
	}
}