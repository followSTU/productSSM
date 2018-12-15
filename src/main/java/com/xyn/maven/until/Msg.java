package com.xyn.maven.until;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class Msg {
	private Integer code;//成功则返回100，失败返回101
	private String msgString;
	private Map<String, Object> data=new HashMap<String, Object>();
	public static Msg success(){
		Msg msg=new Msg();
		msg.setCode(0);
		msg.setMsgString("成功");
		return msg;
	}
	public static Msg fail(){
		Msg msg=new Msg();
		msg.setCode(1);
		msg.setMsgString("失败");
		return msg;
	}
	public Msg add(String key,Object value){
		this.getData().put(key, value);
		return this;
	}
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsgString() {
		return msgString;
	}
	public void setMsgString(String msgString) {
		this.msgString = msgString;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	
}
