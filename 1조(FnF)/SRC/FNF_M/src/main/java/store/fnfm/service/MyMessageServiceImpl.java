package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import store.fnfm.mapper.MyMessageMapper;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.MyMessageVO;

@Service
public class MyMessageServiceImpl implements MyMessageService {
	@Autowired
	private MyMessageMapper mapper;
	
	@Override
	public int register(MyMessageVO vo) {
		return mapper.myInsert(vo);
	}

	@Override
	public MyMessageVO getsed(int idx) {
		return mapper.readmsg(idx);
	}
	@Override
	public MyMessageVO getrec(int idx) {
		return mapper.readmsg(idx);
	}


	@Override
	public int mymodifymsg(int idx) {
		return mapper.update(idx);
	}

	@Override
	public List<MyMessageVO> getListsed(Criteria3 cri3, String send_id) {
		return mapper.getsendListWithPaging(cri3,send_id);
	}

	@Override
	public List<MyMessageVO> getListrec(Criteria3 cri3, String receive_id) {
		return mapper.getreceiveListWithPaging(cri3,receive_id);
	}

}
