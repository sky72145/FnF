package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.UserVO;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void readAll(Map map) {
		this.sqlSession.selectList("User.selectAllSP", map);
	}

	@Override
	public void update(UserVO user) {
		this.sqlSession.update("User.updateSP",user);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("User.selectTotalCountSP",map);
	}

	@Override
	public void search(Map map) {
		this.sqlSession.selectList("User.searchSP", map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.sqlSession.selectOne("User.searchTotalCountSP",map);
	}

	@Override
	public void mail(Map map) {
		this.sqlSession.selectOne("User.mailSP",map);
	}
}
