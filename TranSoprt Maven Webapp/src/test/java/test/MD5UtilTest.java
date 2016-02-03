package test;

import org.junit.BeforeClass;
import org.junit.Test;

import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.service.DealerServiceImp;
import com.vanroid.transopt.uitls.Constant;
import com.vanroid.transopt.uitls.MD5Utils;

public class MD5UtilTest {

	
	@Test
	public void test() {
		System.out.println(MD5Utils.MD5("123"));
	}

}
