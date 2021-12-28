package com.green.controller;

import java.util.HashMap;
import java.util.List;

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
import com.green.service.MessageService;
import com.green.vo.MemberVO;
import com.green.vo.MessageVO;

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
	String kakaoid = "";
	String kakaoName="";
	@Setter(onMethod_=@Autowired)
	MessageService msgService;
	
	MemberVO memberData = new MemberVO();
	
	@RequestMapping(value = {"/member/login","/"},  method = RequestMethod.POST)
	@ResponseBody
	public int loginform(MemberVO vo, MessageVO msg,  HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		log.info("1) 로그인 고객 정보 ");	
		vo.setUser_id(request.getParameter("user_id"));
		vo.setUser_pwd(request.getParameter("user_pwd"));
		log.info("아이디" + vo.getUser_id() + "비밀번호" + vo.getUser_pwd());
		int result = service.login(vo);
		
		session.setAttribute("info", service.info(vo));
		log.info("login session" + session.getAttribute("info"));
		memberData = service.info(vo);
		if(result == 1) {
			vo = (MemberVO)session.getAttribute("info");
			msg.setReceiver_id(vo.getUser_id());
			List<MessageVO> list = msgService.msgList(msg);
			log.info("message...." + list);
			session.setAttribute("mlist", list);
		}
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
		int result = service.idChk(vo);
		try {
			if(result == 1) {
				model.addAttribute("msg","아이디가 중복되었습니다");
				return "/member/register";
			}else if(result == 0) {
				log.info("회원가입 성공");
				model.addAttribute("msg","회원가입 완료! 로그인 해주세요");
				service.signup(vo);
			}
		}catch(Exception e) {
			throw new RuntimeException();
		}				
		return "redirect:/member/login";
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
	@RequestMapping("/login")
	public String home(@RequestParam(value = "code", required = false) String code, Model model, MemberVO vo) throws Exception{
		System.out.println("#########" + code);
	    String access_Token = kakaoService.getAccessToken(code);
	    HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
	    String id = (String) userInfo.get("id");
	    System.out.println("###access_Token#### : " + access_Token);
	    System.out.println("###nickname#### : " + userInfo.get("nickname"));
	    System.out.println("###kakao_id'### : " + id);
	    model.addAttribute("access_token",access_Token);
	    vo.setUser_kakao(id);
	    kakaoid = vo.getUser_kakao();
	    kakaoName = (String)userInfo.get("nickname");
	    if(vo.getUser_kakao()!=null) {
	    	System.out.println("kakaoid : "+kakaoid);
	    	return "/member/kakaoCheck";
	    }
	    else return "/member/login";
	}
	@ResponseBody
	@RequestMapping(value="/kakaoCheck", method = RequestMethod.POST)
	public int kakaoCheck(MemberVO vo) {
		vo.setUser_kakao(kakaoid);
		System.out.println("카카오 id 값 : "+vo.getUser_kakao());
		System.out.println("닉네임 : "+kakaoName);
		int result = service.kakaoChk(vo);
		return result;
	}
	@GetMapping("/kakaoReg")
	public void kakaoSignup(Model model) {
		System.out.println(" 카카오 간편가입 페이지 ");
		model.addAttribute("name",kakaoName);
		model.addAttribute("id",kakaoid);
	}
	@RequestMapping(value = "/kakaologin",  method = RequestMethod.POST)
	@ResponseBody
	public int kakaologin(MemberVO vo, MessageVO msg, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		log.info("1) 로그인 고객 정보 ");	
		vo.setUser_kakao(kakaoid);
		log.info("카카오:" + vo.getUser_kakao());
		int result = service.kakaologin(vo);
		log.info("아이디 개수"+result);		
		log.info("1) 로그인 고객 정보 " + service.kakaoinfo(vo));
		memberData = service.kakaoinfo(vo);
		session.setAttribute("info", service.kakaoinfo(vo));
		log.info("넘버" + session.getAttribute("info"));
		if(result == 1) {
			vo = (MemberVO)session.getAttribute("info");
			msg.setReceiver_id(vo.getUser_id());
			List<MessageVO> list = msgService.msgList(msg);
			log.info("What...." + list);
			session.setAttribute("mlist", list);
		}
		return result;
	}

	@RequestMapping(value="/updatePwd", method=RequestMethod.GET)
	public void updatePwd(Model model) {
		model.addAttribute("pwd", memberData.getUser_pwd());
	}
	@RequestMapping(value="/updatePwd" , method = RequestMethod.POST)
	public String updatePwd(MemberVO vo, HttpServletRequest request) {
		vo.setUser_id(memberData.getUser_id());
		vo.setUser_pwd(request.getParameter("password"));
		service.updatePwd(vo);
		return "redirect:/board/list";
	}
	@GetMapping("/checkPwd")
	public void checkPwd(Model model) {
		model.addAttribute("pwd", memberData.getUser_pwd());
		log.info("비밀번호 확인");
	}
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modify(Model model) {
		log.info("회원정보 변경");
		String phone = memberData.getUser_phone();
		String phone1 = phone.substring(4, 8);
		String phone2 = phone.substring(9);
		log.info(phone1+"-"+phone2);
		model.addAttribute("phone1",phone1);
		model.addAttribute("phone2",phone2);
	}
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(MemberVO vo, MessageVO msg, HttpServletRequest request) {
		HttpSession session = request.getSession();
		vo.setUser_num(memberData.getUser_num());
		memberData.setUser_email(vo.getUser_email());
		memberData.setUser_birth(vo.getUser_birth());
		memberData.setUser_address(vo.getUser_address());
		memberData.setUser_phone(vo.getUser_phone());
		service.modify(vo);
		session.setAttribute("info", service.info(vo));
		vo = (MemberVO)session.getAttribute("info");
		msg.setReceiver_id(vo.getUser_id());
		List<MessageVO> list = msgService.msgList(msg);
		log.info("modify 1)...." + list);
		session.setAttribute("mlist", list);
		return "redirect:/board/list";
	}
	@GetMapping("/checkProfile")
	public void checkProfile(Model model) {
		model.addAttribute("pwd", memberData.getUser_pwd());
		log.info("프로필 조회 비밀번호 확인");
	}
	@RequestMapping(value="/profile", method=RequestMethod.GET)
	public void profile(Model model) {
		log.info("회원정보 조회");
		model.addAttribute("profile", memberData);
	}
	@PostMapping("/deleteM")
	public String removeUser(MemberVO vo, HttpSession session) {
		service.deleteUser(vo.getUser_id());
		session.invalidate();
		return "redirect:/member/login";
	}
}
