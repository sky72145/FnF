package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
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

import store.fnfm.service.MessageService;
import store.fnfm.vo.MessageVO;

@Controller
public class MessageController {
	@Autowired
	MessageService messageService;
	
	
	/** 페이지 이동 **/
	@RequestMapping(value = "/message", method = RequestMethod.GET)
	public String message() {
		return "message";//views-->.jsp
	}
	@RequestMapping(value = "/sellerSMSG", method = RequestMethod.GET)
	public String sellerSMSG() {
		return "messageListSellerSend";//views-->.jsp
	}
	@RequestMapping(value = "/sellerRMSG", method = RequestMethod.GET)
	public String sellerRMSG() {
		return "messageListSellerReceive";//views-->.jsp
	}
	
	
	int cnt = 0;
	//MSG insert
	@RequestMapping(value="/sendMSG", method = RequestMethod.POST)
	@ResponseBody
	public Map msginsert(@RequestBody MessageVO msg, HttpServletRequest request) {
		cnt++;//1부터 시작
		/**-----------------------------------------------------------------------------**/
		HttpSession Session = request.getSession();
		String receive_id = msg.getReceive_id(); //받은 사람의 정보
		ServletContext application = Session.getServletContext(); //appScope를 사용하기위해
		application.setAttribute("receive_id"+cnt+"", receive_id);//그것을 appScope에 저장
		/**-----------------------------------------------------------------------------**/
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		//input type="text" 에 있는것들은 모두 처리 해줘야 함.
		String title = msg.getTitle();
		title = title.replaceAll("<","&lt;");
		title = title.replaceAll(">","&gt;");
		title = title.replaceAll("'","''");//db에서 오류남 ' 쓰면
		msg.setTitle(title);
		
		String contents = msg.getContents();
		contents = contents.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");//Enter
		contents = contents.replaceAll("<","&lt;");
		contents = contents.replaceAll(">","&gt;");
		contents = contents.replaceAll("'","''");
		msg.setContents(contents);
		
		this.messageService.insertMSG(msg);
		result.put("code", Boolean.TRUE); //성공
		return result;
	}
	
	//SMSG selectAll
	@RequestMapping(value = "/sellerSMSG/{page}", method = RequestMethod.POST)
	@ResponseBody		//나갈 때 object --> json
	public Map list(@PathVariable int page ,HttpServletRequest request) {
		/**-----------------------------------------------------------------------------**/
		HttpSession Session = request.getSession();
		String send_id = (String)Session.getAttribute("user_id");
									//send_id의 세션 값을 String에 저장.
		/**-----------------------------------------------------------------------------**/
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("send_id", send_id); //mapper의 property값에 대입
		this.messageService.getTotalCount(countMap);
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
		map.put("send_id", send_id);
		map.put("start", start);
		map.put("end", end);
		this.messageService.selectS(map);
		List<MessageVO> list = (List<MessageVO>)map.get("results");//maaper의 peoperty값
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("code", Boolean.TRUE);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("totalPage", totalPage);
		data.put("pageSize", pageSize);
		data.put("page", page);
		data.put("totalCount", totalCount);//메시지 전체 갯수
		data.put("data", list);
		return data;
	}
	//RMSG selectAll
	@RequestMapping(value = "/sellerRMSG/{page}", method = RequestMethod.POST)
	@ResponseBody		//나갈 때 object --> json
	public Map rlist(@PathVariable int page ,HttpServletRequest request) {
		/**-----------------------------------------------------------------------------**/
		HttpSession Session = request.getSession();
		String receive_id = (String)Session.getAttribute("user_id");
									//send_id의 세션 값을 String에 저장.
		/**-----------------------------------------------------------------------------**/
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("receive_id", receive_id); //mapper의 property값에 대입
		this.messageService.RgetTotalCount(countMap);
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
		map.put("receive_id", receive_id);
		map.put("start", start);
		map.put("end", end);
		this.messageService.selectR(map);
		List<MessageVO> list = (List<MessageVO>)map.get("results");//maaper의 peoperty값
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("code", Boolean.TRUE);
		data.put("startPage", startPage);
		data.put("endPage", endPage);
		data.put("totalPage", totalPage);
		data.put("pageSize", pageSize);
		data.put("page", page);
		data.put("totalCount", totalCount);//메시지 전체 갯수
		data.put("data", list);
		return data;
	}
	
	//selectOne-보낸메시지View 	
	@RequestMapping(value="/viewSMSG/{idx}",method=RequestMethod.POST)
	@ResponseBody					//나갈 때 object --> json
	public Map read(@PathVariable int idx) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("idx", idx);// mapper idx에 넣기
		this.messageService.selectMSG(map);
		List<MessageVO> list = (List<MessageVO>)map.get("result");
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("data",list.get(0));//받는.jsp --> ${data}
		return data;
	}
	//selectOne-받은메시지View 	
	@RequestMapping(value="/viewRMSG/{idx}",method=RequestMethod.POST)
	@ResponseBody					//나갈 때 object --> json
	public Map Rread(@PathVariable int idx) {
		this.messageService.readRMSG(idx);//읽지않음 --> 읽음 변경
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("idx", idx);// mapper idx에 넣기
		this.messageService.selectMSG(map);
		List<MessageVO> list = (List<MessageVO>)map.get("result");
		Map<String,Object> data = new HashMap<String,Object>();
		data.put("data",list.get(0));//받는.jsp --> ${data}
		return data;
	}
	//selectOne-답장메시지View 	
	@RequestMapping(value="/remessage/{idx}",method=RequestMethod.GET)
	@ResponseBody					//나갈 때 object --> json
	public ModelAndView remessage(@PathVariable int idx) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("idx", idx);// mapper idx에 넣기
		this.messageService.selectMSG(map);
		List<MessageVO> list = (List<MessageVO>)map.get("result");
		ModelAndView mav = new ModelAndView();
		mav.addObject("data",list.get(0));//받는.jsp --> ${data}
		mav.setViewName("message_re");// views --> .jsp
		return mav;
	}
	//selectOne-보내는메시지View
	@RequestMapping(value="/message/{idx}",method=RequestMethod.GET)
	@ResponseBody					//나갈 때 object --> json
	public ModelAndView messageD(@PathVariable int idx) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("idx", idx);// mapper idx에 넣기
		this.messageService.selectSeller(map);
		List<MessageVO> list = (List<MessageVO>)map.get("result");
		ModelAndView mav = new ModelAndView();
		mav.addObject("data",list.get(0));//받는.jsp --> ${data}
		mav.setViewName("messageD");// views --> .jsp
		return mav;
	}
	
	
	//delete이지만 상태를update하기에
	//보낸 메시지 삭제
	@RequestMapping(value="/viewSMSG/{idx}",method=RequestMethod.PUT)
	@ResponseBody
	public Map updateS(@PathVariable int idx) {
		this.messageService.deleteMSG(idx);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	//받은 메시지 삭제
	@RequestMapping(value="/viewRMSG/{idx}",method=RequestMethod.PUT)
	@ResponseBody
	public Map updateR(@PathVariable int idx) {
		this.messageService.deleteRMSG(idx);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	//보낸메시지검색 selectAll
	@RequestMapping(value = "/sellerSMSG/dataSearch/{page}", method = RequestMethod.POST)
	@ResponseBody		//나갈 때 object --> json
	public Map SerachMessage(@PathVariable int page,
													 @RequestBody MessageVO msg,
													 HttpServletRequest request)  {
		/**-----------------------------------------------------------------------------**/
		HttpSession Session = request.getSession();
		String send_id = (String)Session.getAttribute("user_id");
									//sellerid의 세션 값을 String에 저장.
		/**-----------------------------------------------------------------------------**/
		msg.setSend_id(send_id);//MessageVO로 넘기려고
		
		Map<String,Object> countMap = new HashMap<String,Object>();
		countMap.put("send_id", send_id); //mapper의 property값에 대입
		countMap.put("receive_id", msg.getReceive_id());
		countMap.put("title", msg.getTitle());
		countMap.put("writedate", msg.getWritedate());
		this.messageService.SMSGgetSearchTotalCount(countMap);//여기서 search-count값
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
		map.put("send_id", send_id); //mapper의 property값에 대입
		map.put("receive_id", msg.getReceive_id());
		map.put("title", msg.getTitle());
		map.put("writedate", msg.getWritedate());
		map.put("start", start);
		map.put("end", end);
		
		this.messageService.SmsgSelectSearch(map);//SMSGList검색
		
		List<MessageVO> list = (List<MessageVO>)map.get("results");//maaper의 peoperty값
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
	
	//받은 메시지검색 selectAll
		@RequestMapping(value = "/sellerRMSG/dataSearch/{page}", method = RequestMethod.POST)
		@ResponseBody		//나갈 때 object --> json
		public Map RSerachMessage(@PathVariable int page,
														 @RequestBody MessageVO msg,
														 HttpServletRequest request)  {
			/**-----------------------------------------------------------------------------**/
			HttpSession Session = request.getSession();
			String receive_id = (String)Session.getAttribute("user_id");
										//sellerid의 세션 값을 String에 저장.
			/**-----------------------------------------------------------------------------**/
			msg.setReceive_id(receive_id);//MessageVO로 넘기려고
			
			Map<String,Object> countMap = new HashMap<String,Object>();
			countMap.put("send_id", msg.getSend_id()); //mapper의 property값에 대입
			countMap.put("receive_id", receive_id);
			countMap.put("title", msg.getTitle());
			countMap.put("writedate", msg.getWritedate());
			this.messageService.RMSGgetSearchTotalCount(countMap);//여기서 search-count값
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
			map.put("send_id", msg.getSend_id()); //mapper의 property값에 대입
			map.put("receive_id", receive_id);
			map.put("title", msg.getTitle());
			map.put("writedate", msg.getWritedate());
			map.put("start", start);
			map.put("end", end);
			
			this.messageService.RmsgSelectSearch(map);//SMSGList검색
			
			List<MessageVO> list = (List<MessageVO>)map.get("results");//maaper의 peoperty값
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
		
		//user_id 확인
	 	@RequestMapping(value="/useridcheck", method=RequestMethod.POST)
	    @ResponseBody
	    public Map<Object, Object> pcodecheck(@RequestBody String user_id) {
	 		Map<Object, Object> map = new HashMap<Object, Object>();
	 		if(user_id.replaceAll(" ","").equals("") || user_id == "") {//pcode의 값이 없을 때
	        	map.put("cnt", -1);
	        	return map;
	        }else {
	        	user_id = user_id.replaceAll(" ","");//공백제거
		        int count = 0;
		        count = this.messageService.useridCheck(user_id);
		        map.put("cnt", count);
		 
		        return map;
	        }
	    }
}
