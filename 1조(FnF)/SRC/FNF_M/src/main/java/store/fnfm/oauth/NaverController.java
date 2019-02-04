package store.fnfm.oauth;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import com.github.scribejava.core.model.OAuth2AccessToken;

import store.fnfm.comm.JSONUtil;
import store.fnfm.service.CustomerService;
import store.fnfm.vo.AuthVO;
import store.fnfm.vo.CustomerVO;

@Controller
public class NaverController {
	private NaverLoginBO naverLoginBo;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBo = naverLoginBO;
	}
	
	@Autowired
	CustomerService customerService;
	
	
	//네이버 로그인 성공시 callback호출 메소드
		
	@SuppressWarnings("unchecked")
	@RequestMapping("/callback")
    public ModelAndView callback(@RequestParam String code, @RequestParam String state, HttpSession session,
    		RedirectAttributesModelMap attributesModelMap, HttpServletRequest request) throws IOException {
    	/* 네이버 아이디로 로그인 인증이 끝나면 callback처리과정에서 AccessToken을 발급*/
		OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBo.getAccessToken(session, code, state);
    	
    	/* 발급받은 AccessToken을 이용하여 현재 로그인한 네이버의 사용자 프로필 정보를 조회*/
        apiResult = naverLoginBo.getUserProfile(oauthToken);
        
        Map<String, Object> apiResultMap = JSONUtil.JsonToMap(apiResult);
        Map<String, Object> responseMap = (Map<String, Object>) apiResultMap.get("response");
        
        CustomerVO naverVo = new CustomerVO();
        
        naverVo.setEmail(responseMap.get("email").toString());
        naverVo.setUser_name(responseMap.get("name").toString());
        naverVo.setBirth(responseMap.get("birthday").toString());
        
        /* 네이버 사용자 프로필 정보를 이용하여 가입되어있는 사용자를 DB에서 조회, 가져오기 */
        CustomerVO customerVo = customerService.naverLogin(naverVo);
        
        /* 만약 일치하는 사용자가 없다면 현재 로그인한 네이버 사용자 계정으로 회원가입이 가능하도록 가입페이지로 전달 */
        if( customerVo == null ) {
        	attributesModelMap.addFlashAttribute("customerVo", naverVo);
        	
        	return new ModelAndView("redirect:/naversignup");
        }
        
        /* 만약 일치하는 사용자가 있다면 현재 세션에 사용자 로그인 정보를 저장 */
        securitySession(customerVo, request);
        return new ModelAndView("redirect:/");
        
	}
	
	private void securitySession(CustomerVO customerVO, HttpServletRequest request) {
		// 시큐리티 권한 설정
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
