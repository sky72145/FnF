package store.fnfm.vo;

public class Criteria5 {
	private int pageNum;
	private int amount;
	private String receive_id;
	public Criteria5(String receive_id,int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.receive_id = receive_id;
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
	public String getreceive_id() {
		return receive_id;
	}
	public void setreceive_id(String receive_id) {
		this.receive_id = receive_id;
	}
	@Override
	public String toString() {
		return "Criteria2 [pageNum=" + pageNum + ", amount=" + amount + ", receive_id=" + receive_id + "]";
	}
	
}
