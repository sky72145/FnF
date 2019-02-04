package store.fnfm.vo;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomerVO  implements UserDetails {
	private String user_id;
	private String email;
	private String password;
	private String user_name;
	private String phone;
	private String birth;
	private String question;
	private String answer;
	private int status;
	private String authority;
	private String regi_num;
	private String com_name;
	private String com_url;
	private int mile_total,mile_used,mile_remain;
	
	private List<AuthVO> authList;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
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
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getRegi_num() {
		return regi_num;
	}
	public void setRegi_num(String regi_num) {
		this.regi_num = regi_num;
	}
	public String getCom_name() {
		return com_name;
	}
	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}
	public String getCom_url() {
		return com_url;
	}
	public void setCom_url(String com_url) {
		this.com_url = com_url;
	}
	public int getMile_total() {
		return mile_total;
	}
	public void setMile_total(int mile_total) {
		this.mile_total = mile_total;
	}
	public int getMile_used() {
		return mile_used;
	}
	public void setMile_used(int mile_used) {
		this.mile_used = mile_used;
	}
	public int getMile_remain() {
		return mile_remain;
	}
	public void setMile_remain(int mile_remain) {
		this.mile_remain = mile_remain;
	}
	
	@Override
	public String toString() {
		return "CustomerVO [user_id=" + user_id + ", email=" + email + ", password=" + password + ", user_name="
				+ user_name + ", phone=" + phone + ", birth=" + birth + ", question=" + question + ", answer=" + answer
				+ ", status=" + status + ", authority=" + authority + ", regi_num=" + regi_num + ", com_name="
				+ com_name + ", com_url=" + com_url + ", mile_total=" + mile_total + ", mile_used=" + mile_used
				+ ", mile_remain=" + mile_remain + ", authList="+ authList + "]";
	}
	
	public void setAuthList(List<AuthVO> authList) {
		this.authList = authList;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authList;
	}
	@Override
	public String getUsername() {
		return user_id;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return true;
	}

}
