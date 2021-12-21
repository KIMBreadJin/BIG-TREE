package com.green.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.green.vo.Criteria;
import com.green.vo.QnaReplyVO;
import com.green.vo.ReplyVO;



public interface QnaReplyMapper {
	//* 공부하기위한 메모용임!!
	//@param 어노테이션을 사용하는 이유? mybatis에서 두개이상의 파라미터를 전달할때!
	public int insert(QnaReplyVO vo); 
	public QnaReplyVO read(int rno);
	public int delete(int rno);  
	public int update(QnaReplyVO vo);
	public List<QnaReplyVO> getListWithPaging(
			@Param("cri") Criteria Cri,
			@Param("qno") int qno
		);
	public int getCountByBno(int qno);
	
	public void deleteWithQna(int qno);
	//댓글의숫자파악을위하여
	
			
	
}