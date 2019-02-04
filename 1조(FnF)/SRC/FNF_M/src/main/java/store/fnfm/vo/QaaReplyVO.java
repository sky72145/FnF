package store.fnfm.vo;

public class QaaReplyVO {
	private int idx;
	private int parent;
	private String text;
	private String regdate;
	private String updatedate;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	@Override
	public String toString() {
		return "FaqReplyVO [idx=" + idx + ", parent=" + parent + ", text=" + text + ", regdate=" + regdate
				+ ", updatedate=" + updatedate + "]";
	}
	
	
}
