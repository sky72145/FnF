package store.fnfm.vo;

public class InquiryVO {
	int idx;//문의 번호
	String user_id, pcode, in_contents, in_writedate;
	//작성자, 상품번호, 문의내용, 문의작성일
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getIn_contents() {
		return in_contents;
	}
	public void setIn_contents(String in_contents) {
		this.in_contents = in_contents;
	}
	public String getIn_writedate() {
		return in_writedate;
	}
	public void setIn_writedate(String in_writedate) {
		this.in_writedate = in_writedate;
	}
	
	@Override
	public String toString() {
		return "InquiryVO [idx=" + idx + ", user_id=" + user_id + ", pcode=" + pcode + ", in_contents=" + in_contents
				+ ", in_writedate=" + in_writedate + "]";
	}
	
}
