package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.SellerVO;

@Repository("sellerDao")
public class SellerDaoImpl implements SellerDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("Seller.selectAllSP", map);
	}

	@Override
	public void update(SellerVO seller) {
		this.sqlSession.update("Seller.updateSP",seller);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Seller.selectTotalCountSP",map);
	}

	@Override
	public void readAllNew(Map map) {
		this.sqlSession.selectList("Seller.selectNewSP",map);
	}

	@Override
	public void approve(SellerVO seller) {
		this.sqlSession.update("Seller.approveSP",seller);
	}

	@Override
	public void read(Map map) {
		this.sqlSession.selectOne("Seller.selectOneSP",map);
	}

	@Override
	public void search(Map map) {
		this.sqlSession.selectList("Seller.searchSP", map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.sqlSession.selectOne("Seller.searchTotalCountSP",map);
	}

	@Override
	public void mail(Map map) {
		this.sqlSession.selectOne("Seller.mailSP",map);
	}

}
