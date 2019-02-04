package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.ProductAdminDao;
import store.fnfm.vo.ProductVO;

@Service("productAdminService")
public class ProductAdminServiceImpl implements ProductAdminService {
	@Autowired
	ProductAdminDao productAdminDao;
	
	@Override
	public void select(Map map) {
		this.productAdminDao.readAll(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.productAdminDao.getTotalCount(map);
	}

	@Override
	public void selectRecomm(Map map) {
		this.productAdminDao.readrecomm(map);
	}

	@Override
	public void selectRecomm1(Map map) {
		this.productAdminDao.readrecomm1(map);
	}

	@Override
	public void getRecommTotalCount(Map map) {
		this.productAdminDao.getRecommTotalCount(map);
	}

	@Override
	public void updateRecomm(ProductVO product) {
		this.productAdminDao.updaterecomm(product);
	}

	@Override
	public void updateRecomm1(ProductVO product) {
		this.productAdminDao.updaterecomm1(product);
	}

	@Override
	public void deleteProduct(String pcode) {
		this.productAdminDao.delete(pcode);
	}

	@Override
	public void search(Map map) {
		this.productAdminDao.search(map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.productAdminDao.getSearchTotalCount(map);
	}

}
