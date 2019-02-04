package store.fnfm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.QaaReplyVO;

@Repository("qaaReplyDao")
public class QaaReplyDaoImpl implements QaaReplyDao {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<QaaReplyVO> list(int parent) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parent", parent);
		this.sqlSession.selectList("QaaReply.select",map);
		List<QaaReplyVO> list = (List<QaaReplyVO>)map.get("results");		
		return list;
	}

	@Override
	public void create(QaaReplyVO qaaReplyVo) {
		this.sqlSession.insert("QaaReply.insert",qaaReplyVo);
	}

	@Override
	public void update(QaaReplyVO qaaReplyVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", qaaReplyVo.getIdx());
		map.put("text", qaaReplyVo.getText());
		this.sqlSession.update("QaaReply.update", map);
	}

	@Override
	public void delete(int idx) {
		this.sqlSession.delete("QaaReply.delete",idx);
	}

	@Override
	public int updateStatus(int parent) {
		return this.sqlSession.update("QaaReply.updateStatus",parent);
	}

}
