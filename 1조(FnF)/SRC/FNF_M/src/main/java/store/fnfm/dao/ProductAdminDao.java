package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.ProductVO;

public interface ProductAdminDao {
	void readAll(Map map);
	void getTotalCount(Map map);
	void readrecomm(Map map);
	void readrecomm1(Map map);
	void getRecommTotalCount(Map map);
	void updaterecomm(ProductVO product);
	void updaterecomm1(ProductVO product);
	void delete(String pcode);
	void search(Map map);
	void getSearchTotalCount(Map map);
}
