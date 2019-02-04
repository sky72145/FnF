package store.fnfm.mapper;

import java.util.List;

import store.fnfm.vo.Criteria;
import store.fnfm.vo.Criteria2;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.ProductsVO;

public interface ProductsMapper {
	public List<ProductsVO> products(String category);
	public List<ProductsVO> products2(String category2);
	public List<ProductsVO> productc();
	public List<ProductsVO> productc2(String category);
	public List<ProductsVO> productf();
	public List<ProductsVO> productf2(String category);
	public List<ProductsVO> productsWithPaging(Criteria cri);
	public List<ProductsVO> productcWithPaging(Criteria3 cri);
	public List<ProductsVO> productfWithPaging(Criteria3 cri);
	public List<ProductsVO> products2WithPaging(Criteria2 cri);
	public List<ProductsVO> productc2WithPaging(Criteria cri);
	public List<ProductsVO> productf2WithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	public int getTotalCount2(Criteria2 cri2);
	public int getTotalCount3(Criteria3 cri3);
	public int getTotalCount4(Criteria3 cri3);
	public int getTotalCount5(Criteria cri);
}
