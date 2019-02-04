package store.fnfm.vo;

public class QaaVO {
	private int idx, readnum, grp, lev, step, reply_status;
	private String user_id, password, title, contents, writedate, filename, status;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getReadnum() {
		return readnum;
	}
	public void setReadnum(int readnum) {
		this.readnum = readnum;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getReply_status() {
		return reply_status;
	}
	public void setReply_status(int reply_status) {
		this.reply_status = reply_status;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "QaaVO [idx=" + idx + ", readnum=" + readnum + ", grp=" + grp + ", lev=" + lev + ", step=" + step
				+ ", reply_status=" + reply_status + ", user_id=" + user_id + ", password=" + password + ", title="
				+ title + ", contents=" + contents + ", writedate=" + writedate + ", filename=" + filename + ", status="
				+ status + "]";
	}
}
