package store.fnfm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import store.fnfm.oauth.NaverLoginBO;
import store.fnfm.service.CustomerService;
		


@Controller
public class CommonController {
	private NaverLoginBO naverLoginBo;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBo = naverLoginBO;
	}
	
	@Autowired
	CustomerService customerService;
	
	@GetMapping("/login")
	public String loginInput(String error, String logout, Model model, HttpSession session) {
		/*if (flag == 0 && session.getAttribute("user_id") == null) {
			model.addAttribute("nolog", "로그인이 필요한 서비스입니다.");
		}*/
		
		System.out.println("error : " + error);
		System.out.println("logout : " + logout);
		
		//로그인 에러 메세지 처리
		if(error != null) {
			model.addAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃되었습니다.");
		}
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBo.getAuthorizationUrl(session);
		
		System.out.println("This is NaverController");
		//System.out.println("네이버:" + naverAuthUrl);
		
		//네이버 로그인 화면
		model.addAttribute("url", naverAuthUrl);
		
		return "login";
	}
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		System.out.println("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/logout")
	public void logoutGet() {
		System.out.println("logouttttttt");
	}
	
	@PostMapping("/logout")
	public void logoutPost() {
		System.out.println("logoutttttttpost");
	}
	
	@RequestMapping(value="/find", method=RequestMethod.GET)
    public String find() {        
        return "find";
    }
}
