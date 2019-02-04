package store.fnfm.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import store.fnfm.vo.LoginVO;

public class LoginUser extends User{

	private static final long serialVersionUID = 1L;
	private LoginVO loginVo;
	
	public LoginUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public LoginUser(LoginVO vo) {
		super(vo.getUser_id(), vo.getPassword(), vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthority()))
				.collect(Collectors.toList()));
		
		this.loginVo = vo; 
	}
}
