package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.FaqVO;
import store.fnfm.vo.NoticeVO;

public interface NoticeService {
	void insertBoard(NoticeVO noticeVo);
	void select(Map map);
	void getTotalCount(Map map);
	void selectBoard(Map map);
	void updateBoard(NoticeVO noticeVo);
	void deleteBoard(int idx);
	void readnum(int idx);
	void search(Map map);
	void searchCount(Map map);
}
