package store.fnfm.service;

import java.util.List;

import store.fnfm.vo.MyOrderVO;

public interface OrdersService {
	public List<MyOrderVO> selectList(String user_id) ;
	public boolean modifyorder(MyOrderVO myorder);
}
