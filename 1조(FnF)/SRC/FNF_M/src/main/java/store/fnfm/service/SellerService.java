package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.SellerVO;

public interface SellerService {
	void select(Map map);
	void updateBoard(SellerVO seller);
	void getTotalCount(Map map);
	void selectNew(Map map);
	void approveSeller(SellerVO seller);
	void selectSeller(Map map);
	void search(Map map);
	void getSearchTotalCount(Map map);
	void mail(Map map);
}
