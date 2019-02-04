/*CREATE TABLE FARM.PRODUCT (
  IDX          NUMBER(6)                   NULL, 
  SELLERID     VARCHAR2(20 BYTE)       NOT NULL, 
  PCODE        VARCHAR2(20 BYTE)       NOT NULL, 
  PNAME        VARCHAR2(20 BYTE)       NOT NULL, 
  PCONTENTS    VARCHAR2(2000 BYTE)     NOT NULL, 
  ORIGIN       VARCHAR2(50 BYTE)       NOT NULL, 
  UNIT         VARCHAR2(10 BYTE)       NOT NULL, 
  FILENAME     VARCHAR2(200 BYTE)      NOT NULL, 
  CATEGORY     VARCHAR2(20 BYTE)       NOT NULL, 
  STOCK        NUMBER(5)               NOT NULL, 
  PRICE        NUMBER(9)               NOT NULL, 
  SELL_NUM     NUMBER(6)              DEFAULT 0                   NULL, 
  RECOMM       NUMBER(1)              DEFAULT 0                   NULL, 
  WRITEDATE    DATE                    NOT NULL, 
  CATEGORY2    VARCHAR2(20 BYTE)       NOT NULL
)*/
package store.fnfm.vo;

public class Product2VO {
	private int idx, stock, price, sell_num, recomm;
	private String sellerid, pcode, pname, pcontents, origin, unit, filename, category, writedate, category2;
	
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
	
	
}
