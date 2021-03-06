package com.vanroid.transopt.controller;

import java.io.File;
import java.util.List;

import javax.faces.view.facelets.Facelet;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.vanroid.transopt.interceptor.LoginInterceptor;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GROrder;
import com.vanroid.transopt.service.GRFactoryService;
import com.vanroid.transopt.service.GRFactoryServiceImp;
import com.vanroid.transopt.uitls.Constant;

/**
 * 厂家控制类
 * 
 * @author Joe_Huang
 * 
 */
@Before(LoginInterceptor.class)
public class GRFactoryController extends Controller {

	private GRFactoryService service = new GRFactoryServiceImp();

	/**
	 * 跳到厂家管理页
	 */
	public void account() {
		int pageNum = getParaToInt(0);
		if (pageNum <= 0) {
			pageNum = 1;
		}
		Page<GRFactory> pager = service.getFactoryList(pageNum);
		setAttr("pager", pager);
		setAttr("li_id", "li_factory");
		render("/jsp/acount_factory.jsp");
	}

	public void showOrder() {
		int pageNumber = getParaToInt(0);
		int fid = getParaToInt(1);
		Page<GROrder> pager = GROrder.dao.paginate(pageNumber, 10, "select * ",
				"from grorder where 1=1 and factoryid =?", fid);
		for (GROrder order : pager.getList()) {
			order.getAttrFromOtherTable();
		}
		setAttr("pager", pager);
		setAttr("fid", fid);
		setAttr("li_id", "li_factory");
		render("/jsp/factory_order_show.jsp");
	}

	/**
	 * 跳转厂家页
	 */
	public void manager() {
		int pageNum = getParaToInt(0);
		if (pageNum <= 0) {
			pageNum = 1;
		}
		Page<GRFactory> pager = service.getFactoryList(pageNum);
		setAttr("pager", pager);
		setAttr("li_id", "li_factory_order");
		render("/jsp/factory_manager.jsp");
	}

	/**
	 * 跳转账号设置页面
	 */
	public void setting() {
		int pageNum = getParaToInt(0);
		if (pageNum <= 0) {
			pageNum = 1;
		}
		Page<GRFactory> pager = service.getFactoryList(pageNum);
		setAttr("pager", pager);
		setAttr("li_id", "li_setting");
		render("/jsp/acount_setting.jsp");
	}

	/**
	 * 保存修改账号
	 */
	public void saveFactory() {
		String fname = getPara("fname");
		String fpwd = getPara("fpwd");
		String rpwd = getPara("rpwd");
		boolean flag = service.saveFactory(fname, fpwd);
		renderJson("info", flag);
	}

	/**
	 * 更新账号
	 */
	public void updateFactory() {
		int fid = getParaToInt("fid");
		String fname = getPara("fname");
		String fpwd = getPara("fpwd");
		boolean flag = service.updateFactory(fid, fname, fpwd);
		renderJson("info", flag);
	}

	public void getFactoryById() {
		int fid = getParaToInt("fid");
		GRFactory factory = service.getFactoryById(fid);
		renderJson(factory.toJson());
	}

	/**
	 * 取得该厂家所有的订单
	 */
	public void order() {
		int fid = getParaToInt(0);
		String filter = getPara("filter");
		String search = getPara("search");
		List<GROrder> list = service.getAllOrders(fid, filter, search);
		setAttr("fid", fid);
		setAttr("list", list);
		setAttr("li_id", "li_factory_order");
		render("/jsp/factory_order.jsp");
	}

	public void search() {
		int fid = getParaToInt("fid");
		int option = getParaToInt("option");
		String search = getPara("search");
		List<GROrder> list = service.searchOrder(null, fid, option, search);
		setAttr("fid", fid);
		setAttr("list", list);
		setAttr("li_id", "li_factory_order");
		render("/jsp/factory_order.jsp");

	}

	public void filterDay() {
		int fid = getParaToInt("fid");
		int dateType = getParaToInt("dateType");
		String beginDay = getPara("begin");
		String endDay = getPara("end");
		List<GROrder> list = service.dateOrder(null, fid, dateType, beginDay,
				endDay);
		setAttr("fid", fid);
		setAttr("list", list);
		render("/jsp/factory_order.jsp");
	}

	/**
	 * 下载excel订单
	 */
	public void excelOrder() {
		Integer[] oid = getParaValuesToInt("select");
		List<GROrder> list = service.getDownloadOrder(oid);
		String classPath = PathKit.getRootClassPath();
		File file = new File(classPath + "/订单统计.xls");
		try {
			if (file.exists()) {
				file.delete();
			}
			file.createNewFile();
			WritableWorkbook wb = Workbook.createWorkbook(file);
			WritableSheet sheet = wb.createSheet("sheel0", 0);
			Label label = null;
			String[] title = { "序号", "经销商", "电话号码", "详细地址", "货品数量", "货品品类",
					"货品规格", "下单时间", "发货时间", "发货厂家", "发货后规定到达时间", "状态" };
			for (int i = 0; i < title.length; i++) {
				label = new Label(i, 0, title[i]);
				sheet.addCell(label);
			}
			for (int i = 1; i <= list.size(); i++) {
				GROrder order = list.get(i - 1);
				Dealer dealer = order.get("dealer");
				// 订单序号
				label = new Label(0, i, order.getStr("seqnum"));
				sheet.addCell(label);
				// 经销商名称
				label = new Label(1, i, dealer.getStr("dname"));
				sheet.addCell(label);
				// 经销商联系电话
				if (dealer.get("phone") != null) {
					label = new Label(2, i, String.valueOf(dealer.get("phone")));
					sheet.addCell(label);
				} else {
					label = new Label(2, i, "");
					sheet.addCell(label);
				}
				// 经销商所在省市
				label = new Label(3, i, dealer.getStr("province"));
				sheet.addCell(label);
				// 货品的数量
				if (order.get("num") != null) {
					label = new Label(4, i, String.valueOf(order.get("num")));
					sheet.addCell(label);
				} else {
					label = new Label(4, i, "");
					sheet.addCell(label);
				}
				// 货品的品类
				label = new Label(5, i, order.getGoodName());
				sheet.addCell(label);
				// 货品的规格
				label = new Label(6, i, order.getStandardName());
				sheet.addCell(label);
				// 下单时间
				if (order.getDate("createtime") != null) {
					label = new Label(7, i, order.get("createtime").toString());
					sheet.addCell(label);
				} else {
					label = new Label(7, i, "");
					sheet.addCell(label);
				}
				// 发货时间
				if (order.getDate("sendday") != null) {
					label = new Label(8, i, order.getDate("sendday").toString());
					sheet.addCell(label);
				} else {
					label = new Label(8, i, "");
					sheet.addCell(label);
				}
				// 发货厂家
				label = new Label(9, i, order.get("factoryname").toString());
				sheet.addCell(label);
				// 发货后规定到达时间
				if (order.get("reqarrday") != null) {
					label = new Label(10, i, String.valueOf(order
							.get("reqarrday")));
					sheet.addCell(label);
				} else {
					label = new Label(10, i, "");
					sheet.addCell(label);
				}
				label = new Label(11, i, order.get("status").toString());
				sheet.addCell(label);
			}
			wb.write();
			wb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		renderFile(file);
	}

	public void getOrderInfo() {
		int oid = getParaToInt("oid");
		GROrder order = GROrder.dao.findById(oid);
		order.getAttrFromOtherTable();
		renderJson("order", order);
	}

	/**
	 * 经销商栏目下的条件搜索
	 */
	public void searchOption() {
		int option = getParaToInt("option");
		String search = getPara("search");
		List<GROrder> list = null;
		String rank = getSessionAttr("rank");
		if (rank.equalsIgnoreCase(Constant.USER_TYPE_ADMIN)) {
			list = service.searchOrder(Constant.SEARCH_FILTER, -1, option,
					search);
		} else if (rank.equalsIgnoreCase(Constant.USER_TYPE_FACTORY)) {
			GRFactory factory = getSessionAttr("user");
			list = service.searchOrder(Constant.SEARCH_FILTER,
					factory.getInt("fid"), option, search);
		}
		Page<GROrder> pager = new Page<GROrder>(list, 1, 1000, 1, list.size());
		setAttr("delivOrder", pager.getList());
		setAttr("pageNum", pager.getPageNumber());
		setAttr("totalPage", pager.getTotalPage());
		setAttr("li_id", "li_dealer_order");
		render("/jsp/order_send.jsp");
	}

	/**
	 * 经销商栏目下的按日期搜索
	 */
	public void filterDay2() {
		int dateType = getParaToInt("dateType");
		String beginDay = getPara("begin");
		String endDay = getPara("end");
		List<GROrder> list = null;
		String rank = getSessionAttr("rank");
		if (rank.equalsIgnoreCase(Constant.USER_TYPE_ADMIN)) {
			list = service.dateOrder(Constant.SEARCH_FILTER, -1, dateType,
					beginDay, endDay);
		} else if (rank.equalsIgnoreCase(Constant.USER_TYPE_FACTORY)) {
			GRFactory factory = getSessionAttr("user");
			list = service.dateOrder(Constant.SEARCH_FILTER,
					factory.getInt("fid"), dateType, beginDay, endDay);
		}
		Page<GROrder> pager = new Page<GROrder>(list, 1, 1000, 1, list.size());
		setAttr("delivOrder", pager.getList());
		setAttr("pageNum", pager.getPageNumber());
		setAttr("totalPage", pager.getTotalPage());
		setAttr("li_id", "li_dealer_order");
		render("/jsp/order_send.jsp");
	}
}
