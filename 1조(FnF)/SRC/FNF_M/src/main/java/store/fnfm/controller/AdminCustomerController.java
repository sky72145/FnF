package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import store.fnfm.service.UserService;
import store.fnfm.vo.ProductVO;
import store.fnfm.vo.UserVO;

@Controller
public class AdminCustomerController {
	@Autowired
	UserService userService;

	@RequestMapping(value = "/admin/seller/view", method = RequestMethod.GET)
	public String home32() {
		
		return "adminSellerView";
	}
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String home() {
		
		return "adminCustomer";
	}
	
	@RequestMapping(value = "/admin/user", method = RequestMethod.GET)
	public String home2() {
		
		return "adminCustomer";
	}
	
	@RequestMapping(value = "/admin/seller", method = RequestMethod.GET)
	public String home3() {
		
		return "adminSeller";
	}
	@RequestMapping(value = "/admin/product", method = RequestMethod.GET)
	public String home4() {
		
		return "adminProduct";
	}
	@RequestMapping(value = "/admin/board", method = RequestMethod.GET)
	public String home5() {
		
		return "adminBoard";
	}
	@RequestMapping(value = "/admin/recomm", method = RequestMethod.GET)
	public String home6() {
		
		return "adminRecommend";
	}
		
	
	@RequestMapping(value = "/admin/user/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map list(@PathVariable int page) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.userService.getTotalCount(countMap);
		int totalCount = (Integer)countMap.get("result");
		int pageSize = 10;
		int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount
				/ pageSize + 1;
		if(totalPage < page) page = totalPage;
		int pageCount = 10;
		
		int start = (page - 1) * pageCount + 1;
		int end = start + pageCount - 1 ;
		
		int startPage = ((page - 1) * pageCount / pageCount) + 1;
		int endPage = startPage + pageCount - 1 ; 
		
		if(endPage> totalPage) endPage = totalPage;
		
		Map<String, Object> results = new HashMap<String, Object>();
		results.put("start", start);
		results.put("end", end);
		
		this.userService.select(results);
		List<UserVO> list = (List<UserVO>)results.get("results");
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", Boolean.TRUE);
		map1.put("startPage", startPage);
		map1.put("endPage", endPage);
		map1.put("totalPage", totalPage);
		map1.put("pageSize", pageSize);
		map1.put("data", list);
		map1.put("totalCount", totalCount);
		map1.put("page", page);
		return map1;
	}
	
	@RequestMapping(value = "/admin/user/{user_id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map update(@PathVariable String user_id, @RequestBody UserVO user) {
		user.setUser_id(user_id);
		this.userService.updateBoard(user);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}

	
	@RequestMapping(value = "/admin/user/search/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map SearchUser(@PathVariable int page, @RequestBody UserVO user) {
		
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("user_id", user.getUser_id());
		countMap.put("user_name", user.getUser_name());
		countMap.put("email", user.getEmail());
		countMap.put("phone", user.getPhone());
		this.userService.getSearchTotalCount(countMap);
		int totalCount = (Integer)countMap.get("result");
		int pageSize = 10;
		int totalPage = (totalCount%pageSize == 0) ? totalCount/pageSize : totalCount/pageSize +1;
		if(totalPage < page) page = totalPage;
		int pageCount = 10;
		int start = (page-1) * pageCount +1;
		int end = start + pageCount -1;						
		int startPage = ((page - 1) * pageCount / pageCount) + 1;
		int endPage = startPage + pageCount - 1;
		if(endPage> totalPage) endPage = totalPage;
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id", user.getUser_id());
		map.put("user_name", user.getUser_name());
		map.put("email", user.getEmail());
		map.put("phone", user.getPhone());
		map.put("start", start);
		map.put("end", end);
		this.userService.search(map);
	
		List<UserVO> list = (List<UserVO>)map.get("results");
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("code", Boolean.TRUE);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("totalPage", totalPage);
		data.put("pageSize", pageSize);
		data.put("page", page);
		data.put("totalCount", totalCount);
		data.put("data", list);
		return data;
	}

	
	
}
