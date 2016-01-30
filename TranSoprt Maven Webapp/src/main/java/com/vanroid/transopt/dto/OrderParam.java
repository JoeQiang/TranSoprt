package com.vanroid.transopt.dto;

/**
 * 下订单的临时传输bean
 * 
 * @author Jerry
 * 
 */
public class OrderParam {
	private int did;
	private int gid;
	private int sid;
	private int num;

	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
}
