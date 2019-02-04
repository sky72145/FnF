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

import store.fnfm.service.FileUploadService;
import store.fnfm.service.QaaService;
import store.fnfm.vo.QaaVO;

@Controller
public class AdminQaaController {
	private static Logger logger = Logger.getLogger(AdminQaaController.class);
	@Autowired
	QaaService qaaService;
	
	@Autowired
	FileUploadService fileUploadService;
	
	/*@Resource(name = "uploadPath")
	private String uploadPath; */ //File upload 경로

	//데이터입력
	@RequestMapping(value = "/admin/qaa/qaawrite", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(MultipartHttpServletRequest request, HttpServletRequest requ) {
		
		QaaVO qaaVo = new QaaVO();
		qaaVo.setUser_id(request.getParameter("user_id"));
		System.out.println(request.getParameter("user_id"));
		
		String title = request.getParameter("title");
		System.out.println(request.getParameter("title"));
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		title = title.replace("'", "''");
		qaaVo.setTitle(title);
		
		String contents = request.getParameter("contents");
		System.out.println(request.getParameter("contents"));
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("'", "''");
		contents = contents.replace("\r\n", "<br />");
		qaaVo.setContents(contents);
		
		MultipartFile mFile = request.getFile("filename");
		System.out.println(request.getFile("filename"));
		logger.info("Original File Name : " + mFile.getOriginalFilename());
		String uri = this.fileUploadService.restore(mFile, requ);
		qaaVo.setFilename(uri);
		logger.info("uri = " + uri);
		
		String status = request.getParameter("status");
	    qaaVo.setStatus(status); 
	    
		Map<String, Object> result = new HashMap<String, Object>();
		this.qaaService.insertBoard(qaaVo);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	//리스트
	@RequestMapping(value = "/admin/qaa/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map list(@PathVariable int page) {
		System.out.println("here");
		Map<String, Object> countMap = new HashMap<String, Object>();
		this.qaaService.getTotalCount(countMap);
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
		this.qaaService.select(results);
		List<QaaVO> list = (List<QaaVO>) results.get("results");
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
	@RequestMapping(value = "/admin/qaa/{page}/{idx}", method = RequestMethod.GET)
	@ResponseBody 
	public ModelAndView read(@PathVariable int page, @PathVariable int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		this.qaaService.readnum(idx);
		this.qaaService.selectBoard(map);
		List<QaaVO> list = (List<QaaVO>)map.get("result");

		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list.get(0));
		mav.addObject("page", page);
		mav.setViewName("adminQaaview");
		return mav;
	}
	
	//update띄우기
	@RequestMapping(value = "/admin/qaa/update/{page}/{idx}", method = RequestMethod.GET)
	@ResponseBody 
	public ModelAndView updateread(@PathVariable int page, @PathVariable int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		this.qaaService.selectBoard(map);
		List<QaaVO> list = (List<QaaVO>)map.get("result");
		QaaVO qaaVo = list.get(0);
		String title = qaaVo.getTitle();
		title = title.replace("&lt;", "<");
		title = title.replace("&gt;", ">");
		title = title.replace("''", "'");
		qaaVo.setTitle(title);
		
		String contents = qaaVo.getContents();
		contents = contents.replace("&lt;", "<");
		contents = contents.replace("&gt;", ">");
		contents = contents.replace("''", "'");
		contents = contents.replace("<br />", "\r\n");
		qaaVo.setContents(contents);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("data", list.get(0));
		mav.addObject("page", page);
		mav.setViewName("adminQaaupdate");
		return mav;
	}
	//@RequestParam("file1") String filename
	@RequestMapping(value = "/admin/qaa/update/{idx}", method = RequestMethod.POST)
	@ResponseBody
	public Map update(MultipartHttpServletRequest request, @PathVariable int idx, HttpServletRequest requ) {
		//System.out.println("here");
		QaaVO qaaVo = new QaaVO();
		qaaVo.setIdx(idx);
		qaaVo.setFilename(request.getParameter("file1"));//hidden 파일 이미지 이름 저장
		qaaVo.setUser_id(request.getParameter("user_id"));
		System.out.println(request.getParameter("user_id"));
		
		String title = request.getParameter("title");
		System.out.println(request.getParameter("title"));
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		title = title.replace("'", "''");
		qaaVo.setTitle(title);
		
		String contents = request.getParameter("contents");
		System.out.println(request.getParameter("contents"));
		contents = contents.replace("<", "&lt;");
		contents = contents.replace(">", "&gt;");
		contents = contents.replace("'", "''");
		contents = contents.replace("\r\n", "<br />");
		qaaVo.setContents(contents);
		
		String filename = qaaVo.getFilename();
		MultipartFile mFile = request.getFile("filename");
		System.out.println(request.getFile("filename"));
		logger.info("Original File Name : " + mFile.getOriginalFilename());
		String uri = this.fileUploadService.restore(mFile, requ);
		if(uri != null) {
			qaaVo.setFilename(uri);
		logger.info("uri = " + uri);
		}else {
			qaaVo.setFilename(filename);
		}
		
		String status = request.getParameter("status");
	      qaaVo.setStatus(status);
	      System.out.println("Qaa Controller qaa : " + qaaVo);
		
		Map<String, Object> result = new HashMap<String, Object>();
		this.qaaService.updateBoard(qaaVo);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	//delete
	@RequestMapping(value = "/admin/qaa/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable int idx) {
		this.qaaService.deleteBoard(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
}
