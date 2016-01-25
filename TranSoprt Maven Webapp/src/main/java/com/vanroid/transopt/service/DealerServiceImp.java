package com.vanroid.transopt.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.uitls.ExcelTemplate;
import com.vanroid.transopt.uitls.ExcelTemplateFactory;
import com.vanroid.transopt.uitls.MD5Utils;
/**
 *                 _ooOoo_ 
                  o8888888o 
                  88" . "88 
                  (| -_- |) 
                  O\  =  /O 
               ____/`---'\____ 
             .'  \\|     |//  `. 
            /  \\|||  :  |||//  \ 
           /  _||||| -:- |||||-  \ 
           |   | \\\  -  /// |   | 
           | \_|  ''\---/''  |   | 
           \  .-\__  `-`  ___/-. / 
         ___`. .'  /--.--\  `. . __ 
      ."" '<  `.___\_<|>_/___.'  >'"". 
     | | :  `- \`.;`\ _ /`;.`/ - ` : | | 
     \  \ `-.   \_ __\ /__ _/   .-` /  / 
======`-.____`-.___\_____/___.-`____.-'====== 
                   `=---=' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
         		佛祖保佑       永无BUG 
         		
    经销商服务接口实现类
 * @author Joe_Huang
 *
 */
@Before(Tx.class)
public class DealerServiceImp implements DealerService {

	@Override
	public boolean doLogin(Dealer dealer) {
		String username = dealer.get("dname");
		String password = dealer.get("dpwd");

		// MD5加密
		password = MD5Utils.MD5(password);
		Dealer dl = getByName(username);
		boolean flag = false;

		if (dl != null && password.equals(dl.get("dpwd"))) {
			flag = true;
		}
		return flag;
	}

	@Override
	public Dealer getByName(String username) {
		return Dealer.dao.findFirst("select * from dealer where dname=?",
				username);
	}

	@Override
	public void saveDealer(String dname, String dpwd, long phone,
			String province, int limitdays) {
		new Dealer().set("dname", dname).set("phone", phone)
				.set("province", province).set("limitdays", limitdays)
				.set("dpwd", dpwd).save();
	}

	@Override
	public Page<Dealer> dealerList(int curPage, int pageSize) {
		return Dealer.dao.dealerList(curPage, pageSize);
	}

	@Override
	public Dealer findById(int did) {
		return Dealer.dao.findById(did);
	}

	@Override
	public void updateDealer(int did, String dname, long phone,
			String province, int limitdays) {
		Dealer.dao.findById(did).set("dname", dname).set("phone", phone)
				.set("province", province).set("limitdays", limitdays).update();
	}

	@Override
	public void deleteDealer(int did) {
		Dealer.dao.deleteById(did);
	}

	public boolean batchSaveDealer(File file, HttpServletRequest request) {
		List<Map<String, Object>> list;
		String info = "";
		boolean validate = true;
		try {
			ExcelTemplate template = ExcelTemplateFactory.getInstance()
					.getTemplate("dealer");
			list = template.pasreExcel(file);
			for (Map<String, Object> map : list) {
				Set set = map.keySet();
				for (Object key : set) {
					if ("phone".equals(key)) {
						Pattern p = Pattern
								.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
						String phone = (String) map.get(key);
						Matcher m = p.matcher(phone);
						if (!m.matches()) {
							validate = false;
							request.setAttribute("error", "导入错误:电话号码   "
									+ phone + "不是正确手机号码");
						}
					} else if ("limitdays".equals(key)) {
						String limitdays = (String) map.get(key);
						boolean isNumeric = StringUtils.isNumeric(limitdays);
						if (!isNumeric) {
							validate = false;

							request.setAttribute("error", "导入错误,规定到达日期   "
									+ limitdays + "不是整数");

						}
					}
				}
			}
			if (validate) {
				for (Map<String, Object> map : list) {
					String dname = (String) map.get("dname");
					long phone = Long.parseLong((String) map.get("phone"));
					String province = (String) map.get("province");
					int limitdays = Integer.parseInt((String) map
							.get("limitdays"));
					String dpwd = MD5Utils.MD5("19940816");
					saveDealer(dname, dpwd, phone, province, limitdays);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return validate;
	}
}
