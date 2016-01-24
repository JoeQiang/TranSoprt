package test;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;
import org.junit.BeforeClass;
import org.junit.Test;

import com.vanroid.transopt.uitls.BaseExcel;
import com.vanroid.transopt.uitls.DealerExcel;
import com.vanroid.transopt.uitls.ExcelTemplateFactory;

public class ExcelTemplateTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@Test
	public void test() throws DocumentException {

		ExcelTemplateFactory factory = ExcelTemplateFactory.getInstance();
		/*
		 * factory.getTemplate("supplier").pasreExcel(file)
		 */
		File file = new File("D:/经销商批量导入.xls");
		BaseExcel operation = new DealerExcel();
		operation.setTemplateName("dealer");
		List<Map<String, Object>> list = operation.pasreExcel(file);
	}
}
