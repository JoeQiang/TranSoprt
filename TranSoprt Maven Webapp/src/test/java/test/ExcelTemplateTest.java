package test;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.junit.BeforeClass;
import org.junit.Test;

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
