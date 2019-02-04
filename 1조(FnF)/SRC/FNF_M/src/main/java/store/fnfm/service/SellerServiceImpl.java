package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.SellerDao;
import store.fnfm.vo.SellerVO;

@Service("sellerService")
public class SellerServiceImpl implements SellerService {

	@Autowired
	SellerDao sellerDao;
	
	@Override
	public void select(Map map) {
		this.sellerDao.readAll(map);
	}

	@Override
	public void updateBoard(SellerVO seller) {
		this.sellerDao.update(seller);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sellerDao.getTotalCount(map);		
	}

	@Override
	public void selectNew(Map map) {
		this.sellerDao.readAllNew(map);
	}

	@Override
	public void approveSeller(SellerVO seller) {
		this.sellerDao.approve(seller);
	}

	@Override
	public void selectSeller(Map map) {
		this.sellerDao.read(map);
	}

	@Override
	public void search(Map map) {
		this.sellerDao.search(map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.sellerDao.getSearchTotalCount(map);
	}

	@Override
	public void mail(Map map) {
		this.sellerDao.mail(map);
	}

}
