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
	@RequestMapping (value = "/registFriend" ,produces = "application/text; charset=utf8")
	public String reportRegist(FriendVO vo) {
		String msg="";
		log.info("여긴들어오나");
	  if(friendService.getFriendVO(vo)!= null) {
		  if(friendService.getFriendVO(vo).getCheck_frd()==0) {
			  msg= "수락 대기중인 요청입니다";
		  }
		  else {
			  msg="차단상태입니다";
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
	
}
