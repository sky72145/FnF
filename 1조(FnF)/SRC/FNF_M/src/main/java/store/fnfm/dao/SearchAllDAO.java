package store.fnfm.dao;

import java.util.List;

import store.fnfm.vo.ProductVO;

public interface SearchAllDAO {
	public List<ProductVO> searchAll(String keyword) throws Exception;
	public int searchAllCount(String keyword) throws Exception;
}
