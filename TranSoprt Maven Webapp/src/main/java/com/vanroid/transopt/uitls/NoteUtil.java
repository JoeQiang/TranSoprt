package com.vanroid.transopt.uitls;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
/**
 * 短信接口平台
 * @author Jerry
 *
 */
public class NoteUtil {
	private TaobaoClient client = null;
	private static String signName=null;
	private static String template=null;
	private static String template2=null;
	static Properties p = new Properties();
	public NoteUtil() throws IOException {
		// TODO 自动生成的构造函数存根
		InputStream in = getClass().getClassLoader().getResourceAsStream(
				"note_config.properties");
		
		p.load(in);
	}
	
	public TaobaoClient getTaobaoClient() {
		if (client == null) {
			client = new DefaultTaobaoClient(p.getProperty("url"),
					p.getProperty("appkey"), p.getProperty("secret"));
		}
		return client;
	}
	//短信签名
	public static String getSignName(){
		if(signName==null){
			signName=p.getProperty("SmsFreeSignName");
		}
		return signName;
	}
	//发货短信模板
	public static String getTemplate(){
		if(template==null){
			template=p.getProperty("SmsTemplateCode");
		}
		return template;
	}
	//动态密码短信模板
	public static String getTemplate2(){
		if(template2==null){
			template2=p.getProperty("SmsTemplateCode2");
		}
		return template2;
	}

}