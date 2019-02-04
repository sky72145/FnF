package store.fnfm.dao;

import java.util.List;

import store.fnfm.vo.QaaReplyVO;

public interface QaaReplyDao {
	List<QaaReplyVO> list(int parent);
	void create(QaaReplyVO qaaReplyVo);
	void update(QaaReplyVO qaaReplyVo);
	void delete(int idx);
	int updateStatus(int parent);
}
