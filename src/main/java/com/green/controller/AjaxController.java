package com.green.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.service.BoardService;
import com.green.service.FriendService;
import com.green.service.MemberService;
import com.green.vo.Criteria;
import com.green.vo.FriendVO;
import com.green.vo.MemberVO;
import com.green.vo.ReplyPageDTO;
import com.green.vo.ReportVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AjaxController {
	
	@Setter(onMethod_=@Autowired)
	FriendService friendService;
	
	@Setter(onMethod_=@Autowired)
	MemberService memberService;
	
	@Setter(onMethod_=@Autowired)
	BoardService boardService;
	
	@ResponseBody
	@RequestMapping(value = "/searchUser")
	public int getSearchUser(@RequestParam("user_name")String user_name){
		
		return friendService.getMemberList(user_name)==null? 0 : 
			friendService.getMemberList(user_name).size();
	}
	
	@ResponseBody
	@RequestMapping(value="/getUserList")
	public List<MemberVO> getUserList(@RequestParam("user_name")String user_name , Model model) {
		List<MemberVO> list = friendService.getMemberList(user_name);
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/getFriendList")
	public List<MemberVO> getFriendList(@RequestParam("user_id")String user_id , Model model) {
		List<MemberVO> friendList= friendService.getMyFriend(user_id);
		log.info("조회된 상대유저 정보"+friendList);
		return friendList;
	}
	
	@ResponseBody
	@RequestMapping(value="/getBlockList")
	public List<MemberVO> getBlockList(@RequestParam("user_id")String user_id , Model model) {
		return friendService.getBlockList(user_id);
	}

	@ResponseBody
	@RequestMapping (value = "/registFriend" ,produces = "application/text; charset=utf8")
	public String reportRegist(FriendVO vo) {
		FriendVO vo2= new FriendVO();
		vo2.setSend_id(vo.getReceiver_id());
		vo2.setReceiver_id(vo.getSend_id());
		FriendVO case1= friendService.getFriendVO(vo);
		FriendVO case2= friendService.getFriendVO(vo2);
		String msg="";
		log.info("여긴들어오나");
	  if(case1 != null ) {
		  if(case1.getCheck_frd()==0) {
			  msg= "수락 대기중인 요청입니다";
		  }
		  else if(case1.getCheck_frd()==2) {
			  msg="차단상태입니다";
		  }
		  else {
			  msg="이미 친구목록에 존재하는 회원입니다";
		  }
	  }
	  
	  else if(case2!=null) {
		  if(case2.getCheck_frd()==0) {
			  msg="수락 대기중인 요청입니다";
		  }
		  else if(case2.getCheck_frd()==2) {
			  msg="차단상태입니다";
		  }
		  else {
			  msg="이미 친구목록에 존재하는 회원입니다";
		  }
	  }
	  
	  else{
		  friendService.regist(vo);
		  msg= "요청 성공";
		  }
			
		return msg;
	}
	
	@ResponseBody
	@RequestMapping (value = "/requestReceived" )
	public Map<String, Object> getRequestReceived(FriendVO vo) {
		  Map<String, Object> result= new HashMap<String, Object>();
		    
			List<FriendVO> requestList = friendService.getFriendReceived(vo);
			log.info("requestList(친구요청정보) :"+requestList);
			List<MemberVO> memberList = new ArrayList<MemberVO>();
			requestList.forEach(request->{
				MemberVO member = new MemberVO();
				member.setUser_id(request.getSend_id());
				memberList.add(memberService.findFrd(member));
			});
			
			result.put("requestList", requestList);
			result.put("memberList", memberList);
			return result;
	}
	
	@ResponseBody
	@RequestMapping (value = "/requestSent" )
	public Map<String, Object> getRequestSent(FriendVO vo) {
	    Map<String, Object> result= new HashMap<String, Object>();
	    
		List<FriendVO> requestList = friendService.getFriendSent(vo);
		log.info("requestList(친구요청정보) :"+requestList);
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		requestList.forEach(request->{
			MemberVO member = new MemberVO();
			member.setUser_id(request.getReceiver_id());
			memberList.add(memberService.findFrd(member));
		});
		
		result.put("requestList", requestList);
		result.put("memberList", memberList);
		return result;
	}
	
	@ResponseBody
	@RequestMapping (value = {"/rejectClicked","/deleteClicked"},produces = "application/text; charset=utf8" )
	public String deleteFriend(FriendVO vo) {
	    FriendVO vo2 = friendService.getFriendVO(vo);
	    log.info("view에서 가져온 친구정보:"+ vo);
	    log.info("조회하려는 친구정보"+vo2);
		friendService.delete(vo2);
		return "삭제되었습니다";
	}
	
	@ResponseBody
	@RequestMapping (value = "/blockClicked" ,produces = "application/text; charset=utf8")
	public String blockFriend(FriendVO vo) {
	    FriendVO vo2 = friendService.getFriendVO(vo);
	    log.info("조회하려는 친구정보"+vo2);
	    vo2.setCheck_frd(2);
		friendService.update(vo2);
		return "차단성공";
	}
	
	@ResponseBody
	@RequestMapping (value = "/acceptClicked" ,produces = "application/text; charset=utf8")
	public String acceptFriend(FriendVO vo) {
	    FriendVO vo2 = friendService.getFriendVO(vo);
	    log.info("조회하려는 친구정보"+vo2);
	    vo2.setCheck_frd(1);
		friendService.update(vo2);
		return "수락완료";
	}
	
	@ResponseBody
	@RequestMapping (value = "/getDelete" ,produces = "application/text; charset=utf8")
	public String getDelete(FriendVO vo) {
	    FriendVO vo2 = friendService.getFriendVO(vo);
	    String send_id = vo.getSend_id();
	    String receiver_id = vo.getReceiver_id();
	    if(vo2==null) {
	    	vo.setReceiver_id(send_id);
	    	vo.setSend_id(receiver_id);
	    	vo2= friendService.getFriendVO(vo);
	    }
		friendService.delete(vo2);
		return "처리 완료";
	}
	
	@ResponseBody
	@RequestMapping (value = "/getUser" )
	public MemberVO getUser(@RequestParam("user_name")String user_id) {	
		MemberVO vo= new MemberVO();
		vo.setUser_id(user_id);
		vo=memberService.findFrd(vo);
		Criteria criteria = new Criteria();
		criteria.setKeyword(vo.getUser_id());
		criteria.setType("D");
		int boardCnt = boardService.getBoardListWithPage(criteria)==null?
					0:boardService.getBoardListWithPage(criteria).size();		
		vo.setBoardCnt(boardCnt);
		return vo;
	}
	

	
}
