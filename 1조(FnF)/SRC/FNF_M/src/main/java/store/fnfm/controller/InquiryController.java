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

import store.fnfm.service.InquiryService;
import store.fnfm.vo.InquiryVO;

@Controller
public class InquiryController {
	@Autowired
	InquiryService inquiryService;
	
		//inquiry Insert						 /fnf/inquiry
		@RequestMapping(value="/inquiry",method=RequestMethod.POST)
		@ResponseBody
		public Map insert(@RequestBody InquiryVO inquiryVO , HttpServletRequest request) {//user_id, pcode, in_contents,
			/**-----------------------------------------------------------------------------**/
			HttpSession Session = request.getSession();
			String user_id = (String)Session.getAttribute("user_id");
										//user_id의 세션 값을 String에 저장.
			/**-----------------------------------------------------------------------------**/
			inquiryVO.setUser_id(user_id);
			Map<String,Object> map = new HashMap<String,Object>();
			this.inquiryService.create(inquiryVO);
			map.put("code", Boolean.TRUE);
			return map;
		}
		
		//inquiry All Select										
		@RequestMapping(value="/inquiry/all/{pcode}",method=RequestMethod.GET)
		@ResponseBody
		public Map list(@PathVariable String pcode) {
			Map<String,Object> map = new HashMap<String,Object>();
			List<InquiryVO> list = this.inquiryService.list(pcode);
			map.put("code", Boolean.TRUE);
			map.put("data", list);
			return map;
		}
		
		//inquiry Delete
		@RequestMapping(value="/inquiry/{idx}",method=RequestMethod.DELETE)
		@ResponseBody
		public Map delete(@PathVariable int idx) {
			Map<String,Object> map = new HashMap<String,Object>();
			this.inquiryService.delete(idx);
			map.put("code",Boolean.TRUE);
			return map;
		}
}
