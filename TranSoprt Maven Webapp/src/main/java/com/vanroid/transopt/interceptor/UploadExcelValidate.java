package com.vanroid.transopt.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;
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

 * @author Joe_Huang
 *
 */
public class UploadExcelValidate implements Interceptor {

	@Override
	public void intercept(Invocation inv) {
		Controller controller = inv.getController();
		UploadFile uploadFile = controller.getFile("excel");
		String fileName = uploadFile.getFileName();
		if (fileName.endsWith("xls")) {
			inv.invoke();
		} else {
			uploadFile.getFile().delete();
			controller.setAttr("error", "上传文件必须是以.xls结尾的Excel文件");
			controller.render("/jsp/dealder_insert.jsp");
		}
		/*
		 * String token = (String)
		 * controller.getSession().getAttribute("token"); String tokenValue =
		 * controller.getPara("token"); if (token != null &&
		 * token.equals(tokenValue)) {
		 * controller.getSession().removeAttribute("token"); } else {
		 * uploadFile.getFile().delete();
		 * controller.forwardAction("/manager/dealer"); }
		 */

	}

}
