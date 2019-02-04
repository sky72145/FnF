package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.mapper.MembersMapper;
import store.fnfm.vo.MembersVO;
import store.fnfm.vo.MileVO;


@Service
public class MembersServiceImpl implements MembersService {
	@Autowired
	private MembersMapper mapper;
	
	
	
	@Override
	public boolean modifys(MembersVO member) {
		return mapper.update(member)==1;
	}

	@Override
	public boolean remove(MembersVO member) {
		return mapper.delete(member)==1;
	}
	@Override
	public MembersVO get(String user_id) {
		return mapper.read(user_id);
	}
	@Override
	public List<MembersVO> getList(){
		return mapper.getList();
	}
	@Override
	public MileVO mile(String user_id) {
		return mapper.mile(user_id);
	}
}
