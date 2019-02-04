package store.fnfm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import store.fnfm.dao.CustomerDAO;
import store.fnfm.vo.CustomerVO;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService {
	@Autowired
	CustomerDAO customerDao;
	
	@Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Override
	public void insertCustomer(CustomerVO customerVo) {
		System.out.println("service vo = " + customerVo);
		customerVo.setPassword(this.bcryptPasswordEncoder.encode(customerVo.getPassword()));
		this.customerDao.create(customerVo);
	}
	
	@Override
	public void insertCustomer1(CustomerVO customerVo) {
		this.customerDao.create1(customerVo);
	}

	@Override
	public int idCheck(String user_id) throws Exception {
		return customerDao.idCheck(user_id);
	}
	

	@Override
	public int emailCheck(String email) throws Exception {
		return customerDao.emailCheck(email);
	}

	@Override
	public void insertSeller(CustomerVO customerVo) {
		System.out.println(customerVo);
		customerVo.setPassword(this.bcryptPasswordEncoder.encode(customerVo.getPassword()));
		this.customerDao.sellercreate(customerVo);
	}

	@Override
	public void insertSeller1(CustomerVO customerVo) {
		this.customerDao.sellercreate1(customerVo);
	}

	@Override
	public int seidCheck(String user_id) throws Exception {
		return customerDao.idCheck(user_id);
	}

	@Override
	public CustomerVO naverLogin(CustomerVO customerVo) {
		if(customerVo != null){
			String email = customerVo.getEmail();
			return (CustomerVO)customerDao.naverLogin(email);
		}
		return null;
	}

	@Override
	public int kakaoIdCheck(String user_id) throws Exception {
		System.out.println("여기는 서비스입니다::::::::::" + user_id);
		return customerDao.kakaoCheck(user_id);
	}

	@Override
	public CustomerVO kakaoLogin(String user_id) {
		return customerDao.kakaoLogin(user_id);
	}

	@Override
	public int loginCheck(String user_id) throws Exception {
		System.out.println("Service.......: " + user_id);
		return customerDao.loginCheck(user_id);
	}
}
