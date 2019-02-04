package store.fnfm.vo;

public class Criteria4 {
	private int pageNum;
	private int amount;
	private String send_id;
	public Criteria4(String send_id,int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.send_id = send_id;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getSend_id() {
		return send_id;
	}
	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}
	@Override
	public String toString() {
		return "Criteria2 [pageNum=" + pageNum + ", amount=" + amount + ", send_id=" + send_id + "]";
	}
	
}
