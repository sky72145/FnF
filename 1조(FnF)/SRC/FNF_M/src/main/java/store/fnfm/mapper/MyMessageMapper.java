package store.fnfm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;

import store.fnfm.vo.Criteria3;
import store.fnfm.vo.MyMessageVO;

public interface MyMessageMapper {
	public int myInsert(MyMessageVO vo);
	public MyMessageVO readmsg(int idx);
	public ResponseEntity<String> deletesed(int idx);
	public String deleterec(int idx);
	public int update(int idx);
	public List<MyMessageVO> getsendListWithPaging(
			@Param("cri3") Criteria3 cri3,
			@Param("send_id") String send_id);
	public List<MyMessageVO> getreceiveListWithPaging(
			@Param("cri3") Criteria3 cri3,
			@Param("receive_id") String receive_id);
}
