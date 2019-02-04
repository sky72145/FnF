package store.fnfm.vo;

public class ProductVO {
	private int idx;
	private String sellerid;
	private String pcode;
	private String pname;
	private String pcontents;
	private String origin;
	private String unit;
	private String filename;
	private String category;
	private int stock;
	private int price;
	private int sell_num;
	private int recomm;
	private String writedate;
	private String category2;
	
	public ProductVO() {}

	public ProductVO(int idx, String sellerid, String pcode, String pname, String pcontents, String origin, String unit,
			String filename, String category, int stock, int price, int sell_num, int recomm, String writedate,
			String category2) {
		this.idx = idx;
		this.sellerid = sellerid;
		this.pcode = pcode;
		this.pname = pname;
		this.pcontents = pcontents;
		this.origin = origin;
		this.unit = unit;
		this.filename = filename;
		this.category = category;
		this.stock = stock;
		this.price = price;
		this.sell_num = sell_num;
		this.recomm = recomm;
		this.writedate = writedate;
		this.category2 = category2;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getSellerid() {
		return sellerid;
	}

	public void setSellerid(String sellerid) {
		this.sellerid = sellerid;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPcontents() {
		return pcontents;
	}

	public void setPcontents(String pcontents) {
		this.pcontents = pcontents;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getSell_num() {
		return sell_num;
	}

	public void setSell_num(int sell_num) {
		this.sell_num = sell_num;
	}

	public int getRecomm() {
		return recomm;
	}

	public void setRecomm(int recomm) {
		this.recomm = recomm;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}

	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}

	@Override
	public String toString() {
		return "ProductVO [idx=" + idx + ", sellerid=" + sellerid + ", pcode=" + pcode + ", pname=" + pname
				+ ", pcontents=" + pcontents + ", origin=" + origin + ", unit=" + unit + ", filename=" + filename
				+ ", category=" + category + ", stock=" + stock + ", price=" + price + ", sell_num=" + sell_num
				+ ", recomm=" + recomm + ", writedate=" + writedate + ", category2=" + category2 + "]";
	}
	
	
}
