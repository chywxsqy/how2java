
package com.javawebxx.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("messageController")
@RequestMapping(value = "/admin/message")
public class MessageController extends MyController {
	
	
	@RequestMapping(value = "/frame")
	public String frame(Model model, HttpServletRequest request,String flag)throws Exception {
		return "/admin/message/frame";
	}
	
	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request,String flag)throws Exception {
		String sql="select customerId,(select max(name) from t_customer b where b.id=a.customerId) customerName " +
				"from t_message a where adminId="+getAdmin(request).get("id")+" group by customerId";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/message/list";
	}
	
	@RequestMapping(value = "/lt")
	public String lt(Model model, HttpServletRequest request,String flag,Long customerId)throws Exception {
		String sql="select * from t_message where customerId='"+customerId+"' and adminId= "+getAdmin(request).get("id")+" order by id desc";
		List<Map> list = db.queryForList(sql);
		model.addAttribute("list", list);
		return "/admin/message/lt";
	}
	
	@RequestMapping(value = "/editSave")
	public ResponseEntity<String> editSave(Model model,HttpServletRequest request,Long id,String flag
		,String customerId,String adminId,String types,String content,String insertDate) throws Exception{
		int result = 0;
		if(id!=null){
			String sql="update t_message set customerId=?,adminid=?,types=?,content=? where id=?";
			result = db.update(sql, new Object[]{customerId,adminId,types,content,id});
		}else{
			String sql="insert into t_message(customerId,adminid,types,content,insertDate) values(?,?,?,?,now())";
			result = db.update(sql, new Object[]{customerId,adminId,types,content});
		}
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/editSavelt")
	public ResponseEntity<String> editSavelt(Model model,HttpServletRequest request,Long id,String flag
		,String customerId,String adminid,String types,String content,String insertDate) throws Exception{
		int result = 0;
		String sql="insert into t_message(customerId,adminid,types,content,insertDate) values(?,?,?,?,now())";
		result = db.update(sql, new Object[]{customerId,getAdmin(request).get("id"),2,content});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	
	@RequestMapping(value = "/editDelete")
	public ResponseEntity<String> editDelete(Model model,HttpServletRequest request,Long id,String flag) throws Exception {
		
		String sql="delete from t_message where id=?";
		int result = db.update(sql, new Object[]{id});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
		
	}
	
	@RequestMapping(value = "/edit")
	public String edit(Model model, HttpServletRequest request,Long id,String flag)throws Exception {
		if(id!=null){
			//修改
			String sql="select * from t_message where id=?";
			Map map = db.queryForMap(sql,new Object[]{id});
			model.addAttribute("map", map);
		}

		return "/admin/message/edit";
	}
}
