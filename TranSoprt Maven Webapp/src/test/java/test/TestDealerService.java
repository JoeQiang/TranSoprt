package test;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

import com.taobao.api.ApiException;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.service.DealerService;
import com.vanroid.transopt.service.DealerServiceImp;

public class TestDealerService {
	DealerService ds=new DealerServiceImp();
	JuitTestBase base=new JuitTestBase();
	@Before
	public void before(){
		base.arp.addMapping("dealer","did", Dealer.class);
		base.dp.start();
		base.arp.start();
	}
	/*@Test
	public void testDealerService() throws IOException, ApiException {
	//	ds.getDynamPwd("");
	}*/
	@Test
	public void testDoLogin(){
		
		System.out.println(ds.doLogin("18826243880", "123")); ;
	}
	@Test
	public void testGetDynamic() throws IOException, ApiException{
		ds.getDynamPwd("18826243880");
	}
}
