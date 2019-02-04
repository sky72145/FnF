package store.fnfm.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.CartVO;

@Repository("cartDao")
public class CartDaoImpl implements CartDao {
	@Autowired
	SqlSession sqlSession;
		
	@Override
	public void read(Map map) {
		this.sqlSession.selectList("Cart.select", map);
	}

	@Override
	public void insert(Map map) {
		this.sqlSession.insert("Cart.insert", map);
		
	}

	@Override
	public void update(Map map) {
		this.sqlSession.update("Cart.update", map);
		
	}

	@Override
	public void allDelete(String user_id) {
		this.sqlSession.delete("Cart.allDelete", user_id);
		
	}

	@Override
	public int productSum(String user_id) {
		/*sqlSession.selectOne("Cart.productSum",user_id);*/
		return sqlSession.selectOne("Cart.productSum",user_id);
	}

	@Override
	public int updatecheck(String user_id, String pcode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("pcode", pcode);
		return sqlSession.selectOne("Cart.updatecheck",map);
		
	}

	@Override
	public void cartModify(Map map) {
		this.sqlSession.update("Cart.cartModify",map);
	}

	@Override
	public void selectDel(int cart_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cart_idx", cart_idx);
		/*map.put("user_id", user_id);*/
		this.sqlSession.delete("Cart.selectDelete",map);
		
	}

	

}
