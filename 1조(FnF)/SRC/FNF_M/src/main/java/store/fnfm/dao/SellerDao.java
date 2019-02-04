package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.SellerVO;

public interface SellerDao {
	void readAll(Map map);
	void update(SellerVO seller);
	void getTotalCount(Map map);
	void readAllNew(Map map);
	void approve(SellerVO seller);
	void read(Map map);
	void search(Map map);
	void getSearchTotalCount(Map map);
	void mail(Map map);
}
