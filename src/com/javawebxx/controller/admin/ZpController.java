
package com.javawebxx.controller.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("zpController")
@RequestMapping(value = "/admin/zp")
public class ZpController extends MyController {
	

	@RequestMapping(value = "/frame")
	public String frame(Model model, HttpServletRequest request)throws Exception {
		return "/admin/zp/frame";
	}
	
	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request,String keyword)throws Exception {
		String sql="select a.*,(select v1 from t_fw b where b.id=a.fwId) fwName" +
				",(select v1 from t_xl b where b.id=a.xlId) xlName " +
				",(select v1 from t_gw b where b.id=a.gwId) gwName" +
				",(select v1 from t_gzdd b where b.id=a.gzddId) gzddName" +
				",(select v1 from t_gzjy b where b.id=a.gzjyId) gzjyName" +
				",(select v1 from t_hyly b where b.id=a.hylyId) hylyName  from t_zp a where 1=1 and adminId= "+getAdmin(request).get("id");
		if(keyword!=null&&!"".equals(keyword)){
			sql+=" and title like '%"+keyword+"%'";
		}
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/zp/list";
	}
	
	@RequestMapping(value = "/tdList")
	public String tdList(Model model, HttpServletRequest request,Long id)throws Exception {
		String sql="select * from t_file_up where zpId="+id;
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/zp/tdList";
	}
	
	@RequestMapping(value = "/dzList")
	public String dzList(Model model, HttpServletRequest request,Long id)throws Exception {
		String sql="select a.*,(select max(status) from t_dzjl b where b.customerId=a.id ) status,(select max(id) from t_dzjl b where b.customerId=a.id ) ppId from t_customer a where exists(select 1 from t_dzjl b where a.id=b.customerId and b.zpId='"+id+"') ";
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/zp/dzList";
	}
	
	@RequestMapping(value = "/dzList3")
	public String dzList3(Model model, HttpServletRequest request,Long id)throws Exception {
		String sql="select a.*,(select max(status) from t_dzjl b where b.customerId=a.id ) status," +
				"(select max(id) from t_dzjl b where b.customerId=a.id ) ppId from " +
				"t_customer a where exists(select 1 from t_dzjl b where a.id=b.customerId  and b.status='通过') ";
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/zp/dzList3";
	}
	
	@RequestMapping(value = "/dzList2")
	public String dzList2(Model model, HttpServletRequest request,Long id)throws Exception {
		String sql="select a.*,(select max(status) from t_dzjl b where b.zpId=a.id ) status,(select max(id) from t_dzjl b where b.zpId=a.id ) ppId from t_zp a where exists(select 1 from t_dzjl b where a.id=b.zpId and b.customerId='"+getCustomer(request).get("id")+"' ) ";
		sql+=" order by id desc";
		List list = db.queryForList(sql);
		request.setAttribute("list", list);
		return "/admin/zp/dzList2";
	}
	
	@RequestMapping(value = "/updateColumnstatus")
	public ResponseEntity<String> updateColumnstatus(Model model,HttpServletRequest request,Long id,String status,String aaa) throws Exception {
		
		String sql="update t_dzjl set status=?   where id=?";
		int result = db.update(sql, new Object[]{status,id});
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
		
	}
	
	@RequestMapping(value = "/editSave")
	public ResponseEntity<String> editSave(Model model,HttpServletRequest request,Long id,String jn
		,Integer xlId,Integer gwId,Integer fwId,String title,String content,String number,String address,String huiyuan,Integer gzddId,Integer gzjyId,Integer hylyId) throws Exception{
		int result = 0;
		if(id!=null){
			String sql="update t_zp set jn=?, xlId=?,gwId=?,fwId=?,title=?,content=?,number=?,address=?,huiyuan=? where id=?";
			result = db.update(sql, new Object[]{jn,xlId,gwId,fwId,title,content,number,address,huiyuan,id});
		}else{
			String sql="insert into t_zp(gzddId,gzjyId,hylyId,xlId,gwId,fwId,title,content,number,address,huiyuan,jn,adminId) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			result = db.update(sql, new Object[]{gzddId,gzjyId,hylyId,xlId,gwId,fwId,title,content,number,address,huiyuan,jn,getAdmin(request).get("id").toString()});
		}
		if(result==1){
			return renderData(true,"操作成功",null);
		}else{
			return renderData(false,"操作失败",null);
		}
	}
	
	@RequestMapping(value = "/editDelete")
	public ResponseEntity<String> editDelete(Model model,HttpServletRequest request,Long id) throws Exception {
		
		String sql="delete from t_zp where id=?";
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
			String sql="select * from t_zp where id=?";
			Map map = db.queryForMap(sql,new Object[]{id});
			model.addAttribute("map", map);
		}
		String sql="select * from t_fw";
		model.addAttribute("fwList", db.queryForList(sql));
		 sql="select * from t_xl";
		model.addAttribute("xlList", db.queryForList(sql));
		 sql="select * from t_gw";
		model.addAttribute("gwList", db.queryForList(sql));
		
		sql="select * from t_gzdd";
		model.addAttribute("gzddList", db.queryForList(sql));
		sql="select * from t_gzjy";
		model.addAttribute("gzjyList", db.queryForList(sql));
		sql="select * from t_hyly";
		model.addAttribute("hylyList", db.queryForList(sql));
		return "/admin/zp/edit";
	}
}
