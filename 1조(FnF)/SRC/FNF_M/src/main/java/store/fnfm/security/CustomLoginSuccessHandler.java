package store.fnfm.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {
		List<String> roleNames = new ArrayList<>();
		
		/*Session값 넣기*/
		String user_id = (String)request.getParameter("user_id");
		HttpSession session = request.getSession(true);
		session.setAttribute("user_id", user_id);
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		//최초 로그인 후 인덱스로 리다이렉트 해줭
		if(roleNames.contains("ROLE_ADMIN")) { 
			response.sendRedirect("/");
			return;
		}
		
		if(roleNames.contains("ROLE_USER")) {
			response.sendRedirect("/");
			return;
		}
		
		if(roleNames.contains("ROLE_SELLER")) {
			response.sendRedirect("/");
			return;
		}
		
		if(roleNames.contains("ROLE_MANAGER")) {
			response.sendRedirect("/");
			return;
		}
		/*response.sendRedirect("/");*/
	}
}
