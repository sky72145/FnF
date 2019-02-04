package store.fnfm.dao;

import java.util.List;
import java.util.Map;



import store.fnfm.vo.OrderVO;

public interface OrderDao {
	/*배송지에 회원정보 가지고옴*/
	public OrderVO userinfo(String user_id);
	/*남은 마일리지 적립*/
	public int mile_remain(String user_id);
	/*order 테이블 입력*/
	public void insert(Map<String, Object> map);
	/*마일리지 적립*/
	public void addmile(String user_id, int mile_give);
	/*사용마일리지*/
	public void minusmile(String user_id, int add_mile);
	/*order detial 삽입*/
	public void insertdetial(String idx);
	/*주문완료후 데이터 출력*/
	public OrderVO result(String order_id);
	/*product 테이블 갯수조절*/
	public void product_update(Map map);
	/*pcode 갯수*/
	void pcode_get(Map map);
	/*최근배송지*/
	public void useraddress(Map map);
}
