package store.fnfm.vo;


public class OrdersVO {
	private int order_idx,mile_give,mile_used,del_price,totalprice;
	private String idx,pcode,user_id,receiver_name,zipcode,address1,address2,del_message,del_code,status,order_status,user_name,phone,email,pay,pay_date,del_name;

	private int product_count;
	private String sellerid,pname,filename;
	private int price;//상품판매가
	private String del_url;

	public OrdersVO() {}

	public String getDel_url() {
		return del_url;
	}
	
	public void setDel_url(String del_url) {
		this.del_url = del_url;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getOrder_idx() {
		return order_idx;
	}

	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}

	public int getMile_give() {
		return mile_give;
	}

	public void setMile_give(int mile_give) {
		this.mile_give = mile_give;
	}

	public int getMile_used() {
		return mile_used;
	}

	public void setMile_used(int mile_used) {
		this.mile_used = mile_used;
	}

	public int getDel_price() {
		return del_price;
	}

	public void setDel_price(int del_price) {
		this.del_price = del_price;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getReceiver_name() {
		return receiver_name;
	}

	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getDel_message() {
		return del_message;
	}

	public void setDel_message(String del_message) {
		this.del_message = del_message;
	}

	public String getDel_code() {
		return del_code;
	}

	public void setDel_code(String del_code) {
		this.del_code = del_code;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	public String getPay_date() {
		return pay_date;
	}

	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}

	public String getDel_name() {
		return del_name;
	}

	public void setDel_name(String del_name) {
		this.del_name = del_name;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public String getSellerid() {
		return sellerid;
	}

	public void setSellerid(String sellerid) {
		this.sellerid = sellerid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	@Override
	public String toString() {
		return "OrdersVO [order_idx=" + order_idx + ", mile_give=" + mile_give + ", mile_used=" + mile_used
				+ ", del_price=" + del_price + ", totalprice=" + totalprice + ", idx=" + idx + ", pcode=" + pcode
				+ ", user_id=" + user_id + ", receiver_name=" + receiver_name + ", zipcode=" + zipcode + ", address1="
				+ address1 + ", address2=" + address2 + ", del_message=" + del_message + ", del_code=" + del_code
				+ ", status=" + status + ", order_status=" + order_status + ", user_name=" + user_name + ", phone="
				+ phone + ", email=" + email + ", pay=" + pay + ", pay_date=" + pay_date + ", del_name=" + del_name
				+ ", product_count=" + product_count + ", sellerid=" + sellerid + ", pname=" + pname + ", filename="
				+ filename + ", price=" + price + "]";
	}
	
	
}
