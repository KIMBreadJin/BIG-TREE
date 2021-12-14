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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.service.MessageService;
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
}
