package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("Board.selectAllSP",map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Board.selectTotalCountSP",map);
	}

	@Override
	public void deleteFaq(int idx) {
		this.sqlSession.delete("Board.deleteFaqSP",idx);
	}

	@Override
	public void deleteNotice(int idx) {
		this.sqlSession.delete("Board.deleteNoticeSP",idx);
	}

	@Override
	public void deleteQaa(int idx) {
		this.sqlSession.delete("Board.deleteQaaSP",idx);
	}

	@Override
	public void search(Map map) {
		this.sqlSession.selectList("Board.searchSP",map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.sqlSession.selectOne("Board.searchTotalCountSP",map);
	}


}
