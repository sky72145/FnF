package store.fnfm.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import store.fnfm.mapper.LoginMapper;
import store.fnfm.vo.LoginVO;

@Service
public class FindServiceImpl implements FindService {

	@Resource
	private LoginMapper loginMapper;
	
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override //로그인 성공. 아이디찾기 성공.  아이디확인(비번 찾을때)
	public LoginVO selectUser(LoginVO loginVo) {
		return loginMapper.selectUser(loginVo);
	}
	
	@Override
	public int userSearch(LoginVO loginVo) {
		return loginMapper.userSearch(loginVo);
	}
	
	//아이디 찾기
	@Override
	public LoginVO searchId(LoginVO loginVo) {
		return loginMapper.searchId(loginVo);
	}

	@Override
	public LoginVO selectUser2(LoginVO loginVo) {
		System.out.println(loginVo);
		return loginMapper.selectUser2(loginVo.getUser_id());
	}
	
	//비밀번호 찾기 update
	@Override
	public void updatepw(LoginVO loginVo) {
		System.out.println("최종");
		System.out.println(loginVo);
		loginMapper.updatepw(loginVo);
	}

}
