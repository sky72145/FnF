package store.fnfm.vo;

public class Criteria3 {
	private int pageNum;
	private int amount;
	public Criteria3() {
		this(1,10);
	}
	public Criteria3(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
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
	@Override
	public String toString() {
		return "Criteria3 [pageNum=" + pageNum + ", amount=" + amount + "]";
	}
	
}
