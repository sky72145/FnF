package store.fnfm.oauth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import store.fnfm.service.CustomerService;
import store.fnfm.vo.AuthVO;
import store.fnfm.vo.CustomerVO;

@Controller
public class KakaoController {
	@Autowired
	CustomerService customerService;
	
	@RequestMapping(value="/kakaoLoginCheck/{user_id}", method=RequestMethod.POST)
    @ResponseBody
    public Map<Object, Object> kakaoidCheck(@PathVariable String user_id,
    		HttpServletRequest request) throws Exception {
        
        int count = 0;
        Map<Object, Object> map = new HashMap<Object, Object>();
        System.out.println(user_id);
        count = customerService.kakaoIdCheck(user_id);
       // System.out.println("count = " + count);
        map.put("cnt", count);
        
        if (count != 0) {
        	securitySession(customerService.kakaoLogin(user_id), request);
        }
        
        return map;
    }
	
	@RequestMapping(value="/kakaosignup", method=RequestMethod.GET)
    public String find(String kakaoid, ModelMap model) {        
		model.addAttribute("kakaoid", kakaoid);
        return "signup/kakaosignup";
    }
	
	private void securitySession(CustomerVO customerVO, HttpServletRequest request) {
		AuthVO authVO = new AuthVO();
		authVO.setAuthority(customerVO.getAuthority());
		
		List<AuthVO> list = new ArrayList<>();
		
		list.add(authVO);
		
		customerVO.setAuthList(list);
		
		// customerVO, 패스워드, 권한
		Authentication auth = new UsernamePasswordAuthenticationToken(customerVO, customerVO.getPassword(), customerVO.getAuthorities());
		SecurityContext securityContext = SecurityContextHolder.getContext();
		securityContext.setAuthentication(auth);
		
		HttpSession session = request.getSession(true);
		
		session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
		session.setAttribute("user_id", customerVO.getUser_id());
	}
}

