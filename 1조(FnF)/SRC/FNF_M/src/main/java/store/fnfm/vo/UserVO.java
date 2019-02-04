package store.fnfm.vo;

public class UserVO {
	private String user_id;
	private String email;
	private String user_name;
	private String birth;
	private String question;
	private String answer;
	private int status;
	private String phone;
	private String authority;

	
	public UserVO() {}


	public UserVO(String user_id, String email, String user_name, String birth, String question, String answer,
			int status, String phone, String authority) {
		this.user_id = user_id;
		this.email = email;
		this.user_name = user_name;
		this.birth = birth;
		this.question = question;
		this.answer = answer;
		this.status = status;
		this.phone = phone;
		this.authority = authority;
	}


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


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
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


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getAuthority() {
		return authority;
	}


	public void setAuthority(String authority) {
		this.authority = authority;
	}


	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", email=" + email + ", user_name=" + user_name + ", birth=" + birth
				+ ", question=" + question + ", answer=" + answer + ", status=" + status + ", phone=" + phone
				+ ", authority=" + authority + "]";
	}
	
	



	
	
	
	
}
