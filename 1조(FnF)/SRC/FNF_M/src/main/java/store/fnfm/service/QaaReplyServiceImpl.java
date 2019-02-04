package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.QaaReplyDao;
import store.fnfm.vo.QaaReplyVO;

@Service("qaaReplyService")
public class QaaReplyServiceImpl implements QaaReplyService {
	@Autowired
	QaaReplyDao qaaReplyDao;
	
	@Override
	public List<QaaReplyVO> selectReply(int parent) {
		return this.qaaReplyDao.list(parent);
	}

	@Override
	public void insertReply(QaaReplyVO qaaReplyVo) {
		this.qaaReplyDao.create(qaaReplyVo);
	}

	@Override
	public void updateReply(QaaReplyVO qaaReplyVo) {
		this.qaaReplyDao.update(qaaReplyVo);
	}

	@Override
	public void deleteReply(int idx) {
		this.qaaReplyDao.delete(idx);
	}

	@Override
	public int updateStatus(int parent) {
		return this.qaaReplyDao.updateStatus(parent);
	}

}
