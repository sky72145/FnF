package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.OrdersVO;

public interface OrderSellerService {
	int delcodeCheck(String del_code);//송장번호중복체크
	int statusChange(String idx);//입금대기 --> 결제완료
	int baesongwanryo(String idx);//배송중 --> 배송완료
	
	void selectAll(Map map);//주문리스트
	void getTotalCount(Map map);//주문리스트페이징
	
	void selectOne(Map map);//주문한개view
	void update(OrdersVO ordersVO);//수정
	
	void SearchAll(Map map);//검색된 주문리스트
	void SearchTotalCount(Map map);//검색결과페이징
	
	void updateStatus(int idx);//주문상태값 변경
	void getDel_url(Map map);//del_url 가져오기
}
