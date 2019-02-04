package store.fnfm.vo;

public class SellerProductVO {
	private int idx, stock, price, sell_num, recomm;
	// 시퀀스,재고,가격,판매수,추천상품상태
	private String  pcode, sellerid, pname, pcontents, origin, unit, filename, category, category2;
	// 상품코드,판매자id,상품명,상품내용,원산지,단위,파일명,카테고리,카테고리2
	private String writedate;
	// 등록일
	
	
	public SellerProductVO() {}//default 생성자
	
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
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
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	@Override
	public String toString() {
		return "ProductVO [idx=" + idx + ", stock=" + stock + ", price=" + price + ", sell_num=" + sell_num
				+ ", recomm=" + recomm + ", pcode=" + pcode + ", sellerid=" + sellerid + ", pname=" + pname
				+ ", pcontents=" + pcontents + ", origin=" + origin + ", unit=" + unit + ", filename=" + filename
				+ ", category=" + category + ", category2=" + category2 + ", writedate=" + writedate + "]";
	}

	
}
