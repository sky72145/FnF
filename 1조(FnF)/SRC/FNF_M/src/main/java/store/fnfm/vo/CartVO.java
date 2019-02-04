package store.fnfm.vo;

public class CartVO {
	private String user_id,pname,pcode,filename;
	private int cart_idx,product_count,price,money,mile_remain,stock,idx;

	
	public CartVO() {}



	public CartVO(String user_id, String pname, String pcode, String filename, int cart_idx, int product_count,
			int price, int money, int mile_remain, int stock, int idx) {
		super();
		this.user_id = user_id;
		this.pname = pname;
		this.pcode = pcode;
		this.filename = filename;
		this.cart_idx = cart_idx;
		this.product_count = product_count;
		this.price = price;
		this.money = money;
		this.mile_remain = mile_remain;
		this.stock = stock;
		this.idx = idx;
	}



	@Override
	public String toString() {
		return "CartVO [user_id=" + user_id + ", pname=" + pname + ", pcode=" + pcode + ", filename=" + filename
				+ ", cart_idx=" + cart_idx + ", product_count=" + product_count + ", price=" + price + ", money="
				+ money + ", mile_remain=" + mile_remain + ", stock=" + stock + ", idx=" + idx + "]";
	}



	public int getIdx() {
		return idx;
	}



	public void setIdx(int idx) {
		this.idx = idx;
	}



	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getPname() {
		return pname;
	}


	public void setPname(String pname) {
		this.pname = pname;
	}


	public String getPcode() {
		return pcode;
	}


	public void setPcode(String pcode) {
		this.pcode = pcode;
	}


	public int getCart_idx() {
		return cart_idx;
	}


	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}


	public int getProduct_count() {
		return product_count;
	}


	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getMoney() {
		return money;
	}


	public void setMoney(int money) {
		this.money = money;
	}


	public int getMile_remain() {
		return mile_remain;
	}


	public void setMile_remain(int mile_remain) {
		this.mile_remain = mile_remain;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}


}