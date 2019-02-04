package store.fnfm.vo;

public class OrderVO {
	private int cart_idx,del_idx,pat_date,mile_give,mile_used,del_price,totalprice;
	private String idx,pcode,user_id,receiver_name,zipcode,address1,address2,del_message,del_code,status,order_status,user_name,phone,email,pay,pay_date;
	
	public OrderVO() {}

	public OrderVO(String pay_date, int cart_idx, int del_idx, int pat_date, int mile_give, int mile_used, int del_price,
			int totalprice, String idx, String pcode, String user_id, String receiver_name, String zipcode,
			String address1, String address2, String del_message, String del_code, String status, String order_status,
			String user_name, String phone, String email, String pay) {
		super();
		this.pay_date = pay_date;
		this.cart_idx = cart_idx;
		this.del_idx = del_idx;
		this.pat_date = pat_date;
		this.mile_give = mile_give;
		this.mile_used = mile_used;
		this.del_price = del_price;
		this.totalprice = totalprice;
		this.idx = idx;
		this.pcode = pcode;
		this.user_id = user_id;
		this.receiver_name = receiver_name;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.del_message = del_message;
		this.del_code = del_code;
		this.status = status;
		this.order_status = order_status;
		this.user_name = user_name;
		this.phone = phone;
		this.email = email;
		this.pay = pay;
	}

	@Override
	public String toString() {
		return "OrderVO [pay_date=" + pay_date + ", cart_idx=" + cart_idx + ", del_idx=" + del_idx + ", pat_date="
				+ pat_date + ", mile_give=" + mile_give + ", mile_used=" + mile_used + ", del_price=" + del_price
				+ ", totalprice=" + totalprice + ", idx=" + idx + ", pcode=" + pcode + ", user_id=" + user_id
				+ ", receiver_name=" + receiver_name + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2="
				+ address2 + ", del_message=" + del_message + ", del_code=" + del_code + ", status=" + status
				+ ", order_status=" + order_status + ", user_name=" + user_name + ", phone=" + phone + ", email="
				+ email + ", pay=" + pay + "]";
	}

	public String getPay_date() {
		return pay_date;
	}

	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}

	public int getCart_idx() {
		return cart_idx;
	}

	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}

	public int getDel_idx() {
		return del_idx;
	}

	public void setDel_idx(int del_idx) {
		this.del_idx = del_idx;
	}

	public int getPat_date() {
		return pat_date;
	}

	public void setPat_date(int pat_date) {
		this.pat_date = pat_date;
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

	
}
