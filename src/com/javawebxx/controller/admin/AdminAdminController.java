
package com.javawebxx.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("adminAdminController")
@RequestMapping(value = "/admin/admin")
public class AdminAdminController extends MyController {
	

	@RequestMapping(value = "/frame")
	public String frame(Model model, HttpServletRequest request,String flag)throws Exception {
		return "/admin/admin/frame";
	}
	
	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request,String flag,String username)throws Exception {
		String sql="select a.* from t_admin a where 1=1 and types='人事部门' ";


	if(username!=null&&!"".equals(username)){
			sql+=" and username like '%"+username+"%'";
		}
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/admin/list";
	}
	
	@RequestMapping(value = "/editSave")
	public ResponseEntity<String> editSave(Model model,HttpServletRequest request,Long id,String flag
		,String username,String password,String types,String adminName,String company,String phone) throws Exception{
		int result = 0;
		if(id!=null){
			String sql="update t_admin set username=?,password=?,adminName=?,company=?,phone=? where id=?";
			result = db.update(sql, new Object[]{username,password,adminName,company,phone,id});
		}else{
			String sql="insert into t_admin(username,password,types,adminName,company,phone) values(?,?,?,?,?,?)";
			result = db.update(sql, new Object[]{username,password,"人事部门",adminName,company,phone});
		}
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/editDelete")
	public ResponseEntity<String> editDelete(Model model,HttpServletRequest request,Long id,String flag) throws Exception {
		
		String sql="delete from t_admin where id=?";
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
			String sql="select * from t_admin where id=?";
			Map map = db.queryForMap(sql,new Object[]{id});
			model.addAttribute("map", map);
		}String sql="";

		return "/admin/admin/edit";
	}
}
