package com.green.service;

import java.util.List;

import com.green.vo.ReportVO;

public interface ReportService {
	public void regist(ReportVO vo);
	public void delete(ReportVO vo);
	public List<ReportVO> getReportList(int bno);
	public int getReportCount(int bno);
	public ReportVO getReport(ReportVO vo);
	public void update(ReportVO vo);
}
