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
	public TaobaoClient getTaobaoClient() throws IOException {
		if (client == null) {
			InputStream in = getClass().getClassLoader().getResourceAsStream(
					"note_config.properties");
			Properties p = new Properties();
			p.load(in);
			client = new DefaultTaobaoClient(p.getProperty("url"),
					p.getProperty("appkey"), p.getProperty("secret"));
		}
		return client;
	}

}