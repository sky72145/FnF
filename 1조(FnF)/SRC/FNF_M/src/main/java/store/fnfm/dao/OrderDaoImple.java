package store.fnfm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.OrderVO;

@Repository("orderDao")
public class OrderDaoImple implements OrderDao {
	@Autowired
	SqlSession sqlSession;

	@Override
	public int mile_remain(String user_id) {
		return sqlSession.selectOne("Order.mile_remain",user_id);
		
	}

	@Override
	public void insert(Map<String, Object> map) {
		this.sqlSession.insert("Order.insertOrder",map);
		
	}

	@Override
	public void addmile(String user_id, int mile_give) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("mile_give", mile_give);
		this.sqlSession.update("Order.addMile",map);
		
	}

	@Override
	public void minusmile(String user_id, int mile_used) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("mile_used", mile_used);
		this.sqlSession.update("Order.minusMile",map);
		
	}

	@Override
	public void insertdetial(String idx) {
		this.sqlSession.insert("Order.insertDetial",idx);
		
	}

	@Override
	public OrderVO result(String order_id) {
		return sqlSession.selectOne("Order.result", order_id);
		
	}

	@Override
	public OrderVO userinfo(String user_id) {
		return sqlSession.selectOne("Order.userinfo",user_id);
	}

	@Override
	public void product_update(Map map) {
		this.sqlSession.update("Order.product_update",map);
	}

	@Override
	public void pcode_get(Map map) {
		this.sqlSession.selectOne("Order.pcode",map);
		
	}

	@Override
	public void useraddress(Map map) {
		 this.sqlSession.selectList("Order.useraddress",map);
		
		
	}

	



}
