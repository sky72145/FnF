package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.ProductVO;

@Repository("productAdminDao")
public class ProductAdminDaoImpl implements ProductAdminDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("Product.selectAllSP",map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Product.selectTotalCountSP",map);
	}

	@Override
	public void readrecomm(Map map) {
		this.sqlSession.selectList("Product.selectRecommSP",map);
	}

	@Override
	public void readrecomm1(Map map) {
		this.sqlSession.selectList("Product.selectRecomm1SP",map);
	}

	@Override
	public void getRecommTotalCount(Map map) {
		this.sqlSession.selectOne("Product.selectRecommTotalCountSP",map);
	}

	@Override
	public void updaterecomm(ProductVO product) {
		this.sqlSession.update("Product.updateRecommSP",product);
	}

	@Override
	public void updaterecomm1(ProductVO product) {
		this.sqlSession.update("Product.updateRecomm1SP",product);
	}

	@Override
	public void delete(String pcode) {
		this.sqlSession.delete("Product.deleteSP",pcode);
		
	}

	@Override
	public void search(Map map) {
		this.sqlSession.selectList("Product.searchSP",map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.sqlSession.selectOne("Product.searchTotalCountSP",map);
	}

}
