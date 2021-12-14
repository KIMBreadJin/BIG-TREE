package com.green.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.green.service.MemberService;
import com.green.service.QnaService;
import com.green.vo.Criteria;
import com.green.vo.MemberVO;
import com.green.vo.PageDTO;
import com.green.vo.QnaVO;


import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/qna/*")
public class QnaController {
	@Setter(onMethod_=@Autowired)
	QnaService qnaService;
	@Setter(onMethod_=@Autowired)
	MemberService memberService;
	
	@GetMapping("/list")
	public void getList(Model model,Criteria cri,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("info");
		
		int count= qnaService.getTotalCount();
		model.addAttribute("member",vo);
		log.info("갑자기 왜이러나"+qnaService.getQnaListWithPage(cri));
		model.addAttribute("list",qnaService.getQnaListWithPage(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, count));
	
	}
	@GetMapping("/register")
	public void getRegister( @ModelAttribute Criteria cri,Model model) {
		model.addAttribute("cri",cri);
	}
	
	@PostMapping("/register")
	public String postRegister(QnaVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		qnaService.registQna(vo);
		rttr.addFlashAttribute("result","성공");
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@GetMapping("/details")//게시글조회
	public void getDetails(@RequestParam("qno")int qno,Model model, @ModelAttribute("cri") Criteria cri,HttpServletRequest request) {
		QnaVO vo = new QnaVO();
	
		vo=qnaService.getQna(qno);			
		model.addAttribute("qna",vo);

		
	}
	
	@PostMapping("/modify")
	public String postModify(QnaVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		rttr.addAttribute("pageNum", cri.getPageNum());//추가
		rttr.addAttribute("amount",cri.getAmount());//추가 
		rttr.addAttribute("type",cri.getType());//추가 
		rttr.addAttribute("keyword",cri.getKeyword());//추가 
		qnaService.updateQna(vo);
		return "redirect:/qna/list";
	}
	@PostMapping("/delete")
	public String postDelete(QnaVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		qnaService.deleteQna(vo.getQno());
		return "redirect:/qna/list"+cri.getListLink();
	}
	
	@GetMapping("/modify")
	public void getModify(@RequestParam("qno")int qno,Model model, @ModelAttribute("cri") Criteria cri) {
		QnaVO vo = new QnaVO();
		vo=qnaService.getQna(qno);
		model.addAttribute("qna",vo);
	}
}
