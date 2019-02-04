package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.FaqVO;

@Repository("faqDao")
public class FaqDaoImpl implements FaqDAO{
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void create(FaqVO faqVo) {
		this.sqlSession.insert("Faq.insertSP", faqVo);
	}

	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("Faq.selectAllSP", map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Faq.selectTotalCountSP", map);
	}

	@Override
	public void read(Map map) {
		this.sqlSession.selectOne("Faq.selectOneSP", map);
	}

	@Override
	public void update(FaqVO faqVo) {
		this.sqlSession.update("Faq.updateSP", faqVo);
	}

	@Override
	public void delete(int idx) {
		System.out.println(idx);
		this.sqlSession.delete("Faq.deleteSP", idx);
	}

	@Override
	public void readnumCount(int idx) {
		this.sqlSession.update("Faq.readnumCountU", idx);
	}

	@Override
	public void searchAll(Map map) {
		this.sqlSession.selectList("Faq.searchAll", map);
	}

	@Override
	public void searchCount(Map map) {
		this.sqlSession.selectOne("Faq.searchCount", map);
	}
	
}
