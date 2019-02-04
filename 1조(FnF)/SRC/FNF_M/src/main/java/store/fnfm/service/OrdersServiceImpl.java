package store.fnfm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import store.fnfm.mapper.OrderMapper;
import store.fnfm.vo.MyOrderVO;


@Service
public class OrdersServiceImpl implements OrdersService {
	@Autowired
	private OrderMapper mapper;
	
	@Override
	public List<MyOrderVO> selectList(String user_id){
		
		return mapper.selectList(user_id);
	}
	@Override
	public boolean modifyorder(MyOrderVO myorder) {
	
		return mapper.updateorder(myorder)==1;
	}

}
