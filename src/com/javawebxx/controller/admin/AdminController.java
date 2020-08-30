
package com.javawebxx.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javawebxx.controller.MyController;

@Controller("adminController")
@RequestMapping(value = "/admin")
public class AdminController extends MyController {
	

	@RequestMapping(value = "/index")
	public String frame(Model model, HttpServletRequest request)throws Exception {
		return "/admin/index";
	}
	
	@RequestMapping(value = "/main")
	public String main(Model model, HttpServletRequest request)throws Exception {
		return "/admin/main";
	}
	
	
	@RequestMapping(value = "/changePassword")
	public ResponseEntity<String> loginSave(Model model,HttpServletRequest request,String password) throws Exception {
		Map admin = getAdmin(request);
		String sql="update t_admin set password=? where id=?";
		db.update(sql, new Object[]{password,admin.get("id")});
		return renderData(true,"1",null);
	}
	
}
