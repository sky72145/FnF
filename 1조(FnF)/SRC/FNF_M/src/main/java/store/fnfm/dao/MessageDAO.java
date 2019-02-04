package store.fnfm.dao;

import java.util.Map;

import store.fnfm.vo.MessageVO;

public interface MessageDAO {
	int useridCheck(String user_id);//user_id가 있는지
	void insertMSG(MessageVO msgVO);//보낼 때, 답장(update)
	void selectMSG(Map map);//메시지 읽을 때
	void selectSeller(Map map);//판매자 아이디 가져오기
	
	void selectS(Map map);//보낸 메시지 List
	void selectR(Map map);//받은 메시지 List
	
	void getTotalCount(Map map);//보낸메시지 페이징
	void RgetTotalCount(Map map);//받은메시지 페이징
	
	void deleteMSG(int idx);//보낸메시지 삭제 ==> 상태값 변경
	void deleteRMSG(int idx);//받은메시지 삭제 ==> 상태값 변경
	
	void SmsgSelectSearch(Map map);//보낸메시지 검색된 SMSGList
	void SMSGgetSearchTotalCount(Map map);//보낸메시지 검색결과페이징
	
	void RmsgSelectSearch(Map map);//받은메시지 검색된 RMSG List
	void RMSGgetSearchTotalCount(Map map);//받은메시지 검색결과페이징
	
	void readRMSG(int idx); //받은메시지 읽을 때
}
