package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.CartDao;
import store.fnfm.vo.CartVO;

@Service("cartService")
public class CartServiceImpl implements CartService {
	@Autowired
	CartDao cartDao;
	
	@Override
	public void read(Map map) {
		this.cartDao.read(map);
	}

	@Override
	public void insert(Map map) {
		this.cartDao.insert(map);
		
	}

	@Override
	public void update(Map map) {
		this.cartDao.update(map);
		
	}


	@Override
	public void allDelete(String user_id) {
		this.cartDao.allDelete(user_id);
		
	}

	@Override
	public int productSum(String user_id) {
		return cartDao.productSum(user_id);
	}

	@Override
	public int updatecheck(String user_id, String pcode) {
		return cartDao.updatecheck(user_id, pcode);
	}

	@Override
	public void cartModify(Map map) {
		this.cartDao.cartModify(map);
	}

	@Override
	public void selectDel(int cart_idx) {
		this.cartDao.selectDel(cart_idx);
		
	}
	

}
