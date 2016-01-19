package test;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import com.jfinal.aop.Enhancer;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.service.GoodsManageService;

public class TestGoodsService {
	Logger logger=Logger.getLogger(TestGoodsService.class);
	JuitTestBase base = new JuitTestBase();
	GoodsManageService gs= Enhancer.enhance(GoodsManageService.class); ;
	@Before
	public void before(){
		base.arp.addMapping("grgoods","gid", GRGoods.class);
		base.dp.start();
		base.arp.start();
	}
	@Test
	public void testCreateGoods() {
		
		gs.createGoods("奶酪16", new int[]{1,2});
	}
	@Test
	public void testDeleteGoods() {
		gs.delectByGid(15);
	}
	@Test
	public void testGetAllGoods() {
		/*for (GRGoods goods : gs.getAllGoods()) {
			logger.info(goods.getStr("gname")+"下有:");
			for (String sta : goods.getStandard()) {
				logger.info(sta);
			}
		}*/
	}
	@Test
	public void testGetGoodsFrom(){
		Page<GRGoods> goodsFrom = gs.getGoodsFrom(1);
		List<GRGoods> list = goodsFrom.getList();
		for (GRGoods grGoods : list) {
			logger.info("standard:"+grGoods.getStandard());;
		}
		
	}
	@Test
	public void testDelSta(){
		gs.delSta(11, 1);
	}
}
