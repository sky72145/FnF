package store.fnfm.vo;

public class MyMessageVO {
	int idx;
	//메시지시퀀스
	String send_id, receive_id, title, contents, writedate,status,del_status,del_status2;
	//보내는이,받는이,제목,내용,작성일,읽은상태,삭제상태
	
	public MyMessageVO() {}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getSend_id() {
		return send_id;
	}

	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}

	public String getReceive_id() {
		return receive_id;
	}

	public void setReceive_id(String receive_id) {
		this.receive_id = receive_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDel_status() {
		return del_status;
	}

	public void setDel_status(String del_status) {
		this.del_status = del_status;
	}
	public String getDel_status2() {
		return del_status2;
	}

	public void setDel_status2(String del_status2) {
		this.del_status2 = del_status2;
	}

	@Override
	public String toString() {
		return "MessageVO [idx=" + idx + ", send_id=" + send_id + ", receive_id=" + receive_id + ", title=" + title
				+ ", contents=" + contents + ", writedate=" + writedate + ", status=" + status + ", del_status="
				+ del_status + ", del_status2=" + del_status2 + "]";
	}
	
	
	
	
	
}
