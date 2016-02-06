package com.vanroid.transopt.service;

/**
 * 公告栏的逻辑业务类
 * 
 * @author Jerry
 * 
 */
public class PublicService {
	/**
	 * 转为html格式存到数据库
	 * 
	 * @param text
	 * @return
	 */
	public static String toHtml(String text) {
		String htmlStr = "";
		if (text.contains("\n")) {
			String[] split = text.split("\n");
			for (String string : split) {
				htmlStr += "<p>" + string + "</p>";
			}
		}
		return htmlStr;
	}

	/**
	 * 转换成文字
	 * 
	 * @param html
	 * @return
	 */
	public static String toText(String html) {
		System.out.println("html1"+html);
		if (html.contains("<p>")) {
			html=html.replaceAll("<p>", "");
			html=html.replaceAll("</p>", "\n");
		}
		System.out.println("html2"+html);
		return html;
	}
}
