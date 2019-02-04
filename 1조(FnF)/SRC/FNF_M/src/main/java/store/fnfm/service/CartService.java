package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.CartVO;

public interface CartService {
	void read(Map map);
	void insert(Map map);
	void update(Map map);
	void allDelete(String user_id);
	public int productSum(String user_id);
	public int updatecheck(String user_id, String pcode);
	void cartModify(Map map);
	void selectDel(int cart_idx);

}
