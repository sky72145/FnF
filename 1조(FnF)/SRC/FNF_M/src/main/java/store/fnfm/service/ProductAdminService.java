package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.ProductVO;
import store.fnfm.vo.SellerVO;

public interface ProductAdminService {
	void select(Map map);
	void getTotalCount(Map map);
	void selectRecomm(Map map);
	void selectRecomm1(Map map);
	void getRecommTotalCount(Map map);
	void updateRecomm(ProductVO product);
	void updateRecomm1(ProductVO product);
	void deleteProduct(String pcode);
	void search(Map map);
	void getSearchTotalCount(Map map);
}
