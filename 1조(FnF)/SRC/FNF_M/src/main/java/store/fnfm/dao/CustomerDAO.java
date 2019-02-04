package store.fnfm.dao;

import store.fnfm.vo.CustomerVO;

public interface CustomerDAO {
	void create(CustomerVO customerVo);
	
	void create1(CustomerVO customerVo);
	
	public int idCheck(String user_id) throws Exception;
	
	public int emailCheck(String email) throws Exception;
	
	void sellercreate(CustomerVO customerVo);
	
	void sellercreate1(CustomerVO customerVo);
	
	public int seidCheck(String user_id) throws Exception;
	
	CustomerVO naverLogin(String user_id);
	
	public int kakaoCheck(String user_id) throws Exception;

	CustomerVO kakaoLogin(String user_id);
	
	public int loginCheck(String user_id);
	
}
