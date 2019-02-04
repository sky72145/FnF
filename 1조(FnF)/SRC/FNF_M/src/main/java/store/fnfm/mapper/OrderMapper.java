package store.fnfm.mapper;

import java.util.List;

import store.fnfm.vo.MyOrderVO;

public interface OrderMapper {
	
	public List<MyOrderVO> selectList(String user_id);
	
	public int updateorder(MyOrderVO myorder);
}
