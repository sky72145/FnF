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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sun.istack.internal.logging.Logger;

import store.fnfm.service.FileUploadService;
import store.fnfm.service.QaaService;
import store.fnfm.vo.QaaVO;

@Controller
public class QaaController {
	private static Logger logger = Logger.getLogger(QaaController.class);
	@Autowired
	QaaService qaaService;
	
	@Autowired
	FileUploadService fileUploadService;

	//데이터입력
	@RequestMapping(value = "/qaa/qaawrite", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(MultipartHttpServletRequest request, HttpSession session, HttpServletRequest requ) {
		
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
		
		String password = request.getParameter("password");
	    qaaVo.setPassword(password);
	      
	    String status = request.getParameter("status");
	    qaaVo.setStatus(status); 
		
		Map<String, Object> result = new HashMap<String, Object>();
		this.qaaService.insertBoard(qaaVo);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	//리스트
	@RequestMapping(value = "/qaa/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map list(@PathVariable int page) {
		//System.out.println("here");
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
	@RequestMapping(value = "/qaa/{page}/{idx}", method = RequestMethod.GET)
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
		mav.setViewName("cs/qaaview");
		return mav;
	}
	
	//update띄우기
	@RequestMapping(value = "/qaa/update/{page}/{idx}", method = RequestMethod.GET)
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
		mav.setViewName("cs/qaaupdate");
		return mav;
	}
	   @RequestMapping(value = "/qaa/update/{idx}", method = RequestMethod.POST)
	   @ResponseBody
	   public Map update(MultipartHttpServletRequest request, @PathVariable int idx, HttpServletRequest requ) {
	      //System.out.println("here");
	      QaaVO qaaVo = new QaaVO();
	      qaaVo.setIdx(idx);
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
	      
	      String filename = request.getParameter("filename");
	      if(filename == null) {//사진없을때
		         //System.out.println("파일 이름은 널입니다.");
		         filename = "";
		      }
	      MultipartFile mFile = request.getFile("file1");
	      System.out.println(request.getFile("file1"));
	      logger.info("Original File Name : " + mFile.getOriginalFilename());
	      String uri = this.fileUploadService.restore(mFile, requ);
	      if(uri != null) {
	         qaaVo.setFilename(uri);
	      logger.info("uri = " + uri);
	      }else {
	         qaaVo.setFilename(filename);
	      }
	      
	      String password = request.getParameter("password");
		  qaaVo.setPassword(password);
		      
	      String status = request.getParameter("status");
	      qaaVo.setStatus(status);
	      System.out.println("Qaa Controller qaa : " + qaaVo);
	      
	      Map<String, Object> result = new HashMap<String, Object>();
	      this.qaaService.updateBoard(qaaVo);
	      result.put("code", Boolean.TRUE);
	      return result;
	   }
	
	//delete
	@RequestMapping(value = "/qaa/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable int idx) {
		this.qaaService.deleteBoard(idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	//Search List
	@RequestMapping(value = "/qaa/search/{page}", method = RequestMethod.POST)
	@ResponseBody
	public Map searchlist(@PathVariable int page, @RequestBody QaaVO qaaVo) {
		//System.out.println("search");
//		System.out.println("id = "+qaaVo.getUser_id());
//		System.out.println("title = "+qaaVo.getTitle());
//		System.out.println("contents = "+qaaVo.getContents());
//		return null;
		Map<String, Object> countMap = new HashMap<String, Object>();
		countMap.put("user_id", qaaVo.getUser_id());
		countMap.put("title", qaaVo.getTitle());
		countMap.put("contents", qaaVo.getContents());
		
		this.qaaService.searchCount(countMap);
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
		results.put("user_id", qaaVo.getUser_id());
		results.put("title", qaaVo.getTitle());
		results.put("contents", qaaVo.getContents());
		results.put("password", qaaVo.getPassword());
		results.put("status", qaaVo.getStatus());
		results.put("start", start);
		results.put("end", end);
		
		this.qaaService.search(results);
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
}
