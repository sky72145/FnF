package store.fnfm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.OrderDao;
import store.fnfm.vo.OrderVO;

@Service("orderService")
public class OrderServiceImple implements OrderService {
	@Autowired
	OrderDao orderDao;

	@Override
	public int mile_remain(String user_id) {
		return orderDao.mile_remain(user_id);
		
	}

	@Override
	public void insert(Map<String, Object> map) {
		this.orderDao.insert(map);
	}

	@Override
	public void addmile(String user_id, int mile_give) {
		this.orderDao.addmile(user_id, mile_give);
		
	}

	@Override
	public void minusmile(String user_id, int add_mile) {
		this.orderDao.minusmile(user_id, add_mile);
	}

	@Override
	public void insertdetial(String idx) {
		this.orderDao.insertdetial(idx);
		
	}

	@Override
	public OrderVO result(String order_id) {
		return orderDao.result(order_id);
	}

	@Override
	public OrderVO userinfo(String user_id) {
		return orderDao.userinfo(user_id);
	}

	@Override
	public void product_update(Map map) {
		this.orderDao.product_update(map);
		
	}

	@Override
	public void pcode_get(Map map) {
		this.orderDao.pcode_get(map);
		
	}

	@Override
	public void useraddress(Map map) {
		this.orderDao.useraddress(map);
		
	}
	


}
