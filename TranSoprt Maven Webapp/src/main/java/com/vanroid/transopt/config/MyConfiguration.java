package com.vanroid.transopt.config;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import com.vanroid.transopt.controller.DealderController;
import com.vanroid.transopt.controller.UpDownloadController;
import com.vanroid.transopt.controller.IndexController;
import com.vanroid.transopt.controller.LoginController;
import com.vanroid.transopt.model.Admin;
import com.vanroid.transopt.model.Dealer;
import com.vanroid.transopt.model.GRFactory;
import com.vanroid.transopt.model.GRGoods;
import com.vanroid.transopt.model.GROrder;

public class MyConfiguration extends JFinalConfig {
	/**
	 * 常量配置
	 */
	@Override
	public void configConstant(Constants me) {
		// 开发模式
		me.setDevMode(true);
		// 设置默认视图
		me.setViewType(ViewType.JSP);
		// 配置下载文件下载路径
		me.setFileRenderPath("/excelTemplate");
	}

	/**
	 * 配置映射表
	 */
	@Override
	public void configRoute(Routes me) {
		me.add("/", IndexController.class);
		me.add("/login", LoginController.class, "/");
		me.add("/manager/dealer", DealderController.class, "/");
		me.add("/download", UpDownloadController.class, "/");
	}

	/**
	 * 配置插件
	 */
	@Override
	public void configPlugin(Plugins me) {
		loadPropertyFile("db_config.txt");
		// 配置c3p0连接池
		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"),
				getProperty("user"), getProperty("password"));
		c3p0Plugin.setDriverClass(getProperty("driver"));
		me.add(c3p0Plugin);
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		me.add(arp);
		// 设置方言为MySQL
		arp.setDialect(new MysqlDialect());
		// 显示SQL语句
		arp.setShowSql(true);
		// ORM映射表
		arp.addMapping("dealer", "did", Dealer.class);
		arp.addMapping("grorder", "oid", GROrder.class);
		arp.addMapping("grfactory", "fid", GRFactory.class);
		arp.addMapping("grgoods", "gid", GRGoods.class);
		arp.addMapping("admin", Admin.class);
	}

	@Override
	public void configInterceptor(Interceptors me) {
	}

	@Override
	public void configHandler(Handlers me) {
	}

}
