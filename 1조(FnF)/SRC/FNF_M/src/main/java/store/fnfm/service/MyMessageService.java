package store.fnfm.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import store.fnfm.vo.Criteria3;
import store.fnfm.vo.MyMessageVO;

public interface MyMessageService {
 public int register(MyMessageVO vo);
 public MyMessageVO getsed(int idx);
 public MyMessageVO getrec(int idx);
 public int mymodifymsg(int idx);
 public List<MyMessageVO> getListsed(Criteria3 cri3, String send_id);
 public List<MyMessageVO> getListrec(Criteria3 cri3, String receive_id);
}
