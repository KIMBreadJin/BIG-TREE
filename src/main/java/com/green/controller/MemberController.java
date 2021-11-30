package com.green.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.service.MemberService;
import com.green.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	@Setter(onMethod_=@Autowired)
	MemberService service;
	
	@GetMapping("/login")
	public void login() {
		log.info("login page");
	}
	
	@RequestMapping(value = {"/member/login","/"},  method = RequestMethod.POST)
	@ResponseBody
	public int loginform(MemberVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		log.info("1) 로그인 고객 정보 ");	
		vo.setUser_id(request.getParameter("user_id"));
		vo.setUser_pwd(request.getParameter("user_pwd"));
		log.info("아이디" + vo.getUser_id() + "비밀번호" + vo.getUser_pwd());
		int result = service.login(vo);
		log.info("아이디 개수"+result);		
		log.info("1) 로그인 고객 정보 " + service.info(vo));
		
		session.setAttribute("info", service.info(vo));
		log.info("넘버" + session.getAttribute("info"));
		return result;
	}
	@RequestMapping(value ="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		log.info("logout success....");
		return "redirect:/board/list";
	}
	@GetMapping("/register")
	public void signup() {
		System.out.println(" 회원가입 페이지 ");
	}
	@PostMapping("/register")
	public String postSignup(MemberVO vo) {
		System.out.println("회원가입 성공");
		service.signup(vo);
		
		return "/member/login";
	}
	
	@RequestMapping(value = "/member/findId", method = RequestMethod.GET)
	public String findId() {
		return "/member/findId";
	}
	@RequestMapping(value="/member/findId", method=RequestMethod.POST)
	public String findIdAction(MemberVO vo, Model model) {
		MemberVO user = service.findId(vo);
		
		if(user == null) { 
			model.addAttribute("check", 1);
		} else { 
			model.addAttribute("check", 0);
			model.addAttribute("id", user.getUser_id());
		}
		
		return "/member/findId";
	}
	@RequestMapping(value = "/member/findPwd", method = RequestMethod.GET)
	public String findPwd() {
		return "/member/findPwd";
	}
	
	@RequestMapping(value="/member/findPwd", method=RequestMethod.POST)
	public String findPasswordAction(MemberVO vo, Model model) {
		MemberVO user = service.findPwd(vo);
		
		if(user == null) { 
			model.addAttribute("check", 1);
		} else { 
			model.addAttribute("check", 0);
			model.addAttribute("updateid", user.getUser_id());
		}
		
		return "/member/findPwd";
	}
	@RequestMapping(value="update_password", method=RequestMethod.POST)
	public String updatePasswordAction(@RequestParam(value="updateid", defaultValue="", required=false) String id,
			MemberVO vo) {
		vo.setUser_id(id);
		System.out.println(vo);
		service.updatePwd(vo);
		return "/member/login";
	}
}
