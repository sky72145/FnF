package store.fnfm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.ProductVO;

@Repository("searchAllDao")
public class SearchAllDAOImpl implements SearchAllDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ProductVO> searchAll(String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		return sqlSession.selectList("search.searchAll", keyword);
	}

	@Override
	public int searchAllCount(String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		return sqlSession.selectOne("search.searchAllCount", keyword);
	}

}
