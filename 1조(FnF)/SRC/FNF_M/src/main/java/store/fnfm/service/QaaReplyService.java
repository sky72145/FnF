package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.QaaReplyVO;

public interface QaaReplyService {
	List<QaaReplyVO> selectReply(int parent);
	void insertReply(QaaReplyVO qaaReplyVo);
	void updateReply(QaaReplyVO qaaReplyVo);
	void deleteReply(int idx);
	int updateStatus(int parent);
}
