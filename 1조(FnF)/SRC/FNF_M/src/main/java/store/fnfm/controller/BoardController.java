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

import store.fnfm.service.BoardService;
import store.fnfm.vo.BoardVO;
import store.fnfm.vo.UserVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/admin/board/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map list(@PathVariable int page) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.boardService.getTotalCount(countMap);
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
		
		this.boardService.select(results);
		List<BoardVO> list = (List<BoardVO>)results.get("results");
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
	
	
	@RequestMapping(value = "/admin/faq2/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map deleteFaq(@PathVariable int idx) {
		this.boardService.deleteFaq(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/notice/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map deleteNotice(@PathVariable int idx) {
		this.boardService.deleteNotice(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/qaa2/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map deleteQaa(@PathVariable int idx) {
		this.boardService.deleteQaa(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	

	@RequestMapping(value = "/admin/board/search/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map SearchBoard(@PathVariable int page, @RequestBody BoardVO board) {
		
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("board", board.getBoard());
		countMap.put("user_id", board.getUser_id());
		countMap.put("title", board.getTitle());
		countMap.put("contents", board.getContents());
		this.boardService.getSearchTotalCount(countMap);
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
		map.put("board", board.getBoard());
		map.put("user_id", board.getUser_id());
		map.put("title", board.getTitle());
		map.put("contents", board.getContents());
		map.put("start", start);
		map.put("end", end);
		this.boardService.search(map);
	
		List<BoardVO> list = (List<BoardVO>)map.get("results");
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
