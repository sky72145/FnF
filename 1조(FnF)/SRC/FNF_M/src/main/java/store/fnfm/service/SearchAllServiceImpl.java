package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.SearchAllDAO;
import store.fnfm.vo.ProductVO;

@Service("searchAllSerivce")
public class SearchAllServiceImpl implements SearchAllService {

	@Autowired
	SearchAllDAO searchAllDao;
	
	@Override
	public List<ProductVO> searchAll(String keyword) throws Exception {
		return searchAllDao.searchAll(keyword);
	}

	@Override
	public int searchAllCount(String keyword) throws Exception {
		return searchAllDao.searchAllCount(keyword);
	}

}
