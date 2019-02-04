package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.FaqVO;
import store.fnfm.vo.NoticeVO;
import store.fnfm.vo.QaaVO;


public interface NoticeDAO {
	void create(NoticeVO noticeVo);
	void readAll(Map map);
	void getTotalCount(Map map);
	void read(Map map);
	void update(NoticeVO noticeVo);
	void delete(int idx);
	void readnumCount(int idx);
	void searchAll(Map map);
	void searchCount(Map map);
}
