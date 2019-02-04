package store.fnfm.vo;

public class Criteria {
	private int pageNum;
	private int amount;
	private String category;
	private String type;
	private String keyword;
	
	public Criteria() {
		this("농산물",1,10);
	}
	public Criteria(String category,int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.category = category;
	}
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", category=" + category + ", type=" + type
				+ ", keyword=" + keyword + "]";
	}
	
}
