package com.green.controller;

import java.util.List;

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

import com.green.service.BoardService;
import com.green.service.MemberService;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.MemberVO;
import com.green.vo.PageDTO;
import com.sun.org.apache.bcel.internal.generic.NEW;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
public class BoardController {
	@Setter(onMethod_=@Autowired)
	BoardService boardService;
	@Setter(onMethod_=@Autowired)
	MemberService memberService;
	@GetMapping("/list")
	public void getList(Model model,Criteria cri,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		log.info("cri는"+cri);
		MemberVO vo = (MemberVO)session.getAttribute("info");
		log.info("user="+session.getAttribute("info"));
		int count= boardService.getTotalCount();
		model.addAttribute("member",vo);
		model.addAttribute("list",boardService.getBoardListWithPage(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, count));
	}
	@GetMapping("/register")
	public void getRegister( @ModelAttribute Criteria cri,Model model) {
		model.addAttribute("cri",cri);
	}
	
	@PostMapping("/register")
	public String postRegister(BoardVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		boardService.registBoard(vo);
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@GetMapping("/details")
	public void getDetails(@RequestParam("bno")int bno,Model model, @ModelAttribute("cri") Criteria cri) {
		BoardVO vo = new BoardVO();
		boardService.updateViews(bno);
		vo=boardService.getBoard(bno);
		model.addAttribute("board",vo);
	}
	
	@PostMapping("/modify")
	public String postModify(BoardVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		rttr.addAttribute("pageNum", cri.getPageNum());//추가
		rttr.addAttribute("amount",cri.getAmount());//추가 
		rttr.addAttribute("type",cri.getType());//추가 
		rttr.addAttribute("keyword",cri.getKeyword());//추가 
		boardService.updateBoard(vo);
		return "redirect:/board/list";
	}
	@PostMapping("/delete")
	public String postDelete(BoardVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		boardService.deleteBoard(vo.getBno());
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@GetMapping("/modify")
	public void getModify(@RequestParam("bno")int bno,Model model, @ModelAttribute("cri") Criteria cri) {
		BoardVO vo = new BoardVO();
		vo=boardService.getBoard(bno);
		model.addAttribute("board",vo);
	}
}
