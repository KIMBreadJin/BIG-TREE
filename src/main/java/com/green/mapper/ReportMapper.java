package com.green.mapper;

import java.util.List;

import com.green.vo.ReportVO;

public interface ReportMapper {
	public void regist(ReportVO vo);
	public void delete(ReportVO vo);
	public void update(ReportVO vo);
	
	public List<ReportVO> getReportList(int bno);
	public int getReportCount(int bno);
	public ReportVO getReport(ReportVO vo);
}
