package com.green.controller;



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

import com.green.service.QnaReplyService;
import com.green.vo.Criteria;
import com.green.vo.QnaReplyPageDTO;
import com.green.vo.QnaReplyVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/replies2/*")
@Slf4j
public class QnaReplyController {

	@Setter(onMethod_=@Autowired)
	QnaReplyService service;
	
	//등록을하기위함
	@PostMapping(value="/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody QnaReplyVO vo){
		log.info("QnaReplyVO: "+   vo);
		int insertCount = service.register(vo);
		log.info("insertCount: "+   insertCount);
		return insertCount ==1 ?
				new ResponseEntity<>("success",HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	
	@GetMapping(value= "/pages/{qno}/{page}",
			produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<QnaReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("qno") int qno
			){
		Criteria criteria = new Criteria(page,10);
		//페이지당 10개로 페이지당 갯수를 조절하려면 여기로		
		QnaReplyPageDTO list=service.getListPage(criteria, qno);
		log.info(qno+"의 댓글"+service.getList(criteria, qno));
		list.setList(service.getList(criteria, qno));
		log.info("QnaReplyPageDTO="+list);
		//log.info안에 string을 위해 "" + 
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	//특정리플 조회하기(수정,삭제)를위하여
	@GetMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<QnaReplyVO> get(@PathVariable("rno") int rno){
		log.info("1) 컨트롤러에서의 댓글 하나 가져오기 ...... " +rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	
	//삭제
	@DeleteMapping(value = "/{rno}",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") int rno){
		log.info("삭제하는 댓글번호"  +rno);
		return service.remove(rno) ==1?
				new ResponseEntity<>("success",HttpStatus.OK):
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	//수정
		@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},
				value = "/{rno}",consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> modify(
			@RequestBody QnaReplyVO vo,
			@PathVariable("rno") int rno){
		vo.setRno(rno);
		log.info("rno:"+rno);
		log.info("modify"+vo);
		return service.modify(vo) == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	
	}


	
	
}
