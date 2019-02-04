package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.InquiryDAO;
import store.fnfm.vo.InquiryVO;

@Service("inquiryService")
public class InquiryServiceImpl implements InquiryService {
	@Autowired
	InquiryDAO inquiryDAO;
	
	@Override
	public List<InquiryVO> list(String pcode) {
		return this.inquiryDAO.list(pcode);
	}

	@Override
	public void create(InquiryVO inquiryVO) {
		this.inquiryDAO.create(inquiryVO);
	}

	@Override
	public void update(InquiryVO inquiryVO) {

	}

	@Override
	public void delete(int idx) {
		this.inquiryDAO.delete(idx);
	}

}
