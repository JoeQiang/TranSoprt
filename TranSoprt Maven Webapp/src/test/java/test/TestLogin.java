package test;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.vanroid.transopt.uitls.MD5Utils;

public class TestLogin {
	Logger logger=Logger.getLogger(TestLogin.class);
	@Test
	public void getpwd() {
		String pwd="123";
		pwd = MD5Utils.MD5(pwd);
		logger.info("pwd："+pwd);
	}
}
