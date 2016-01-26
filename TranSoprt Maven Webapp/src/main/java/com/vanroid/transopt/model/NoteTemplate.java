package com.vanroid.transopt.model;
/**
 * 出库通知短信bean
 * @author Jerry
 *${dname}老板，您好！您预订的${order}已经于${sendday}在${fname}厂发货了，
 *大概于${arriveday}，请注意收货，谢谢！
 */
public class NoteTemplate {
private String dname;
private String order;
private String sendday;
private String fname;
	private String arriveday;

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	

	public String getSendday() {
		return sendday;
	}

	public void setSendday(String sendday) {
		this.sendday = sendday;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getArriveday() {
		return arriveday;
	}

	public void setArriveday(String arriveday) {
		this.arriveday = arriveday;
	}
}
