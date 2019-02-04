package store.fnfm.vo;

import org.springframework.security.core.GrantedAuthority;

public class AuthVO implements GrantedAuthority {
	private static final long serialVersionUID = 1L;
	private String user_id;
	private String authority;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	@Override
	public String toString() {
		return "AuthVO [user_id=" + user_id + ", authority=" + authority + "]";
	}
}
