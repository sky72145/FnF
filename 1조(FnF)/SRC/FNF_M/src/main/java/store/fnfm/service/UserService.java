package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.UserVO;

public interface UserService {
	void select(Map map);
	void updateBoard(UserVO user);
	void getTotalCount(Map map);
	void search(Map map);
	void getSearchTotalCount(Map map);
	void mail(Map map);
}
