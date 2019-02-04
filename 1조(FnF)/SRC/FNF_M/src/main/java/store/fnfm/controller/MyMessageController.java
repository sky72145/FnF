package store.fnfm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import store.fnfm.service.MyMessageService;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.MyMessageVO;

@RestController
public class MyMessageController {
	@Autowired
	private MyMessageService service;
	
	@PostMapping(value = "/MyMessagecreate",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody MyMessageVO vo){
		int insertCount = service.register(vo);
		return insertCount == 1
		? new ResponseEntity<>("success",HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@GetMapping(value="/Mysendview/{send_id}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<MyMessageVO>> getListsed(
			@PathVariable("page") int page,
			@PathVariable("send_id") String send_id){
		Criteria3 cri3 = new Criteria3(page,10);
		return new ResponseEntity<>(service.getListsed(cri3, send_id),HttpStatus.OK);
	}
	
	@GetMapping(value="/Myreceiveview/{receive_id}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<MyMessageVO>> getListrec(
			@PathVariable("page") int page,
			@PathVariable("receive_id") String receive_id){
		Criteria3 cri3 = new Criteria3(page,10);
		return new ResponseEntity<>(service.getListrec(cri3, receive_id),HttpStatus.OK);
	}
	
	@GetMapping(value="/MysendMessageview/{idx}",
			produces = {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<MyMessageVO> getsed(@PathVariable("idx") int idx){
		return new ResponseEntity<>(service.getsed(idx),HttpStatus.OK);
	}
	@GetMapping(value="/MyrecMessageview/{idx}",
			produces = {MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<MyMessageVO> getrec(@PathVariable("idx") int idx){
		this.service.mymodifymsg(idx);
		return new ResponseEntity<>(service.getrec(idx),HttpStatus.OK);
	}

}
