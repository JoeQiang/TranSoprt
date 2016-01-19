package test;

import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.dialect.MysqlDialect;
import com.jfinal.plugin.c3p0.C3p0Plugin;

public class JuitTestBase {

	C3p0Plugin dp = new C3p0Plugin(
			"jdbc:mysql://127.0.0.1:3306/transport?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull",
			"root", "root");
	ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);

	public JuitTestBase() {
		// TODO 自动生成的构造函数存根
		dp.setDriverClass("com.mysql.jdbc.Driver");
		arp.setDialect(new MysqlDialect());
		// 显示SQL语句
		arp.setShowSql(true);
	}
}
