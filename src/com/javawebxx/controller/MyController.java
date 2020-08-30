package com.javawebxx.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.jason.framework.mvc.spring.BaseController;
import com.jason.framework.util.JacksonJsonUtil;
import com.javawebxx.util.DBHelper;

public class MyController extends BaseController {
	@Autowired
	public DBHelper db;
	
	public Map getAdmin(HttpServletRequest request){
		Map customerBean = (Map)request.getSession().getAttribute("adminBean");
		return customerBean;
	}
	
	public Map getCustomer(HttpServletRequest request){
		Map customerBean = (Map)request.getSession().getAttribute("customerBean");
		return customerBean;
	}
	
	public ResponseEntity<String> renderMsg(Boolean status, String msg) {
		if (StringUtils.isEmpty(msg)) {
			msg = "";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"status\":\"" + status + "\",\"msg\":\"" + msg + "\"");
		sb.append("}");
		ResponseEntity<String> responseEntity = new ResponseEntity<String>(
				sb.toString(), initHttpHeaders(), HttpStatus.OK);
		return responseEntity;
	}
	
	public ResponseEntity<String> renderData(Boolean status, String msg,
			Object obj) {
		if (StringUtils.isEmpty(msg)) {
			msg = "";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"status\":\"" + status + "\",\"msg\":\"" + msg + "\",");
		sb.append("\"data\":" + JacksonJsonUtil.toJson(obj) + "");
		sb.append("}");
		ResponseEntity<String> responseEntity = new ResponseEntity<String>(
				sb.toString(), initHttpHeaders(), HttpStatus.OK);
		return responseEntity;
	}
	
	public ResponseEntity<String> renderComboBoxAjax(Object obj) {
		ResponseEntity<String> responseEntity = new ResponseEntity<String>(
				JacksonJsonUtil.toJson(obj), initHttpHeaders(), HttpStatus.OK);
		return responseEntity;
	}
	
	public ResponseEntity<String> renderDataGraidForPage(String sql,Object obj) {
		StringBuffer sb = new StringBuffer();
		int size = db.queryForInt("select count(1) from (" + sql + ") aa");
		sb.append("{");
		sb.append("\"total\":\"" + size + "\",");
		sb.append("\"data\":" + JacksonJsonUtil.toJson(obj) + "");
		sb.append("}");
		ResponseEntity<String> responseEntity = new ResponseEntity<String>(
				sb.toString(), initHttpHeaders(), HttpStatus.OK);
		return responseEntity;
	}
	
	
	public int customerCode(String id,int code,Integer fileId,boolean isMod,int flag){
		Map map = db.queryForMap("select * from filem_customer where id=?", new Object[]{id});
		if(map!=null&&map.size()>0){
			int cCode=map.get("code")==null?0:Integer.parseInt(map.get("code").toString());
			if(isMod){
				cCode=cCode+code;
				String ctype = map.get("ctype").toString();
				if(cCode>=15){
					if(!ctype.equals("3")){
						db.update("update filem_customer set ctype=3 where id="+id);
					}
				}else if(cCode<15&&cCode>=10){
					if(ctype.equals("1")){
						db.update("update filem_customer set ctype=2 where id="+id);
					}
				}
				String sql="update filem_customer set code=? where id=?";
				db.update(sql,new Object[]{cCode,id});
				sql="insert into filem_code(id,cId,code,insertDate,fileId,flag) values(filem_s_index.nextval,?,?,sysdate,?,?)";
				db.update(sql, new Object[]{id,code,fileId,flag});
				return 1;
			}else{
				cCode = cCode-code;
				if(cCode<0){
					return 999;
				}else{
					String sql="update filem_customer set code=? where id=?";
					db.update(sql,new Object[]{cCode,id});
					sql="insert into filem_code(id,cId,code,insertDate,fileId,flag) values(filem_s_index.nextval,?,?,sysdate,?,?)";
					db.update(sql, new Object[]{id,code,fileId,flag});
					return 1;
				}
			}
		}else{
			return 999;//无积分
		}
		
	}

}