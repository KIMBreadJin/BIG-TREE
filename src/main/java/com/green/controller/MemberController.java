package com.green.controller;

import java.util.HashMap;

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

import com.green.service.KakaoService;
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
	@Setter(onMethod_=@Autowired)
	KakaoService kakaoService;
	
// 로그인 ------------	
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
	
// 회원가입 ( 중복체크 )  ----------	
	@GetMapping("/register")
	public void signup() {
		System.out.println(" 회원가입 페이지 ");
	}
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) {
		int result = service.idChk(vo);
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/phnChk", method = RequestMethod.POST)
	public int phnChk(MemberVO vo) {
		int result = service.phnChk(vo);
		return result;
	}
	
	@PostMapping("/register")
	public String postSignup(Model model, MemberVO vo) {
		int idChk = service.idChk(vo);
		int phnChk = service.phnChk(vo);
		try {
 			 if(idChk == 1) {
				return "/member/register";
			}if(phnChk == 1) {
				return "/member/register";
			}if(idChk == 0 && phnChk == 0) {
				log.info("회원가입 성공");
				service.signup(vo);
			}
		}catch(Exception e) {
			throw new RuntimeException();
		}				
		return "redirect:/member/login";
	}
	
// 회원 정보 찾기 & 비밀번호 초기화	 ----------
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
	@RequestMapping("/login")
	public String home(@RequestParam(value = "code", required = false) String code, Model model) throws Exception{
		System.out.println("#########" + code);
	    String access_Token = kakaoService.getAccessToken(code);
	    HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
	    System.out.println("###access_Token#### : " + access_Token);
	    System.out.println("###userInfo#### : " + userInfo.get("email"));
	    System.out.println("###nickname#### : " + userInfo.get("nickname"));
	    model.addAttribute("access_token",access_Token);
	    return "/member/login";
	}
}
