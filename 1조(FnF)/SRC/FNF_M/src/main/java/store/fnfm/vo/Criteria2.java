package store.fnfm.vo;

public class Criteria2 {
	private int pageNum;
	private int amount;
	private String category2;
	public Criteria2() {
		this("채소",1,10);
	}
	public Criteria2(String category2,int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.category2 = category2;
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
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	@Override
	public String toString() {
		return "Criteria2 [pageNum=" + pageNum + ", amount=" + amount + ", category2=" + category2 + "]";
	}
	
}
