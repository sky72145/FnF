package store.fnfm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.ProductVO;

@Repository("mainProductDao")
public class MainProductDAOImpl implements MainProductDAO {

	@Inject
	SqlSession sqlSession;

	@Override
	public List<ProductVO> nList() {
		return sqlSession.selectList("product.nList");
	}

	@Override
	public List<ProductVO> sList() {
		return sqlSession.selectList("product.sList");
	}

	@Override
	public List<ProductVO> gList() {
		return sqlSession.selectList("product.gList");
	}

	@Override
	public List<ProductVO> mdList() {
		return sqlSession.selectList("product.mdList");
	}

	@Override
	public List<ProductVO> hList() {
		return sqlSession.selectList("product.hList");
	}

}
