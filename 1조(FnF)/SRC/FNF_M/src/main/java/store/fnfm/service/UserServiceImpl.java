package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.UserDao;
import store.fnfm.vo.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	UserDao userDao;
	
	@Override
	public void select(Map map) {
		this.userDao.readAll(map);
	}

	@Override
	public void updateBoard(UserVO user) {
		this.userDao.update(user);
	}

	@Override
	public void getTotalCount(Map map) {
		this.userDao.getTotalCount(map);		
	}

	@Override
	public void search(Map map) {
		this.userDao.search(map);
	}

	@Override
	public void getSearchTotalCount(Map map) {
		this.userDao.getSearchTotalCount(map);
	}

	@Override
	public void mail(Map map) {
		this.userDao.mail(map);
	}

}
