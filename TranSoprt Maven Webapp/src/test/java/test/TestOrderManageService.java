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
import com.vanroid.transopt.model.Standard;
import com.vanroid.transopt.service.OrderManageService;

public class TestOrderManageService {
	private OrderManageService os = Duang.duang(OrderManageService.class);
	JuitTestBase base = new JuitTestBase();

	@Before
	public void before() {
		base.arp.addMapping("dealer", "did", Dealer.class);
		base.arp.addMapping("grfactory", "fid", GRFactory.class);
		base.arp.addMapping("standard", "sid", Standard.class);
		base.arp.addMapping("grgoods", "gid", GRGoods.class);

		base.arp.addMapping("grorder", "oid", GROrder.class);
		base.dp.start();
		base.arp.start();
	}

	@Test
	public void testInform() throws IOException, ApiException {

		os.inform(22);
	}

	@Test
	public void testDisFactory() {
	/*	System.out.println(os.distributeFactory(1, 1, 14));*/
		;

	}

	@Test
	public void testDeliverGoods() throws IOException, ApiException {
		System.out.println("res:" + os.deliverGoods(9));
	}

	@Test
	public void testDeliverOrder() {

		int size = os.getDelivOrder(1, 1).getList().size();
		System.out.println("size:" + size);

	}

	@Test
	public void testMakeOrder() {
		// System.out.println("result:"+os.makeOrder(1)); ;
	}
}
