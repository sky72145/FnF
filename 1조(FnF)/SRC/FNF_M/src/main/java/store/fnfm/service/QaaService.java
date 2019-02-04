package store.fnfm.service;

import java.util.Map;

import store.fnfm.vo.QaaVO;

public interface QaaService {
	void insertBoard(QaaVO qaaVo);
	void select(Map map);
	void getTotalCount(Map map);
	void selectBoard(Map map);
	void updateBoard(QaaVO qaaVo);
	void deleteBoard(int idx);
	void readnum(int idx);
	void search(Map map);
	void searchCount(Map map);
}
