package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.Criteria;
import store.fnfm.vo.Criteria2;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.ProductsVO;

public interface ProductsService {
	public List<ProductsVO> products(Criteria cri);
	public List<ProductsVO> products2(Criteria2 cri);
	public List<ProductsVO> productc(Criteria3 cri);
	public List<ProductsVO> productf(Criteria3 cri);
	public List<ProductsVO> productsf();
	public List<ProductsVO> productc2(Criteria cri);
	public List<ProductsVO> productf2(Criteria cri);
	public int getTotal(Criteria cri);
	public int getTotal2(Criteria2 cri2);
	public int getTotal3(Criteria3 cri3);
	public int getTotal4(Criteria3 cri3);
	public int getTotal5(Criteria cri);
}
