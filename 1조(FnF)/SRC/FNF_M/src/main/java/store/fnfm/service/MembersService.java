package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.MembersVO;
import store.fnfm.vo.MileVO;

public interface MembersService {
	public boolean modifys(MembersVO member);
	public boolean remove(MembersVO member);
	public MembersVO get(String user_id);
	public List<MembersVO> getList();
	public MileVO mile(String user_id);
}
