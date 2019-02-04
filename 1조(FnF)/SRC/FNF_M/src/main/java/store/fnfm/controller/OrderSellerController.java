package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import store.fnfm.service.OrderSellerService;
import store.fnfm.vo.MessageVO;
import store.fnfm.vo.OrdersVO;
import store.fnfm.vo.SellerProductVO;

//seller전용 Orders

@Controller
public class OrderSellerController {
	@Autowired
	OrderSellerService ordersSellerSerivce;
	
	/** 페이지 이동 **/

	@RequestMapping(value = "/sellerOL", method = RequestMethod.GET)
	public String sellerOL() {
		return "ordersList";//views-->.jsp
	}
	
	//selectAll
		@RequestMapping(value = "/sellerOL/{page}", method = RequestMethod.POST)
		@ResponseBody		//나갈 때 object --> json
		public Map list(@PathVariable int page ,HttpServletRequest request) {
			/**-----------------------------------------------------------------------------**/
			HttpSession Session = request.getSession();
			String sellerid = (String)Session.getAttribute("user_id");
										//sellerid의 세션 값을 String에 저장.
			/**-----------------------------------------------------------------------------**/
			Map<String,Object> countMap = new HashMap<String,Object>();
			countMap.put("sellerid", sellerid); //mapper의 property값에 대입
			this.ordersSellerSerivce.getTotalCount(countMap);
			int totalCount = (Integer)countMap.get("result");
			int pageSize = 10;
			int totalPage = (totalCount%pageSize == 0) ? totalCount/pageSize : totalCount/pageSize +1; //전체페이지
			if(totalPage < page) page = totalPage;
			
			int pageCount = 10; //한 페이지에 뿌릴 수 있는 갯수는 10개씩
			
			int start = (page-1) * pageCount +1;//시작페이지가 1일 때 ex)1
			int end = start + pageCount -1;//끝페이지							ex)10
			
			int startPage = ((page - 1) * pageCount / pageCount) + 1;//2
			int endPage = startPage + pageCount - 1;//11
			if(endPage> totalPage) endPage = totalPage;
			
			Map<String,Object> map = new HashMap<String,Object>();//selectAllSP
			map.put("sellerid", sellerid);
			map.put("start", start);
			map.put("end", end);
			this.ordersSellerSerivce.selectAll(map);
			List<SellerProductVO> list = (List<SellerProductVO>)map.get("results");//maaper의 peoperty값
			Map<String,Object> data = new HashMap<String,Object>();
			data.put("code", Boolean.TRUE);
			data.put("startPage", startPage);
			data.put("endPage", endPage);
			data.put("totalPage", totalPage);
			data.put("pageSize", pageSize);
			data.put("page", page);
			data.put("totalCount", totalCount);//상품전체개수
			data.put("data", list);
			return data;
		}
		
		//selectOne-update-page      /fnf/sellerPU/3
		@RequestMapping(value="/sellerOD/{idx}",method=RequestMethod.GET)
		@ResponseBody					//나갈 때 object --> json
		public ModelAndView read_up(@PathVariable String idx) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("idx", idx);// mapper idx에 넣기
			this.ordersSellerSerivce.selectOne(map);
			List<SellerProductVO> list = (List<SellerProductVO>)map.get("result");
			ModelAndView mav = new ModelAndView();
			//mav.addObject("data",list.get(0));//받는.jsp --> ${data}
			mav.addObject("data",list);//받는.jsp --> ${data}
			mav.setViewName("ordersDetail");// views --> .jsp
			return mav;
		}
		
		//update
		@RequestMapping(value="/sellerOU/{idx}",method=RequestMethod.PUT)
		@ResponseBody
		public Map update(@PathVariable String idx, @RequestBody OrdersVO orders) {
			orders.setIdx(idx);
			String del_message = orders.getDel_message();
			String dm = del_message.replaceAll("<","&lt;");
				dm = dm.replaceAll(">","&gt;");
				dm = dm.replaceAll("'","''");
				dm = dm.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");//Enter
			orders.setDel_message(dm);
			this.ordersSellerSerivce.update(orders);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("code", Boolean.TRUE);
			return map;
		}
		
		//송장번호 중복확인
	 	@RequestMapping(value="/del_code_check", method=RequestMethod.POST)
	    @ResponseBody
	    public Map<Object, Object> pcodecheck(@RequestBody String del_code) {
	 		Map<Object, Object> map = new HashMap<Object, Object>();
	 		if(del_code.replaceAll(" ","").equals("") || del_code == "") {//pcode의 값이 없을 때
	        	map.put("cnt", -1);
	        	return map;
	        }else {
	        	del_code = del_code.replaceAll(" ","");//공백제거
		        int count = 0;
		        count = this.ordersSellerSerivce.delcodeCheck(del_code);
		        map.put("cnt", count);
		 
		        return map;
	        }
	    }
	 	
		//주문검색 selectAll
		@RequestMapping(value = "/sellerOL/dataSearch/{page}", method = RequestMethod.POST)
		@ResponseBody		//나갈 때 object --> json
		public Map SerachProduct(@PathVariable int page,
														 @RequestBody OrdersVO ordersVO,
														 HttpServletRequest request) {
			/**-----------------------------------------------------------------------------**/
			HttpSession Session = request.getSession();
			String user_id = (String)Session.getAttribute("user_id");
										//sellerid의 세션 값을 String에 저장.
			/**-----------------------------------------------------------------------------**/
			ordersVO.setSellerid(user_id);//productVO로 넘기려고
			
			Map<String,Object> countMap = new HashMap<String,Object>();
			countMap.put("sellerid", user_id); //mapper의 property값에 대입
			countMap.put("idx", ordersVO.getIdx());
			countMap.put("user_name", ordersVO.getUser_name());
			countMap.put("receiver_name", ordersVO.getReceiver_name());
			countMap.put("pname", ordersVO.getPname());
			countMap.put("status", ordersVO.getStatus());
			countMap.put("pay", ordersVO.getPay());
			this.ordersSellerSerivce.SearchTotalCount(countMap);//여기서 search-count값
			int totalCount = (Integer)countMap.get("result");//그 결과를 대입
			int pageSize = 10;
			int totalPage = (totalCount%pageSize == 0) ? totalCount/pageSize : totalCount/pageSize +1; //전체페이지
			if(totalPage < page) page = totalPage;
			int pageCount = 10; //한 페이지에 뿌릴 수 있는 갯수는 10개씩
			int start = (page-1) * pageCount +1;//시작페이지가 1일 때 ex)1
			int end = start + pageCount -1;//끝페이지							ex)10
			int startPage = ((page - 1) * pageCount / pageCount) + 1;//2
			int endPage = startPage + pageCount - 1;//11
			if(endPage> totalPage) endPage = totalPage;
			
			
			Map<String,Object> map = new HashMap<String,Object>();//selectAllSP
			map.put("sellerid", user_id); //mapper의 property값에 대입
			map.put("idx", ordersVO.getIdx());
			map.put("user_name", ordersVO.getUser_name());
			map.put("receiver_name", ordersVO.getReceiver_name());
			map.put("pname", ordersVO.getPname());
			map.put("status", ordersVO.getStatus());
			map.put("pay", ordersVO.getPay());
			map.put("start", start);
			map.put("end", end);
			
			this.ordersSellerSerivce.SearchAll(map);
			
			List<SellerProductVO> list = (List<SellerProductVO>)map.get("results");//maaper의 peoperty값
			Map<String,Object> data = new HashMap<String,Object>();
			data.put("code", Boolean.TRUE);
			data.put("startPage", startPage);
			data.put("endPage", endPage);
			data.put("totalPage", totalPage);
			data.put("pageSize", pageSize);
			data.put("page", page);
			data.put("totalCount", totalCount);//상품전체개수
			data.put("data", list);
			return data;
		}
		
		//배송URL 가져오기
		//@RequestBody String del_code @PathVariable String del_name
	 	@RequestMapping(value="/del_name", method=RequestMethod.POST)
	    @ResponseBody
	    public Map del_url(@RequestBody String del_name) {
		    Map<String,Object> map = new HashMap<String,Object>();
			map.put("del_name", del_name);// mapper idx에 넣기
			this.ordersSellerSerivce.getDel_url(map);
			List<SellerProductVO> list = (List<SellerProductVO>)map.get("result");
			ModelAndView mav = new ModelAndView();
			
			map.put("data",list);

		     return map;
        }
	 	
	 	//주문 상태값 변경하기
		@RequestMapping(value="/changeStatus/{idx}",method=RequestMethod.POST)
		@ResponseBody					//나갈 때 object --> json
		public Map statusChange(@PathVariable String idx) {
			int cnt = -1;
			cnt = this.ordersSellerSerivce.statusChange(idx);//입금대기 --> 결제완료
			Map<String,Object> data = new HashMap<String,Object>();
			data.put("data", cnt);//success에서 받는다.
			return data;
		}
		
		//주문 상태값 변경하기
				@RequestMapping(value="/baesongwanryo/{idx}",method=RequestMethod.POST)
				@ResponseBody					//나갈 때 object --> json
				public Map BaeSongWanRyo(@PathVariable String idx) {
					int cnt = -1;
					cnt = this.ordersSellerSerivce.baesongwanryo(idx);//입금대기 --> 결제완료
					Map<String,Object> data = new HashMap<String,Object>();
					data.put("data", cnt);//success에서 받는다.
					return data;
				}
	    
}
