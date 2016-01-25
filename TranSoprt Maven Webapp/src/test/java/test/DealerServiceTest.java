package test;

import java.io.File;

import org.junit.Test;

import com.vanroid.transopt.service.DealerServiceImp;

public class DealerServiceTest {
	@Test
	public void test() {

		boolean flag = new DealerServiceImp().batchSaveDealer(new File("D:"
				+ File.separator + "经销商批量导入.xls"), null);
		System.out.println(flag);
	}
}
