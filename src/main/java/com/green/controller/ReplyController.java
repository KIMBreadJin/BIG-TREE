package com.green.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.green.service.ReplyService;
import com.green.vo.Criteria;
import com.green.vo.ReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/replies/*")
@Slf4j
public class ReplyController {

	@Setter(onMethod_=@Autowired)
	ReplyService service;
	
	//등록을하기위함
	@PostMapping(value="/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: "+   vo);
		int insertCount = service.register(vo);
		log.info("insertCount: "+   insertCount);
		return insertCount ==1 ?
				new ResponseEntity<>("success",HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//특정게시물조회
	@GetMapping(value= "/pages/{bno}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<List<ReplyVO>> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno
			){
		log.info("목록조회.........");
		Criteria criteria = new Criteria(page,10);
		//페이지당 10개로 페이지당 갯수를 조절하려면 여기로
		log.info(""+criteria);
		//log.info안에 string을 위해 "" + 
		return new ResponseEntity<>(service.getList(criteria, bno),HttpStatus.OK);
	}
	@GetMapping(value = "/{rno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			} )
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")Long rno){
		log.info("목록조회.."+rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	//삭제
	@DeleteMapping(value = "/{rno}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			} )
	public ResponseEntity<String> remove(@PathVariable("rno")Long rno){
		log.info("삭제하는 번호 :" + rno);
		
		return service.remove(rno) == 1
				?new ResponseEntity<>("삭제성공",HttpStatus.OK):
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//수정
		@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},
				value = "/{rno}",consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("rno") Long rno){
		vo.setRno(rno);
		log.info("rno:"+rno);
		log.info("modify"+vo);
		return service.modify(vo) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	}
	
	
}
