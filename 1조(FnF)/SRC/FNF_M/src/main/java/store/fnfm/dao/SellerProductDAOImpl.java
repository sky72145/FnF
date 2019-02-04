package store.fnfm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.SellerProductVO;

@Repository("sellerProductDAO")
public class SellerProductDAOImpl implements SellerProductDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int pcodeCheck(String pcode) {
		return this.sqlSession.selectOne("SellerProduct.pcodeCheck",pcode);
	}
	@Override
	public int create(SellerProductVO productVO) {
		return this.sqlSession.insert("SellerProduct.insert",productVO);
	}
	
	@Override
	public void insertProduct(SellerProductVO productVO) {
		this.sqlSession.insert("SellerProduct.insertSP",productVO);//namespace.id
	}

	@Override
	public void selectProduct(Map map) {
		this.sqlSession.selectOne("SellerProduct.selectOneSP",map);
	}

	@Override
	public void select(Map map) {
		this.sqlSession.selectList("SellerProduct.selectAllSP",map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("SellerProduct.selectTotalCountSP",map);
	}
	
	@Override
	public int updateProduct(SellerProductVO productVO) {
		return this.sqlSession.update("SellerProduct.updateSP", productVO);
	}
	
	@Override
	public void deleteProduct(int idx) {
		this.sqlSession.delete("SellerProduct.deleteSP",idx);
	}
	@Override
	public List<SellerProductVO> list(SellerProductVO productVO) {
		return this.sqlSession.selectList("SellerProduct.searchSelect",productVO);//판매자상품검색List
	}
	@Override
	public void getSearchTotalCount(Map map) {
		this.sqlSession.selectOne("SellerProduct.searchTotalCountSP",map);
	}
	@Override
	public void selectSearch(Map map) {
		this.sqlSession.selectList("SellerProduct.searchSelectList",map);//판매자상품검색된 list 받아오기
	}

	


}
