package com.green.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.green.service.RecommendedService;
import com.green.service.ReportService;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.MemberVO;
import com.green.vo.PageDTO;
import com.green.vo.RecommendedVO;
import com.green.vo.ReportVO;

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
	@Setter(onMethod_=@Autowired)
	RecommendedService recommendedService;
	@Setter(onMethod_= @Autowired)
	ReportService reportService;
	
	@GetMapping("/list")
	public void getList(Criteria cri,Model model,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO)session.getAttribute("info");
		
		int count= boardService.getTotalCount(cri);
		model.addAttribute("member",vo);
		model.addAttribute("list",boardService.getBoardListWithPage(cri));
		model.addAttribute("pageMaker",new PageDTO(cri, count));
		model.addAttribute("popular", boardService.popularViews());
		
		
	}
	@GetMapping("/register")
	public void getRegister( @ModelAttribute Criteria cri,Model model) {
		model.addAttribute("cri",cri);
	}
	
	@PostMapping("/register")
	public String postRegister(BoardVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		boardService.registBoard(vo);
		rttr.addFlashAttribute("result","성공");
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@GetMapping("/details")//게시글조회
	public void getDetails(@RequestParam("bno")int bno,Model model, @ModelAttribute("cri") Criteria cri,HttpServletRequest request) {
		BoardVO vo = new BoardVO();
		boardService.updateViews(bno);
		
		int totalLike= recommendedService.getRecommendList(bno).size()!=0 ? recommendedService.getTotalLike(bno) : 0;//게시글의 추천이 하나도 없을경우 0으로 선언
		int totalHate= recommendedService.getRecommendList(bno).size()!=0 ? recommendedService.getTotalHate(bno): 0;
		MemberVO mVo=(MemberVO)request.getSession().getAttribute("info");
		vo=boardService.getBoard(bno);	
		
		RecommendedVO rVo= new RecommendedVO();
		rVo.setBno(bno);
		rVo.setUser_id(mVo!=null? mVo.getUser_name(): "비회원");//현재 접속중인유저의 이름,로그아웃상태는 비회원
		rVo.setHated(0);
		rVo.setLiked(0);
		RecommendedVO rVo2=recommendedService.getRecommended(rVo);

		model.addAttribute("board",vo);
		model.addAttribute("recommended",rVo2 !=null ? rVo2 : rVo);//해당유저가 해당게시글에 추천or비추천 했으면 rVo2, 그렇지않으면 rVo
		model.addAttribute("totalLike",totalLike);
		model.addAttribute("totalHate",totalHate);
		
	}
	
	@PostMapping("/modify")
	public String postModify(BoardVO vo,RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
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
	
//	//인기글테스트용 		
//	ModelAndView mav = new ModelAndView();
//	Map<String,Object> map = new HashMap<>();
//	map.put("list",list);
//	mav.addObject("map",map);
//	mav.setViewName("/list");
//	return mav;
}


