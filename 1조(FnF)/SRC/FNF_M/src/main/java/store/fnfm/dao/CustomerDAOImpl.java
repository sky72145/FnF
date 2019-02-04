package store.fnfm.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.CustomerVO;


@Repository("customerDao")
public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public void create(CustomerVO customerVo) {  
		System.out.println("dao vo = " + customerVo);
		this.sqlSession.insert("Customer.insertSU", customerVo);
	}

	@Override
	public void create1(CustomerVO customerVo) {
		this.sqlSession.insert("Customer.insert1", customerVo);
	}
	
	@Override
	public int idCheck(String user_id) throws Exception {
		int count = sqlSession.selectOne("Customer.idCheck", user_id);
		//System.out.println(count);
		return count;
	}
	
	@Override
	public int emailCheck(String email) throws Exception {
		int count = sqlSession.selectOne("Customer.emailCheck", email);
		return count;
	}

	@Override
	public void sellercreate(CustomerVO customerVo) {
		this.sqlSession.insert("Seller.seinsertSU", customerVo);
		
	}

	@Override
	public void sellercreate1(CustomerVO customerVo) {
		this.sqlSession.insert("Seller.seinsert2", customerVo);
		
	}

	@Override
	public int seidCheck(String user_id) throws Exception {
		int count = sqlSession.selectOne("Customer.idCheck", user_id);
		//System.out.println(count);
		return count;
	}

	@Override
	public CustomerVO naverLogin(String user_id) {
		CustomerVO customerVO = sqlSession.selectOne("Customer.naverLogin", user_id);
		return customerVO;
	}

	@Override
	public int kakaoCheck(String user_id) throws Exception {
		int count = sqlSession.selectOne("Customer.kakaoCheck", user_id);
		System.out.println("카카오 아이디 있는 지 확인 하는 구간 .........: " + count);
		return count;
	}

	@Override
	public CustomerVO kakaoLogin(String user_id) {
		return sqlSession.selectOne("Customer.kakaoLogin", user_id);
	}

	@Override
	public int loginCheck(String user_id) {
		int count = sqlSession.selectOne("Customer.loginCheck", user_id);
		System.out.println("DAO.....:" + count);
		return count;
	}

}
