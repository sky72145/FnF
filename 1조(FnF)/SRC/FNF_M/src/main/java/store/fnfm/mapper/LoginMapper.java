package store.fnfm.mapper;

import org.springframework.stereotype.Repository;

import store.fnfm.vo.LoginVO;

@Repository
public interface LoginMapper {
	public LoginVO read(String user_id);
	LoginVO selectUser(LoginVO loginVo);
	LoginVO selectUser2(String user_id); // 비밀번호 찾기 때 입력한 정보와 db 정보가 일치하는 지 롹인
	int userSearch(LoginVO loginVo);
	LoginVO searchId(LoginVO loginVo);
	LoginVO searchPw(LoginVO loginVo);
	void updatepw(LoginVO loginVo); //비밀번호 찾기 update
}
