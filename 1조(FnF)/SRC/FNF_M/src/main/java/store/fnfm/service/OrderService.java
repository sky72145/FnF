package store.fnfm.service;

import java.util.List;
import java.util.Map;

import store.fnfm.vo.OrderVO;

public interface OrderService {
	public OrderVO userinfo(String user_id);
	public int mile_remain(String user_id);
	public void insert(Map<String, Object> map);
	public void addmile(String user_id, int mile_give);
	public void minusmile(String user_id, int add_mile);
	public void insertdetial(String idx);
	public OrderVO result(String order_id);
	public void product_update(Map map);
	void pcode_get(Map map);
	public void useraddress(Map map);
}
