package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.CartVO;

public interface CartDao {
	/*CartVO read(String user_id); 일반*/
	
	/*userid 로 장바구니리스트 출력*/
	void read(Map map);
	/*장바구니 추가 */
	void insert(Map map);
	 /*cartid로 입력 갯수 수정*/
	void update(Map map);
	/*userid 로 카트전체리스트 삭제*/
	void allDelete(String user_id);
	/*userid로 장바구니 금액 전체합계*/
	public int productSum(String user_id);
	/*카트 수량체크*/
	public int updatecheck(String user_id, String pcode);
	/*카트 수량 수정*/
	void cartModify(Map map);
	/*선택상품 삭제*/
	void selectDel(int cart_idx);

	
	
	
}
