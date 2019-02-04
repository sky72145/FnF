package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.SellerChartService;
import store.fnfm.vo.SellerProductVO;

@Controller
public class SellerChartController {
	@Autowired
	SellerChartService sellerChartService;

//	//page이동
//	@GetMapping("/sellerMain")
//	public void sellerMain() {
//		
//	}
	
	//SellerChart
	@RequestMapping(value="/sellerMain",method=RequestMethod.GET)
	@ResponseBody					//나갈 때 object --> json
	public ModelAndView SellerChart(HttpServletRequest request) {
		/**-----------------------------------------------------------------------------**/
		HttpSession Session = request.getSession();
//		String user_id="minho"; //합치면 주석 처리
//		Session.setAttribute("user_id", user_id);//합치면 주석 처리
		String sellerid = (String)Session.getAttribute("user_id");
									//sellerid의 세션 값을 String에 저장.
		/**-----------------------------------------------------------------------------**/
		
		Map<String,Object> mcountMap = new HashMap<String,Object>();//무통장 결제 건 수
		String mu = "무통장";
		mcountMap.put("sellerid", sellerid);
		mcountMap.put("pay", mu); //mapper의 property값에 대입
		this.sellerChartService.MCount(mcountMap);
		int MCount = (Integer)mcountMap.get("result");
		
		Map<String,Object> kcountMap = new HashMap<String,Object>();//카카오페이 결제 건 수
		String ka = "카카오페이";
		kcountMap.put("sellerid", sellerid);
		kcountMap.put("pay", ka); //mapper의 property값에 대입
		this.sellerChartService.MCount(kcountMap);
		int KCount = (Integer)kcountMap.get("result");
		
		Map<String,Object> Pricemap = new HashMap<String,Object>();//상품별 판매액
		Pricemap.put("sellerid", sellerid);// mapper idx에 넣기
		this.sellerChartService.productPrice(Pricemap);
		List<SellerProductVO> Plist = (List<SellerProductVO>)Pricemap.get("result");
		
		Map<String,Object> MonthPmap = new HashMap<String,Object>();//상품별 판매수
		MonthPmap.put("sellerid", sellerid);// mapper idx에 넣기
		this.sellerChartService.MonthSales(MonthPmap);
		List<SellerProductVO> MSlist = (List<SellerProductVO>)MonthPmap.get("result");
		
		Map<String,Object> map = new HashMap<String,Object>();//상품별 판매수
		map.put("sellerid", sellerid);// mapper idx에 넣기
		this.sellerChartService.productChart(map);
		List<SellerProductVO> list = (List<SellerProductVO>)map.get("result");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("mcount", MCount);//${mcount}
		mav.addObject("kcount", KCount);//${kcount}
		mav.addObject("month", MSlist);//${month}
		mav.addObject("pdata", Plist);//받는.jsp --> ${pdata}
		mav.addObject("data", list);//받는.jsp --> ${data}
		mav.setViewName("sellerMain");// views --> .jsp
		return mav;
	}
}
