package store.fnfm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminPathController {
	@RequestMapping(value = "/admin/cs", method = RequestMethod.GET)
	public String home() {
		
		return "adminNotice";
	}
	
	@RequestMapping(value = "/admin/qaa", method = RequestMethod.GET)
	public String qaa() {
		return "adminQaa";
	}
	
	@RequestMapping(value = "/admin/faq", method = RequestMethod.GET)
	public String fnq() {
		return "adminFaq";
	}
	
	@RequestMapping(value = "/admin/cs/noticewrite", method = RequestMethod.GET)
	public String home2() {
		
		return "adminNoticewrite";
	}	
	
	@RequestMapping(value = "/admin/qaa/qaawrite", method = RequestMethod.GET)
	public String qaawrite() {
		return "adminQaawrite";
	}

	@RequestMapping(value = "/admin/faq/faqwrite", method = RequestMethod.GET)
	public String faqwrite() {
		return "adminFaqwrite";
	}

}
