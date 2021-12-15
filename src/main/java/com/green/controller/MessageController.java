package com.green.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.green.service.MessageService;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.MemberVO;
import com.green.vo.MessageVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/message/*")
@Slf4j
public class MessageController {
	@Setter(onMethod_=@Autowired)
	MessageService service;
	
	@GetMapping("/sendMsg")
	public void getMsg() {
	
	}
	
	@RequestMapping(value="/sendMsg", method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> sendMessage(@RequestBody MessageVO vo){		
		ResponseEntity<String> entity = null;
		try {
			service.sendMsg(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	@GetMapping("/msgList")
	public void getMList(Model model, MessageVO vo, HttpServletRequest request) {

	}
	@GetMapping("/readMsg")
	public void readMsg(@RequestParam("mid")long mid, Model model) {
		
		model.addAttribute("readM",service.readMsg(mid));
	}
	@PostMapping("/readMsg")
	public String postMsg(Model model, MessageVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		vo.setReceiver_id(request.getParameter("receiver_id"));
		vo.setReceiver_name(request.getParameter("receiver_name"));
		log.info("받아오나" + request.getParameter("receiver_id") , vo.getReceiver_id());
		log.info("받아오나2" + request.getParameter("receiver_name") , vo.getReceiver_id());
		session.setAttribute("ans", vo);
		
		return "/message/sendMsg";
	}
	
	@PostMapping("/deleteMsg")
	public String postDelMesg(@RequestParam("mid") long mid ,MemberVO vo, MessageVO msg,RedirectAttributes redirectAttributes, HttpServletRequest request){
		service.deleteMsg(mid);
		
		HttpSession session = request.getSession();
		vo = (MemberVO)session.getAttribute("info");
		msg.setReceiver_id(vo.getUser_id());
		List<MessageVO> list = service.msgList(msg);
		session.removeAttribute("mlist");
		session.removeAttribute("cntMsg");
		session.setAttribute("mlist", list);
		session.setAttribute("cntMsg", service.countMsg(msg.getReceiver_id()));
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
}
