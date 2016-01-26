package com.vanroid.transopt.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.taobao.api.ApiException;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.uitls.ExcelTemplate;
import com.vanroid.transopt.uitls.ExcelTemplateFactory;
import com.vanroid.transopt.uitls.MD5Utils;
import com.vanroid.transopt.uitls.NoteUtil;
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

	/**
	 * 获取动态密码
	 * 
	 * @param dname
	 * @return
	 * @throws IOException 
	 * @throws ApiException 
	 */
	public void getDynamPwd(String phone) throws IOException, ApiException {
		/**
		 * 创建6位数随机数
		 */
		Random random = new Random();
		String dynamPwd = "";
		for (int i = 0; i < 6; i++)
			dynamPwd += random.nextInt(9);
		Dealer dealer = Dealer.dao.findFirst(
				"select * from dealer where phone=?", phone);
		dealer.set("dynamic", MD5Utils.MD5(dynamPwd)).update();
		TaobaoClient client=new NoteUtil().getTaobaoClient();
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setSmsType("normal");
		req.setSmsFreeSignName("活动验证");
		req.setSmsParamString("{'dynampwd':'"+dynamPwd+"'}");
		req.setRecNum(phone);
		req.setSmsTemplateCode("SMS_4920215");
		AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
		
	}

	/**
	 * 修改密码
	 * 修改密码失败返回0
	 * @param oldPwd
	 * @param newPwd
	 */
	public int changePwd(String phone, String oldPwd, String newPwd) {
		Dealer dealer = Dealer.dao.findFirst(
				"select * from dealer where phone=?", phone);
		// 由动态密码改为固定密码
		if ("".equals(dealer.getStr("dpwd"))) {
			dealer.set("dpwd", newPwd).update();
			return 1;
		} else if (dealer.getStr("dpwd").equals(oldPwd)) {
			dealer.set("dpwd", newPwd).update();
			return 1;
		} else
			return 0;
	}
	/**
	 * 
	 * @param dname
	 * @param pwd
	 * @return 1登陆成功，2密码错误，3用户不存在
	 */
	@Override
	public int doLogin(String phone,String pwd) {
		List<Dealer> list = Dealer.dao.find(
				"select * from dealer where phone=?", phone);
		if (list.size() == 0)
			return 3;
		String digPwd=MD5Utils.MD5(pwd);
		if (digPwd.equals(list.get(0).getStr("dpwd"))
				|| pwd.equals(list.get(0).getStr("dynamic")))
			return 1;
		else
			return 2;
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
