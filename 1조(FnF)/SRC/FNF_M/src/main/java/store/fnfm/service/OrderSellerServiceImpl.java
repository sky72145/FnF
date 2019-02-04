package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.OrderSellerDAO;
import store.fnfm.vo.OrdersVO;

@Service("ordersSellerSerivce")
public class OrderSellerServiceImpl implements OrderSellerService {
	@Autowired
	OrderSellerDAO orderSellerDAO;

	@Override
	public void selectAll(Map map) {
		this.orderSellerDAO.selectAll(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.orderSellerDAO.getTotalCount(map);
	}

	@Override
	public void selectOne(Map map) {
		this.orderSellerDAO.selectOne(map);
	}

	@Override
	public void update(OrdersVO ordersVO) {
		this.orderSellerDAO.update(ordersVO);
	}

	@Override
	public void SearchAll(Map map) {
		this.orderSellerDAO.SearchAll(map);
	}

	@Override
	public void SearchTotalCount(Map map) {
		this.orderSellerDAO.SearchTotalCount(map);
	}

	@Override
	public void updateStatus(int idx) {

	}

	@Override
	public int delcodeCheck(String del_code) {
		return this.orderSellerDAO.delcodeCheck(del_code);
	}

	@Override
	public void getDel_url(Map map) {
		this.orderSellerDAO.getDel_url(map);
	}

	@Override
	public int statusChange(String idx) {
		return this.orderSellerDAO.statusChange(idx);
	}

	@Override
	public int baesongwanryo(String idx) {
		return this.orderSellerDAO.baesongwanryo(idx);
	}

}
