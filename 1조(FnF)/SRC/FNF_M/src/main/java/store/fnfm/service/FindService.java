package store.fnfm.service;

import org.springframework.stereotype.Repository;

import store.fnfm.vo.LoginVO;

public interface FindService {
	LoginVO selectUser(LoginVO loginVo);
	LoginVO selectUser2(LoginVO loginVo);
	int userSearch(LoginVO loginVo);
	LoginVO searchId(LoginVO loginVo);
	void updatepw(LoginVO loginVo);
}
