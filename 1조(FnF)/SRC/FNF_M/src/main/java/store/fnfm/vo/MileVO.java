package store.fnfm.vo;

public class MileVO {
	private String user_id;
	private int mile_total;
	private int mile_used;
	private int mile_remain;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getMile_total() {
		return mile_total;
	}
	public void setMile_total(int mile_total) {
		this.mile_total = mile_total;
	}
	public int getMile_used() {
		return mile_used;
	}
	public void setMile_used(int mile_used) {
		this.mile_used = mile_used;
	}
	public int getMile_remain() {
		return mile_remain;
	}
	public void setMile_remain(int mile_remain) {
		this.mile_remain = mile_remain;
	}
	@Override
	public String toString() {
		return "MileVO [user_id=" + user_id + ", mile_total=" + mile_total + ", mile_used=" + mile_used
				+ ", mile_remain=" + mile_remain + "]";
	}
	
}
