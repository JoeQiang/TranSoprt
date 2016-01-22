package test;

import org.dom4j.DocumentException;
import org.junit.BeforeClass;
import org.junit.Test;

import com.vanroid.transopt.uitls.ExcelTemplate;
import com.vanroid.transopt.uitls.ExcelTemplateFactory;

public class ExcelTemplateTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@Test
	public void test() throws DocumentException {

		ExcelTemplateFactory factory = ExcelTemplateFactory.getInstance();
		factory.getTemplate("supplier").createExcelTemplate();
	}
}
