package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.mapper.ProductsMapper;
import store.fnfm.vo.Criteria;
import store.fnfm.vo.Criteria2;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.ProductsVO;


@Service
public class ProductsServiceImpl implements ProductsService {
	@Autowired
	private ProductsMapper mapper;
	
	@Override
	public List<ProductsVO> products(Criteria cri) {

		return mapper.productsWithPaging(cri);
	}
	@Override
	public List<ProductsVO> products2(Criteria2 cri) {
		
		return mapper.products2WithPaging(cri);  
	}
	@Override
	public List<ProductsVO> productc(Criteria3 cri) {
		
		return mapper.productcWithPaging(cri);
	}
	@Override
	public List<ProductsVO> productf(Criteria3 cri) {
	
		return mapper.productfWithPaging(cri);
	}
	@Override
	public List<ProductsVO> productsf() {
		
		return mapper.productf();
	}
	@Override
	public List<ProductsVO> productc2(Criteria cri) {
	
		return mapper.productc2WithPaging(cri);
	}
	@Override
	public List<ProductsVO> productf2(Criteria cri) {
		
		return mapper.productf2WithPaging(cri);
	}
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}
	@Override
	public int getTotal2(Criteria2 cri2) {
	
		return mapper.getTotalCount2(cri2);
	}
	@Override
	public int getTotal3(Criteria3 cri3) {
	
		return mapper.getTotalCount3(cri3);
	}
	@Override
	public int getTotal4(Criteria3 cri3) {
	
		return mapper.getTotalCount4(cri3);
	}
	@Override
	public int getTotal5(Criteria cri) {
	
		return mapper.getTotalCount5(cri);
	}
}
