package store.fnfm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.InquiryVO;

@Repository("inquiryDAO")
public class InquiryDAOImpl implements InquiryDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<InquiryVO> list(String pcode) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("pcode", pcode);//property에 대입
		this.sqlSession.selectList("Inquiry.select", map);//mapper가 hashMap으로 받으니
		List<InquiryVO> list = (List<InquiryVO>)map.get("results");//property="results"
		return list;
	}

	@Override
	public void create(InquiryVO inquiryVO) {
		this.sqlSession.insert("Inquiry.insert",inquiryVO);
	}

	@Override
	public void update(InquiryVO inquiryVO) {

	}

	@Override
	public void delete(int idx) {
		this.sqlSession.delete("Inquiry.delete",idx);
	}

}
