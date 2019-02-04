package store.fnfm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sun.istack.internal.logging.Logger;

import store.fnfm.service.FaqService;
import store.fnfm.service.FileUploadService;
import store.fnfm.vo.FaqVO;

@Controller
public class AdminFaqController {
	private static Logger logger = Logger.getLogger(AdminFaqController.class);
	@Autowired
	FaqService faqService;
	
	@Autowired
	FileUploadService fileUploadService;
	
	//데이터입력
	@RequestMapping(value = "/admin/faq/faqwrite", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(MultipartHttpServletRequest request, HttpServletRequest requ) {
		FaqVO faqVo = new FaqVO();
		faqVo.setUser_id(request.getParameter("user_id"));
		System.out.println(request.getParameter("user_id"));
		
		String title = request.getParameter("title");
		System.out.println(request.getParameter("title"));
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		title = title.replace("'", "''");
		faqVo.setTitle(title);
		
		String contents = request.getParameter("contents");
		System.out.println(request.getParameter("contents"));
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("'", "''");
		contents = contents.replace("\r\n", "<br />");
		faqVo.setContents(contents);
		
		MultipartFile mFile = request.getFile("filename");
		System.out.println(request.getFile("filename"));
		logger.info("Original File Name : " + mFile.getOriginalFilename());
		String uri = this.fileUploadService.restore(mFile, requ);
		faqVo.setFilename(uri);
		logger.info("uri = " + uri);
		
		Map<String, Object> result = new HashMap<String, Object>();
		this.faqService.insertBoard(faqVo);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	//리스트
		@RequestMapping(value = "/admin/faq/{page}", method = RequestMethod.POST)
		@ResponseBody
		public Map list(@PathVariable int page) {
			//System.out.println("here");
			Map<String, Object> countMap = new HashMap<String, Object>();
			this.faqService.getTotalCount(countMap);
			int totalCount = (Integer) countMap.get("result");
			int pageSize = 10;
			int totalPage = (totalCount % pageSize == 0) ? totalCount / pageSize : totalCount / pageSize + 1;
			if (totalPage < page)
				page = totalPage;
			int pageCount = 10; // 한 페이지에 뿌려줄 수 있는 갯수는 10개씩

			int start = (page - 1) * pageCount + 1; // 11
			int end = start + pageCount - 1; // 20

			int startPage = ((page - 1) * pageCount / pageCount) + 1; // 2
			int endPage = startPage + pageCount - 1; // 11

			if (endPage > totalPage)
				endPage = totalPage;

			Map<String, Object> results = new HashMap<String, Object>(); // 전체 레코드
			results.put("start", start);
			results.put("end", end);
			this.faqService.select(results);
			List<FaqVO> list = (List<FaqVO>) results.get("results");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", Boolean.TRUE);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("totalPage", totalPage);
			map.put("pageSize", pageSize);
			map.put("page", page);
			map.put("data", list);
			return map;
		}
		
		//하나만 읽기
		@RequestMapping(value = "/admin/faq/{page}/{idx}", method = RequestMethod.GET)
		@ResponseBody 
		public ModelAndView read(@PathVariable int page, @PathVariable int idx) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("idx", idx);
			this.faqService.readnum(idx);
			this.faqService.selectBoard(map);
			List<FaqVO> list = (List<FaqVO>)map.get("result");
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("data", list.get(0));
			mav.addObject("page", page);
			mav.setViewName("adminFaqview");
			return mav;
		}
		
		//update띄우기
		@RequestMapping(value = "/admin/faq/update/{page}/{idx}", method = RequestMethod.GET)
		@ResponseBody 
		public ModelAndView updateread(@PathVariable int page, @PathVariable int idx) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("idx", idx);
			this.faqService.selectBoard(map);
			List<FaqVO> list = (List<FaqVO>)map.get("result");
			FaqVO faqVo = list.get(0);
			String title = faqVo.getTitle();
			title = title.replace("&lt;", "<");
			title = title.replace("&gt;", ">");
			title = title.replace("''", "'");
			faqVo.setTitle(title);
			
			String contents = faqVo.getContents();
			contents = contents.replace("&lt;", "<");
			contents = contents.replace("&gt;", ">");
			contents = contents.replace("''", "'");
			contents = contents.replace("<br />", "\r\n");
			faqVo.setContents(contents);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("data", list.get(0));
			mav.addObject("page", page);
			mav.setViewName("adminFaqupdate");
			return mav;
		}
		
		@RequestMapping(value = "/admin/faq/update/{idx}", method = RequestMethod.POST)
		@ResponseBody
		public Map update(MultipartHttpServletRequest request, @PathVariable int idx, HttpServletRequest requ) {
			FaqVO faqVo = new FaqVO();
			faqVo.setIdx(idx);
			faqVo.setFilename(request.getParameter("file1"));//hidden 파일 이미지 이름 저장
			faqVo.setUser_id(request.getParameter("user_id"));
			System.out.println(request.getParameter("user_id"));
			
			String title = request.getParameter("title");
			System.out.println(request.getParameter("title"));
			title = title.replace("<", "&lt;");
			title = title.replace(">", "&gt;");
			title = title.replace("'", "''");
			faqVo.setTitle(title);
			
			String contents = request.getParameter("contents");
			System.out.println(request.getParameter("contents"));
			contents = contents.replace("<", "&lt;");
			contents = contents.replace(">", "&gt;");
			contents = contents.replace("'", "''");
			contents = contents.replace("\r\n", "<br />");
			faqVo.setContents(contents);
			
			String filename = faqVo.getFilename();
			MultipartFile mFile = request.getFile("filename");
			System.out.println(request.getFile("filename"));
			logger.info("Original File Name : " + mFile.getOriginalFilename());
			String uri = this.fileUploadService.restore(mFile, requ);
			if(uri != null) {
				faqVo.setFilename(uri);
			logger.info("uri = " + uri);
			}else {
				faqVo.setFilename(filename);
			}
			
			Map<String, Object> result = new HashMap<String, Object>();
			this.faqService.updateBoard(faqVo);
			result.put("code", Boolean.TRUE);
			return result;
		}
		
		//delete
		@RequestMapping(value = "/admin/faq/{idx}", method = RequestMethod.DELETE)
		@ResponseBody
		public Map delete(@PathVariable int idx) {
			this.faqService.deleteBoard(idx);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", Boolean.TRUE);
			return map;
		}
}
