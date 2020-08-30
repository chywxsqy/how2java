
package com.javawebxx.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("AdminCustomerController")
@RequestMapping(value = "/admin/customer")
public class AdminCustomerController extends MyController {
	

	@RequestMapping(value = "/frame")
	public String frame(Model model, HttpServletRequest request)throws Exception {
		return "/admin/customer/frame";
	}
	
	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request,String keyword)throws Exception {
		String sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
				",(select v1 from t_xl b where b.id=a.xlId) xlName " +
				",(select v1 from t_gw b where b.id=a.gwId) gwName from t_customer a where 1=1 ";
		if(keyword!=null&&!"".equals(keyword)){
			sql+=" and username like '%"+keyword+"%'";
		}
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/customer/list";
	}
	
	@RequestMapping(value = "/editSave")
	public ResponseEntity<String> editSave(Model model,HttpServletRequest request,Long id
		,String username,String password,String name,String age,String sex,Integer xlId,Integer gwId,Integer fwId,String content,String fileUrl,String huiyuan) throws Exception{
		int result = 0;
		if(id!=null){
			String sql="update t_customer set username=?,password=?,name=?,age=?,sex=?,xlId=?,gwId=?,fwId=?,content=?,fileUrl=?,huiyuan=? where id=?";
			result = db.update(sql, new Object[]{username,password,name,age,sex,xlId,gwId,fwId,content,fileUrl,huiyuan,id});
		}else{
			String sql="insert into t_customer(username,password,name,age,sex,xlId,gwId,fwId,content,fileUrl,huiyuan) values(?,?,?,?,?,?,?,?,?,?,?)";
			result = db.update(sql, new Object[]{username,password,name,age,sex,xlId,gwId,fwId,content,fileUrl,huiyuan});
		}
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/editDelete")
	public ResponseEntity<String> editDelete(Model model,HttpServletRequest request,Long id) throws Exception {
		
		String sql="delete from t_customer where id=?";
		int result = db.update(sql, new Object[]{id});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
		
	}
	
	@RequestMapping(value = "/edit")
	public String edit(Model model, HttpServletRequest request,Long id)throws Exception {
		if(id!=null){
			//修改
			String sql="select * from t_customer where id=?";
			Map map = db.queryForMap(sql,new Object[]{id});
			model.addAttribute("map", map);
		}
		return "/admin/customer/edit";
	}
}
