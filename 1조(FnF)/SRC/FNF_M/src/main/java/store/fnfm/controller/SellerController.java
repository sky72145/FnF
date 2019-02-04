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
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.SellerService;
import store.fnfm.vo.SellerVO;
import store.fnfm.vo.UserVO;

@Controller
public class SellerController {
	@Autowired
	SellerService sellerService;
	
	@RequestMapping(value = "/admin/seller/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map list2(@PathVariable int page) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.sellerService.getTotalCount(countMap);
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
		
		this.sellerService.select(results);
		List<SellerVO> list = (List<SellerVO>)results.get("results");
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
	
	@RequestMapping(value = "/admin/seller/{user_id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map update2(@PathVariable String user_id, @RequestBody SellerVO seller) {
		seller.setUser_id(user_id);
		this.sellerService.updateBoard(seller);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/newseller", method = RequestMethod.GET)
	@ResponseBody
	public Map list() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sellerService.selectNew(map);
		List<SellerVO> list = (List<SellerVO>)map.get("results");
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", "success");
		map1.put("data", list);
		return map1;
	}
	
	
	@RequestMapping(value = "/admin/sellerappr/{user_id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map approve(@PathVariable String user_id, @RequestBody SellerVO seller) {
		seller.setUser_id(user_id);
		this.sellerService.approveSeller(seller);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/sellerrej/{user_id}", method = RequestMethod.PUT)
	@ResponseBody
	public Map reject(@PathVariable String user_id, @RequestBody SellerVO seller) {
		seller.setUser_id(user_id);
		this.sellerService.updateBoard(seller);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/seller/search/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map SearchUser(@PathVariable int page, @RequestBody SellerVO seller) {
		
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("user_id", seller.getUser_id());
		countMap.put("user_name", seller.getUser_name());
		countMap.put("email", seller.getEmail());
		countMap.put("phone", seller.getPhone());
		this.sellerService.getSearchTotalCount(countMap);
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
		map.put("user_id", seller.getUser_id());
		map.put("user_name", seller.getUser_name());
		map.put("email", seller.getEmail());
		map.put("phone", seller.getPhone());
		map.put("start", start);
		map.put("end", end);
		this.sellerService.search(map);
	
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
	
	
	@RequestMapping(value = "/admin/seller/{page}/{user_id}", method = RequestMethod.GET)
	@ResponseBody 
	public ModelAndView read(@PathVariable int page, @PathVariable String user_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		this.sellerService.selectSeller(map);
		List<SellerVO> list = (List<SellerVO>)map.get("result");
		SellerVO seller = list.get(0);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", seller);
		mav.addObject("page", page);
		mav.setViewName("adminSellerView");
		return mav;
	}	
}
