package store.fnfm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/*")
@Controller
public class LoginController {
	
	/*@GetMapping("/all")
	public void doAll() {
		System.out.println("all");
	}
	
	@GetMapping("/member")
	public void doMember() {
		System.out.println("member");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		System.out.println("admin");
	}
	
	@GetMapping("/seller")
	public void doSeller() {
		System.out.println("seller");
	}
	
	@GetMapping("/seller/1")
	public void dodoSel() {
		System.out.println("seller 정상 작동");
	}*/
	
	@GetMapping("/signupmain")
	public void signup() {
		System.out.println("Going to Signup Main");
	}
	
	/*@GetMapping("login")
	public void login() {
		System.out.println("Going to login");
	}*/
}
