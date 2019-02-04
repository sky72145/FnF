package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.ProductVO;

public interface SearchAllService {
	public List<ProductVO> searchAll(String keyword) throws Exception;
	public int searchAllCount(String keyword) throws Exception;
}
