package store.fnfm.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.QaaVO;

@Repository("qaaDao")
public class QaaDAOImpl implements QaaDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void create(QaaVO qaaVo) {
		this.sqlSession.insert("Qaa.insertSP", qaaVo);
	}
	
	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("Qaa.selectAllSP", map);
	}
	
	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Qaa.selectTotalCountSP", map);
	}
	
	@Override
	public void read(Map map) {
		this.sqlSession.selectOne("Qaa.selectOneSP", map);
	}

	@Override
	public void update(QaaVO qaaVo) {
		System.out.println(qaaVo);
		this.sqlSession.update("Qaa.updateSP", qaaVo);
	}

	@Override
	public void delete(int idx) {
		this.sqlSession.delete("Qaa.deleteSP", idx);
	}

	@Override
	public void readnumCount(int idx) {
		this.sqlSession.update("Qaa.readnumCountU", idx);
	}

	@Override
	public void searchAll(Map map) {
		this.sqlSession.selectList("Qaa.searchAll", map);
	}

	@Override
	public void searchCount(Map map) {
		this.sqlSession.selectOne("Qaa.searchCount", map);
	}

}
