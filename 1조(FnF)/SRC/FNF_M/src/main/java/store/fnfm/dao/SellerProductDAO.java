package store.fnfm.dao;

import java.util.List;
import java.util.Map;

import store.fnfm.vo.SellerProductVO;
//interface 쓰는 이유 = 다형성 루즈리카풀드
public interface SellerProductDAO {
	int pcodeCheck(String pcode);
	int create(SellerProductVO productVO);//productRegister
	void getTotalCount(Map map);//페이징
	void insertProduct(SellerProductVO productVO);//productInsert
	void selectProduct(Map map);//productDetail
	void select(Map map);//productList
	int updateProduct(SellerProductVO productVO);//productUpdate
	void deleteProduct(int idx);//delete
	List<SellerProductVO> list(SellerProductVO productVO);//검색data
	void selectSearch(Map map);//검색된 productList
	void getSearchTotalCount(Map map);//검색결과페이징
}
