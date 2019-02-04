package store.fnfm.vo;


/*user_id     CHAR(15)        NOT NULL, 
email       CHAR(50)        NOT NULL, 
password    CHAR(20)        NOT NULL, 
username    VARCHAR2(20)    NOT NULL, 
phone       CHAR(13)        NOT NULL, 
birth       CHAR(8)         NOT NULL, 
question    CHAR(50)        NOT NULL, 
answer      CHAR(50)        NOT NULL, 
status      NUMBER(1, 0)    NOT NULL, */
public class MemberVO {
	private String user_id, email, password, username, phone, birth, question, answer;
	private int status;
	
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	@Override
	public String toString() {
		return "MemberVO [user_id=" + user_id + ", email=" + email + ", password=" + password + ", username=" + username
				+ ", phone=" + phone + ", birth=" + birth + ", question=" + question + ", answer=" + answer
				+ ", status=" + status + "]";
	}
	
	
}
