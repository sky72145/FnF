package store.fnfm.dao;

import java.util.List;

import store.fnfm.vo.ProductVO;

public interface MainProductDAO {
	public List<ProductVO> nList();
	public List<ProductVO> sList();
	public List<ProductVO> gList();
	public List<ProductVO> mdList();
	public List<ProductVO> hList();
}
