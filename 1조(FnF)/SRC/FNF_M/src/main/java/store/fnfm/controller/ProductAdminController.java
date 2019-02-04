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

import store.fnfm.service.ProductAdminService;
import store.fnfm.vo.ProductVO;

@Controller
public class ProductAdminController {
	@Autowired
	ProductAdminService productAdminService;

	@RequestMapping(value = "/admin/product/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map productList(@PathVariable int page) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.productAdminService.getTotalCount(countMap);
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
		
		this.productAdminService.select(results);
		List<ProductVO> list = (List<ProductVO>)results.get("results");
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

	
	@RequestMapping(value = "/admin/recomm/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map readRecomm(@PathVariable int page) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.productAdminService.getRecommTotalCount(countMap);
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
		
		this.productAdminService.selectRecomm(results);
		List<ProductVO> list = (List<ProductVO>)results.get("results");
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
	
	@RequestMapping(value = "/admin/recomm1", method = RequestMethod.GET)
	@ResponseBody
	public Map readRecomm1() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.productAdminService.selectRecomm1(map);
		List<ProductVO> list = (List<ProductVO>)map.get("results");
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("code", "success");
		map1.put("data", list);
		return map1;
	}
	
	@RequestMapping(value = "/admin/recomm/{pcode}", method = RequestMethod.PUT)
	@ResponseBody
	public Map updateRecomm(@PathVariable String pcode, @RequestBody ProductVO product) {
		product.setPcode(pcode);
		this.productAdminService.updateRecomm(product);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/recomm1/{pcode}", method = RequestMethod.PUT)
	@ResponseBody
	public Map updateRecomm1(@PathVariable String pcode, @RequestBody ProductVO product) {
		product.setPcode(pcode);
		this.productAdminService.updateRecomm1(product);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/product/{pcode}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable String pcode) {
		this.productAdminService.deleteProduct(pcode);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/admin/product/search/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map SearchProduct(@PathVariable int page, @RequestBody ProductVO product) {
		Map<String, Object> countMap = new HashMap<String, Object>();
		countMap.put("sellerid", product.getSellerid());
		countMap.put("pcode", product.getPcode());
		countMap.put("pname", product.getPname());
		countMap.put("origin", product.getOrigin());
		countMap.put("category", product.getCategory());
		countMap.put("category2", product.getCategory2());
		this.productAdminService.getSearchTotalCount(countMap);
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
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sellerid", product.getSellerid());
		map.put("pcode", product.getPcode());
		map.put("pname", product.getPname());
		map.put("origin", product.getOrigin());
		map.put("category", product.getCategory());
		map.put("category2", product.getCategory2());
		map.put("start", start);
		map.put("end",end);
		this.productAdminService.search(map);
		
		List<ProductVO> list = (List<ProductVO>)map.get("results");
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
