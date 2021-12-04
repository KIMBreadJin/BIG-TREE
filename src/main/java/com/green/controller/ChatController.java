package com.green.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.green.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat/*")
@Slf4j
public class ChatController {
	@GetMapping("/room1")
	public void chat(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("info");
		
		
		log.info("==================================");
		log.info("@ChatController, GET Chat / Username : " + vo.getUser_name());
		
		model.addAttribute("userid", vo.getUser_name());
	}
	@GetMapping("/chatList")
	public void chatlist() {
		log.info("채팅목록--");
	}
}
