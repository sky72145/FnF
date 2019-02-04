package store.fnfm.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import store.fnfm.vo.MessageVO;

@Repository("messageDAO")
public class MessageDAOImpl implements MessageDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insertMSG(MessageVO msgVO) {
		this.sqlSession.insert("Message.msgInsert",msgVO);
	}

	@Override
	public void selectMSG(Map map) {//메시지 한개 읽기
		this.sqlSession.selectOne("Message.msgSelectOne",map);
	}

	@Override
	public void selectS(Map map) {//보낸메시지 List       send_id
		this.sqlSession.selectList("Message.msgSelectAll",map);
	}

	@Override
	public void selectR(Map map) {//받은메시지 List
		this.sqlSession.selectList("Message.RmsgSelectAll",map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.sqlSession.selectOne("Message.msgGetTotalCount", map);
	}

	@Override
	public void deleteMSG(int idx) {
		this.sqlSession.update("Message.SendMsgDelete",idx);
	}

	@Override
	public void SmsgSelectSearch(Map map) {//보낸 메시지 검색 select
		this.sqlSession.selectList("Message.SmsgSerachSelectList",map);
	}

	@Override
	public void SMSGgetSearchTotalCount(Map map) {
		this.sqlSession.selectOne("Message.SmsgSerachTotalCount",map);
	}

	@Override
	public void RmsgSelectSearch(Map map) {//받은 메시지 검색 select
		this.sqlSession.selectList("Message.RmsgSerachSelectList",map);
	}

	@Override
	public void RMSGgetSearchTotalCount(Map map) {
		this.sqlSession.selectOne("Message.RmsgSerachTotalCount",map);
	}

	@Override
	public void RgetTotalCount(Map map) {
		this.sqlSession.selectOne("Message.RmsgGetTotalCount", map);
	}

	@Override
	public void deleteRMSG(int idx) {
		this.sqlSession.update("Message.ReceiveMsgDelete",idx);
	}

	@Override
	public void readRMSG(int idx) {
		this.sqlSession.update("Message.readRmsgUpdate",idx);
	}

	@Override
	public void selectSeller(Map map) {
		this.sqlSession.selectOne("SellerProduct.MSGselectSellerID",map);
	}

	@Override
	public int useridCheck(String user_id) {
		return this.sqlSession.selectOne("Message.useridCheck",user_id);
	}

}
