package com.green.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.service.RecommendedService;
import com.green.vo.RecommendedVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class RecommendedController {
	
	@Setter(onMethod_=@Autowired)
	RecommendedService recommendedService;
	
	@ResponseBody
	@RequestMapping(value = "/updateRecommended",method=RequestMethod.POST)
	public String updateRecommended(RecommendedVO vo) {
		String msg="";
		if(recommendedService.getRecommended(vo) == null) {
			recommendedService.registRecommended(vo);
			msg="추천 신규등록";
		}
		else {
			recommendedService.updateRecommended(vo);
			msg="추천 업데이트";
		}
		return msg;
	}
	
	
	
}
