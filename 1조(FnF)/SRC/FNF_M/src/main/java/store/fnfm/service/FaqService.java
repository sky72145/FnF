package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.FaqVO;
import store.fnfm.vo.QaaVO;

public interface FaqService {
	void insertBoard(FaqVO faqVo);
	void select(Map map);
	void getTotalCount(Map map);
	void selectBoard(Map map);
	void updateBoard(FaqVO faqVo);
	void deleteBoard(int idx);
	void readnum(int idx);
	void search(Map map);
	void searchCount(Map map);
}
