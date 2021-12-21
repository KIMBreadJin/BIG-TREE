package com.green.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.green.vo.Criteria;
import com.green.vo.ReplyVO;



public interface ReplyMapper {
	//* 공부하기위한 메모용임!!
	//@param 어노테이션을 사용하는 이유? mybatis에서 두개이상의 파라미터를 전달할때!
	public int insert(ReplyVO vo); 
	public ReplyVO read(int rno);
	public int delete(int rno);  
	public int update(ReplyVO reply);
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria Cri,
			@Param("bno") int bno
		);
	public int getCountByBno(int bno);
	//댓글의숫자파악을위하여
	public void deletewithBoard(int bno);
			
	
}