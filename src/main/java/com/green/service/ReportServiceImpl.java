package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.ReportMapper;
import com.green.vo.ReportVO;

import lombok.Setter;

@Service
public class ReportServiceImpl implements ReportService {

	@Setter(onMethod_=@Autowired)
	ReportMapper reportMapper;
	
	@Override
	public void regist(ReportVO vo) {
		reportMapper.regist(vo);
	}

	@Override
	public void delete(ReportVO vo) {
		reportMapper.delete(vo);	
	}

	@Override
	public List<ReportVO> getReportList(int bno) {
		return reportMapper.getReportList(bno);
	}

	@Override
	public int getReportCount(int bno) {
		return reportMapper.getReportCount(bno);
	}

	@Override
	public ReportVO getReport(ReportVO vo) {
		return reportMapper.getReport(vo);
	}

	@Override
	public void update(ReportVO vo) {
		reportMapper.update(vo);
	}

}
