package store.fnfm.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.MainProductService;
import store.fnfm.service.SearchAllService;
import store.fnfm.vo.ProductVO;

@Controller
public class HomeController {

	@Autowired
	MainProductService mainProductService;

	@Autowired
	SearchAllService searchAllService;
	 

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	   public ModelAndView main(ModelAndView mav, HttpServletRequest request) {
	      HttpSession session = request.getSession();
	      
	      Enumeration<String> enumm = session.getAttributeNames();
	      
	      while (enumm.hasMoreElements()) {
	         String key = enumm.nextElement();
	         
	         System.out.println(key + " : " + session.getAttribute(key));
	      }
	      
	      mav.addObject("nlist", mainProductService.nList());
	      mav.addObject("slist", mainProductService.sList());
	      mav.addObject("glist", mainProductService.gList());
	      mav.addObject("mdlist", mainProductService.mdList());
	      mav.addObject("hlist", mainProductService.hList());
	      mav.setViewName("index");
	      return mav;
	   }


	@RequestMapping(value = "searchAll", method = RequestMethod.GET)
	public ModelAndView searchAll(@RequestParam("keyword") String keyword) throws Exception{
		List<ProductVO> list = searchAllService.searchAll(keyword);
		int count = searchAllService.searchAllCount(keyword);
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("keyword", keyword);
		mav.addObject("map", map);
		/*mav.addObject("searchAll", searchAllService.searchAll(keyword));
		mav.addObject("searchAllCount", searchAllService.searchAllCount(keyword));*/
		mav.setViewName("searchAll");
		return mav;
	}

}
