package test;

import org.junit.BeforeClass;
import org.junit.Test;

import com.vanroid.transopt.uitls.MD5Utils;

public class MD5UtilTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@Test
	public void test() {
		System.out.println(MD5Utils.MD5("19940816"));
	}

}
