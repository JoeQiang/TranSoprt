package test;

import java.io.IOException;

import org.junit.Before;
import org.junit.Test;

import com.jfinal.aop.Duang;
import com.taobao.api.ApiException;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.service.OrderManageService;

public class TestOrderManageService {
	private OrderManageService os = Duang.duang(OrderManageService.class);
	JuitTestBase base = new JuitTestBase();
	@Before
	public void before(){
		base.arp.addMapping("dealer","did", Dealer.class);
		base.arp.addMapping("grfactory","fid", GRFactory.class);
		base.arp.addMapping("grorder","oid", GROrder.class);
		base.dp.start();
		base.arp.start();
	}
	@Test
	public void testInform() throws IOException, ApiException {
		
				os.inform(22);
			
		
	}
}
