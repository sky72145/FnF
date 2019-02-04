package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.OrdersVO;

@Repository("orderSellerDAO")
public class OrderSellerDAOImpl implements OrderSellerDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void selectAll(Map map) {
		this.sqlSession.selectList("Orders.ordersSelectAll",map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Orders.ordersTotalCount",map);
	}

	@Override
	public void selectOne(Map map) {
		this.sqlSession.selectList("Orders.ordersSelectOne",map);
	}

	@Override
	public void update(OrdersVO ordersVO) {
		this.sqlSession.update("Orders.updateOrderSeller",ordersVO);
	}

	@Override
	public void SearchAll(Map map) {
		this.sqlSession.selectList("Orders.searchSelectList",map);
	}

	@Override
	public void SearchTotalCount(Map map) {
		this.sqlSession.selectOne("Orders.searchTotalCountSP",map);
	}

	@Override
	public void updateStatus(int idx) {

	}

	@Override
	public int delcodeCheck(String del_code) {
		return this.sqlSession.selectOne("Orders.delcodeCheck",del_code);
	}

	@Override
	public void getDel_url(Map map) {
		this.sqlSession.selectList("Orders.DelURLSelectOne",map);
	}

	@Override
	public int statusChange(String idx) {
		return this.sqlSession.update("Orders.StatusChange",idx);
	}

	@Override
	public int baesongwanryo(String idx) {
		return this.sqlSession.update("Orders.StatusChangeBaeSong",idx);
	}

}
