package store.fnfm.vo;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class LoginVO implements UserDetails{
	private String user_id, user_name;
	private String email;
	private String password;
	private String birth;
	private String question;
	private String answer;
	private boolean enabled;
	private List<AuthVO> authList;
	private String autority;
	
	public LoginVO() {};
	
	

	public LoginVO(String user_id, String user_name, String email, String password, String birth, String question,
			String answer, boolean enabled, List<AuthVO> authList, String autority) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.email = email;
		this.password = password;
		this.birth = birth;
		this.question = question;
		this.answer = answer;
		this.enabled = enabled;
		this.authList = authList;
		this.autority = autority;
	}




	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}



	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public List<AuthVO> getAuthList() {
		return authList;
	}
	public void setAuthList(List<AuthVO> authList) {
		this.authList = authList;
	}
	public String getAutority() {
		return autority;
	}
	public void setAutority(String autority) {
		this.autority = autority;
	}
	

	@Override
	public String toString() {
		return "LoginVO [user_id=" + user_id + ", user_name=" + user_name + ", email=" + email + ", password="
				+ password + ", birth=" + birth + ", question=" + question + ", answer=" + answer + ", enabled="
				+ enabled + ", authList=" + authList + ", autority=" + autority + "]";
	}



	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authList;
	}
	@Override
	public String getUsername() { //아이디 반환
		// TODO Auto-generated method stub
		return user_id;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}


}
