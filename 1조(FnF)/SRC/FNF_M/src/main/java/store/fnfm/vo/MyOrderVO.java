package store.fnfm.vo;

public class MyOrderVO {
	private String idx;
	private String del_code;
	private int totalprice;
	private String status;
	private int product_count;
	private String pname;
	private String filename;
	private String user_id;
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getDel_code() {
		return del_code;
	}
	public void setDel_code(String del_code) {
		this.del_code = del_code;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "MyOrderVO [idx=" + idx + ", del_code=" + del_code + ", totalprice=" + totalprice + ", status=" + status
				+ ", product_count=" + product_count + ", pname=" + pname + ", filename=" + filename + ", user_id="
				+ user_id + "]";
	}
	
	
}
