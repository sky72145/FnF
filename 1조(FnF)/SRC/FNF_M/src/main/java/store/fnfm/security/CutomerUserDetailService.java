 package store.fnfm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import store.fnfm.mapper.LoginMapper;
import store.fnfm.vo.LoginVO;

public class CutomerUserDetailService implements UserDetailsService{

	@Autowired
	private LoginMapper loginMapper;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		System.out.println("Load User By userName : " + userName);
		
		//userName ==user_id
		
		LoginVO vo = null;
		
		try {
			vo = loginMapper.read(userName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		System.out.println("querified by login mapper : " + vo);
		return vo == null ? null : new LoginUser(vo);
	}
	
	
}
