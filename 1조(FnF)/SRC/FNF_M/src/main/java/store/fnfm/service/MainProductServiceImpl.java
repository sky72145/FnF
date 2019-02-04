package store.fnfm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.MainProductDAO;
import store.fnfm.vo.ProductVO;

@Service("mainProductService")
public class MainProductServiceImpl implements MainProductService {

	@Autowired
	MainProductDAO mainProductDao;
	
	@Override
	public List<ProductVO> nList() {
		return mainProductDao.nList();
	}

	@Override
	public List<ProductVO> sList() {
		return mainProductDao.sList();
	}

	@Override
	public List<ProductVO> gList() {
		return mainProductDao.gList();
	}

	@Override
	public List<ProductVO> mdList() {
		return mainProductDao.mdList();
	}

	@Override
	public List<ProductVO> hList() {
		return mainProductDao.hList();
	}

}
