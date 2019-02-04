package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.UserVO;

public interface UserDao {
	void readAll(Map map);
	void update(UserVO user);
	void getTotalCount(Map map);
	void search(Map map);
	void getSearchTotalCount(Map map);
	void mail(Map map);
}
