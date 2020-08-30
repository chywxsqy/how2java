
package com.javawebxx.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("customerController")
@RequestMapping(value = "/customer")
public class CustomerController extends MyController {
	

	@RequestMapping(value = "/index")
	public String frame(Model model, HttpServletRequest request,String keyword1,String keyword2,String keyword3)throws Exception {
		String sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
				",(select v1 from t_xl b where b.id=a.xlId) xlName " +
				",(select v1 from t_gw b where b.id=a.gwId) gwName" +
				",(select v1 from t_gzdd b where b.id=a.gzddId) gzddName" +
				",(select v1 from t_gzjy b where b.id=a.gzjyId) gzjyName" +
				",(select v1 from t_hyly b where b.id=a.hylyId) hylyName  from t_zp a where 1=1 ";
		if(keyword1!=null&&!"".equals(keyword1)){
//			sql+=" and a.gwId= "+keyword1;
			sql+=" and exists(select 1 from t_gw b where a.gwId=b.id and b.v1 like '%"+keyword1+"%') ";
		}
		if(keyword2!=null&&!"".equals(keyword2)){
			sql+=" and a.fwId= "+keyword2;
		}
		if(keyword3!=null&&!"".equals(keyword3)){
			sql+=" and a.xlId= "+keyword3;
		}
		System.out.println(sql);
		model.addAttribute("list", db.queryForList(sql));
		
		
		sql="select * from t_fw";
		model.addAttribute("fwList", db.queryForList(sql));
		 sql="select * from t_xl";
		model.addAttribute("xlList", db.queryForList(sql));
		 sql="select * from t_gw";
		model.addAttribute("gwList", db.queryForList(sql));
		
		sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
				",(select v1 from t_xl b where b.id=a.xlId) xlName " +
				",(select v1 from t_gw b where b.id=a.gwId) gwName from t_customer a where huiyuan='是' and (gwId is not null or fwId is not null or xlId is not null) ";
		model.addAttribute("customerList", db.queryForList(sql));
		
		return "/customer/index";
	}
	
	@RequestMapping(value = "/goll")
	public String goll(Model model, HttpServletRequest request,Long adminId)throws Exception {
		//判定用户是否登录，必须等录
		Map customer  =getCustomer(request);
		if(customer!=null&&customer.size()>0){
			String sql="select * from t_message where adminId='"+adminId+"' and customerId= "+customer.get("id")+" order by id desc";
			List<Map> list = db.queryForList(sql);
			model.addAttribute("list", list);
			return "/customer/goll";
		}else{
			return "redirect:/customerLogin/login.html";
		}
		
	}
	
	
	
	@RequestMapping(value = "/main")
	public String main(Model model, HttpServletRequest request)throws Exception {
		return "/customer/main";
	}
	
	@RequestMapping(value = "/add")
	public String add(Model model, HttpServletRequest request)throws Exception {
		String sql="select * from t_fee order by id desc";
		model.addAttribute("feeList", db.queryForList(sql));
		return "/customer/add";
	}
	
	@RequestMapping(value = "/editSave")
	public ResponseEntity<String> editSave(Model model,HttpServletRequest request,Long id
		,String password,String name,String age,String sex,Integer xlId,Integer gwId,Integer fwId,String content,String fileUrl,String huiyuan) throws Exception{
		int result = 0;
		String sql="update t_customer set password=?,name=?,age=?,sex=?,xlId=?,gwId=?,fwId=?,content=?,fileUrl=?,huiyuan=? where id=?";
		result = db.update(sql, new Object[]{password,name,age,sex,xlId,gwId,fwId,content,fileUrl,huiyuan,id});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/upFile")
	public ResponseEntity<String> upFile(Model model,HttpServletRequest request,Long id
		,String fileUrl) throws Exception{
		int result = 0;
		String sql="insert into t_file_up(zpId,fileUrl) values(?,?)";
		result = db.update(sql, new Object[]{id,fileUrl});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/editSavemessage")
	public ResponseEntity<String> editSavemessage(Model model,HttpServletRequest request,Long id,String flag
		,String customerId,String adminId,String types,String content,String insertDate) throws Exception{
		int result = 0;
		System.out.println("adminid==="+adminId);
		String sql="insert into t_message(customerId,adminid,types,content,insertDate) values(?,?,?,?,now())";
		result = db.update(sql, new Object[]{getCustomer(request).get("id"),adminId,1,content});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	
	@RequestMapping(value = "/mine")
	public String mine(Model model, HttpServletRequest request)throws Exception {
		//判定用户是否登录，必须等录
		Map customer  =getCustomer(request);
		if(customer!=null&&customer.size()>0){
			Map bean = db.queryForMap("select * from t_customer where id="+customer.get("id"));
			model.addAttribute("map", bean);
			
			String sql="select * from t_fw";
			model.addAttribute("fwList", db.queryForList(sql));
			 sql="select * from t_xl";
			model.addAttribute("xlList", db.queryForList(sql));
			 sql="select * from t_gw";
			model.addAttribute("gwList", db.queryForList(sql));
			
			//适合我的岗位
			sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
					",(select v1 from t_xl b where b.id=a.xlId) xlName " +
					",(select v1 from t_gw b where b.id=a.gwId) gwName  from t_zp a where 1=1 ";
			String keyword1 = bean.get("gwId")==null?"":bean.get("gwId").toString();
			String keyword2 = bean.get("fwId")==null?"":bean.get("fwId").toString();
			String keyword3 = bean.get("xlId")==null?"":bean.get("xlId").toString();
			
			if(keyword1!=null&&!"".equals(keyword1)){
				sql+=" and a.gwId= "+keyword1;
			}
			if(keyword2!=null&&!"".equals(keyword2)){
				sql+=" and a.fwId= "+keyword2;
			}
			if(keyword3!=null&&!"".equals(keyword3)){
				sql+=" and a.xlId= "+keyword3;
			}
			System.out.println(sql);
			model.addAttribute("mineList", db.queryForList(sql));
			
			return "/customer/mine";
		}else{
			return "redirect:/customerLogin/login.html";
		}
		
	}
	
	
	
	

	@RequestMapping(value = "/editSaveJl")
	public ResponseEntity<String> editSaveJl(Model model,HttpServletRequest request,Long id,String v1,String v2,String v3
			,String v4,String v5,String v6,String v7,String v8) throws Exception{
		int result = 0;
		String sql="update t_customer set v1=?,v2=?,v3=?,v4=?,v5=?,v6=?,v7=?,v8=? where id=?";
		result = db.update(sql, new Object[]{v1,v2,v3,v4,v5,v6,v7,v8,getCustomer(request).get("id")});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/toudi")
	public ResponseEntity<String> toudi(Model model,HttpServletRequest request,Long id) throws Exception{
		int result = 0;
		String sql="insert into t_dzjl(zpId,customerId,status) values(?,?,'待审核')";
		result = db.update(sql, new Object[]{id,getCustomer(request).get("id")});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	
	
	@RequestMapping(value = "/detail")
	public String detail(Model model, HttpServletRequest request)throws Exception {
		Map customer  =getCustomer(request);
		if(customer!=null&&customer.size()>0){
		}else{
			return "redirect:/customerLogin/login.html";
		}
		String sql="select * from t_customer  where id="+getCustomer(request).get("id");
		model.addAttribute("map", db.queryForMap(sql));
		return "/customer/detail";
	}
	
	@RequestMapping(value = "/shows")
	public String shows(Model model, HttpServletRequest request,Long id)throws Exception {
		String sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
				",(select v1 from t_xl b where b.id=a.xlId) xlName " +
				",(select v1 from t_gw b where b.id=a.gwId) gwName" +
				",(select v1 from t_gzdd b where b.id=a.gzddId) gzddName" +
				",(select v1 from t_gzjy b where b.id=a.gzjyId) gzjyName" +
				",(select v1 from t_hyly b where b.id=a.hylyId) hylyName  from t_zp a where 1=1 and id= "+id;
		model.addAttribute("list", db.queryForList(sql));
		return "/customer/shows";
	}
	
}
