package store.fnfm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import store.fnfm.vo.MembersVO;
import store.fnfm.vo.MileVO;

public interface MembersMapper {
	@Select("select * from customer ")
	public List<MembersVO> getList();
	
	public int delete(MembersVO member);
	
	public void insert(MembersVO member);
	
	public void insertSelectKey(MembersVO member);
	
	public int update(MembersVO member);
	
	public MembersVO read(String user_id);
	
	public MileVO mile(String user_id);
}
