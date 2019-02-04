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

import store.fnfm.service.QaaReplyService;
import store.fnfm.vo.QaaReplyVO;

@Controller
public class QaaReplyController {
	@Autowired
	QaaReplyService qaaReplyService;
	
	@RequestMapping(value="/qaa/reply", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(@RequestBody QaaReplyVO qaaReplyVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(qaaReplyVo.getParent());
		int ctn = this.qaaReplyService.updateStatus(qaaReplyVo.getParent());
		this.qaaReplyService.insertReply(qaaReplyVo);
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/qaa/reply/{parent}", method = RequestMethod.GET)
	@ResponseBody
	public Map list(@PathVariable int parent) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<QaaReplyVO> list = this.qaaReplyService.selectReply(parent);
		map.put("code", Boolean.TRUE);
		map.put("data", list);
		return map;
	}
	
	@RequestMapping(value = "/qaa/reply/{idx}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable int idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		this.qaaReplyService.deleteReply(idx);
		map.put("code", Boolean.TRUE);
		return map;
	}
	
	@RequestMapping(value = "/qaa/reply", method = RequestMethod.PUT)
	@ResponseBody
	public Map update(@RequestBody QaaReplyVO qaaReplyVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		this.qaaReplyService.updateReply(qaaReplyVo);
		map.put("code", Boolean.TRUE);
		return map;
	}
}
