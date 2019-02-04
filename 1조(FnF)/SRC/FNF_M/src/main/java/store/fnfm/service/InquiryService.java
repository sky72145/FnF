package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.InquiryVO;

public interface InquiryService {
	List<InquiryVO> list(String pcode);
	void create(InquiryVO inquiryVO);
	void update(InquiryVO inquiryVO);
	void delete(int idx);
}
