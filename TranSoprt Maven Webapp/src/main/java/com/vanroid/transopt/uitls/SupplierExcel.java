package com.vanroid.transopt.uitls;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Iterator;

import jxl.Workbook;
import jxl.write.Boolean;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 供应商信息统计表Excel模板类 功能： 1、生成供应商信息统计表.xls文件 2、
 * 
 * @author Joe_Huang
 * 
 */
public class SupplierExcel implements ExcelTemplate {
	private static Logger logger = Logger.getLogger(SupplierExcel.class);

	/**
	 * 创建供应商信息统计表Excel模板
	 * 
	 * 工作流程： 1、查找对应的模板定义文件supplier.xml 2、dom4j解析spplier.xml供应商模板文件定义
	 * 3、根据模板文件定义生成对应的供应商信息统计表.xls文件 供应商信息统计表.xls 文件路径:classpath/excelTemplate
	 */
	@Override
	public File createExcelTemplate(String name) {
		File file = null;
		try {
			// 获取Excel模版注册表template_list.xml的绝对路径
			InputStream in = getClass().getClassLoader().getResourceAsStream(
					"excelTemplate/" + name + ".xml");
			if (in != null) {
				logger.warn("supplier.xml文件查找成功");
				SAXReader reader = new SAXReader();
				Document doc = reader.read(new InputStreamReader(in, "UTF-8"));
				Element root = doc.getRootElement();
				String path = getClass().getClassLoader().getResource("")
						.getPath().substring(1).replace("%20", " ")
						+ "excelTemplate";
				String filename = "供应商信息统计表.xls";
				file = new File(path, filename);
				file.delete();
				file.createNewFile();

				writeToExcel(file, root);

			} else {
				logger.error("错误,文件路径错误或" + name + ".xml文件不存在");
			}
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file;
	}

	/**
	 * 利用JXL将解析supplier.xml供应商模板文件定义添加到文件中
	 * 
	 * @param file
	 *            供应商信息统计表.xls
	 * 
	 * @param root
	 *            supplier.xml根节点
	 */
	@SuppressWarnings("unchecked")
	private void writeToExcel(File file, Element root) {
		try {
			// 创建工作簿
			WritableWorkbook wb = Workbook.createWorkbook(file);
			// 创建工作表
			WritableSheet sheet = wb.createSheet("Sheet0", 0);
			// 单元格标签
			Label label = null;
			// WritableFont font = new WritableFont(WritableFont.TIMES,
			// 18,WritableFont.BOLD, true);
			// WritableCellFormat wcf = new WritableCellFormat(font);
			// 当前行指针
			int rowIndex = 0;
			// 获取root节点子节点thead
			Element thead = root.element("thead");
			// 获取thead迭代器 ,用于遍历其子节点tr
			Iterator<Element> thead_trs = thead.elementIterator();

			// 迭代取得tr子节点
			while (thead_trs.hasNext()) {
				Element tr = thead_trs.next();
				// 获取tr迭代器,用于遍历其子节点th
				Iterator<Element> ths = tr.elementIterator();
				// 当前列指针
				int colIndex = 0;
				while (ths.hasNext()) {
					Element th = ths.next();
					// 设置(colIndex,rowIndex)单元格值
					label = new Label(colIndex, rowIndex,
							th.attributeValue("value"));
					// 将单元格添加到默认工作表中
					sheet.addCell(label);
					sheet.setColumnView(colIndex, 20);
					colIndex++;
				}
				rowIndex++;
			}
			Element tbody = root.element("tbody");
			Iterator<Element> tbody_trs = tbody.elementIterator();
			while (tbody_trs.hasNext()) {
				Element tr = tbody_trs.next();
				Iterator<Element> tds = tr.elementIterator();
				int colIndex = 0;
				while (tds.hasNext()) {
					Element td = tds.next();
					label = new Label(colIndex, rowIndex, null);
					formatCell(label, td, wb);
					sheet.addCell(label);
					colIndex++;
				}
			}
			// 将工作簿内容写入文件
			wb.write();
			// 关闭工作簿
			wb.close();
		} catch (IOException | WriteException e) {
			e.printStackTrace();
		}

	}

	private void formatCell(Label label, Element td, WritableWorkbook wb) {
		String type = td.attributeValue("type");
		System.out.println("type:" + type);
		if (Constant.CELL_TYPE_NUMERIC.equalsIgnoreCase(type)) {
				
		} else if (Constant.CELL_TYPE_STRING.equalsIgnoreCase(type)) {
		} else if (Constant.CELL_TYPE_DATE.equalsIgnoreCase(type)) {

		}
	}

	public static void main(String[] args) {
		new SupplierExcel().createExcelTemplate("supplier");

	}
}
