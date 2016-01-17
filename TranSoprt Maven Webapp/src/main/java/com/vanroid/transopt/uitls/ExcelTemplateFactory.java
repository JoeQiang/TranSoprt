package com.vanroid.transopt.uitls;

import java.io.File;
import java.util.Iterator;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * Excel模版工厂类 单例工厂类 功能：生成各类Excel模版
 * 
 * @author Joe_Huang
 * 
 */
public class ExcelTemplateFactory {
	// 获取Log4j实例
	private static Logger logger = Logger.getLogger(ExcelTemplateFactory.class);

	private static ExcelTemplateFactory factory = null;
	static {
		factory = new ExcelTemplateFactory();
	}

	/**
	 * 实例化ExcelTemplateFactory类
	 * 
	 * @return
	 */
	public static ExcelTemplateFactory getInstance() {
		return factory;
	}

	/**
	 * 根据模版名称反射生成对应的Excel模版类
	 * 
	 * 每一分Excel模版都需要在template_list.xml中注册
	 * 
	 * 
	 * @param templateName
	 *            注册在template_list.xml中的Excel模版的名称
	 * @return 返回对应的模版类
	 * @throws DocumentException
	 */
	@SuppressWarnings("unchecked")
	public ExcelTemplate getTemplate(String templateName)
			throws DocumentException {
		// 获取Excel模版注册表template_list.xml的绝对路径
		String path = getClass().getClassLoader()
				.getResource("excelTemplate/template_list.xml").getPath()
				.substring(1).replace("%20", " ");
		logger.warn("加载template_list文件,文件路径:" + path);
		File file = new File(path);
		if (file.exists()) {
			// 实例化dom4j SAXReader解析器
			SAXReader reader = new SAXReader();
			Document doc = reader.read(file);
			// 获取template_list.xml根节点list
			Element root = doc.getRootElement();
			// 获取迭代器
			Iterator<Element> iterator = root.elementIterator();

			String className = null;
			// 遍历根节点list所有的子节点sheet
			while (iterator.hasNext()) {
				Element e = iterator.next();
				// 获取子节点sheel属性name(Excel模板类名称)
				String name = e.attributeValue("name");
				// 获取子节点sheel属性class(Excel模板类对应类的全名)
				String clazz = e.attributeValue("class");
				if (templateName.trim().equals(name.trim())) {
					className = clazz;
				}
			}
			if (!"".equals(className) || className != null) {
				try {
					// 根据类名反射加载类
					Class<?> instance = Class.forName(className);
					// 实例化加载类并强制转换为ExcelTemplate类型
					ExcelTemplate template = (ExcelTemplate) instance
							.newInstance();
					return template;
				} catch (ClassNotFoundException | InstantiationException
						| IllegalAccessException e) {
					e.printStackTrace();
				}
			}
		} else {
			logger.error("template_list.xml文件不存在或文件路径有误");
		}
		return null;
	}

	protected ExcelTemplateFactory() {

	}
}
