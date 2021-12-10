package com.green.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.service.ReportService;
import com.green.vo.ReportVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReportController {
	@Setter(onMethod_=@Autowired)
	ReportService reportService;
	
	@ResponseBody
	@RequestMapping (value = "/reportRegist" , method = RequestMethod.POST)
	public ReportVO reportRegist(ReportVO vo) {
		
	  if(reportService.getReport(vo) != null) {
		  reportService.update(vo);
	  }
	  else{reportService.regist(vo);}
			
		return vo;
		
	}
	
	@ResponseBody
	@RequestMapping (value = "/reportDelete",method = RequestMethod.POST)
	public String reportDelete(ReportVO vo) {
		reportService.delete(vo);
		return "삭제";
	}
}
