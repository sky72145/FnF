package store.fnfm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.dao.MessageDAO;
import store.fnfm.vo.MessageVO;

@Service("messageService")
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDAO messageDAO;
	
	@Override
	public void insertMSG(MessageVO msgVO) {
		this.messageDAO.insertMSG(msgVO);
	}

	@Override
	public void selectMSG(Map map) {//메시지 한개 읽기
		this.messageDAO.selectMSG(map);
	}

	@Override
	public void selectS(Map map) {//보낸메시지 List       send_id
		this.messageDAO.selectS(map);
	}

	@Override
	public void selectR(Map map) {//받은메시지 List receive_id
		this.messageDAO.selectR(map);
	}

	@Override
	public void getTotalCount(Map map) {
		this.messageDAO.getTotalCount(map);
	}

	@Override
	public void deleteMSG(int idx) {
		this.messageDAO.deleteMSG(idx);
	}

	@Override
	public void SmsgSelectSearch(Map map) {//보낸 메시지 검색 select
		this.messageDAO.SmsgSelectSearch(map);
	}

	@Override
	public void SMSGgetSearchTotalCount(Map map) {
		this.messageDAO.SMSGgetSearchTotalCount(map);
	}

	@Override
	public void RmsgSelectSearch(Map map) {//받은 메시지 검색 select
		this.messageDAO.RmsgSelectSearch(map);
	}

	@Override
	public void RMSGgetSearchTotalCount(Map map) {
		this.messageDAO.RMSGgetSearchTotalCount(map);
	}

	@Override
	public void RgetTotalCount(Map map) {
		this.messageDAO.RgetTotalCount(map);
	}

	@Override
	public void deleteRMSG(int idx) {
		this.messageDAO.deleteRMSG(idx);
	}

	@Override
	public void readRMSG(int idx) {
		this.messageDAO.readRMSG(idx);
	}

	@Override
	public void selectSeller(Map map) {
		this.messageDAO.selectSeller(map);
	}

	@Override
	public int useridCheck(String user_id) {
		return this.messageDAO.useridCheck(user_id);
	}

}
