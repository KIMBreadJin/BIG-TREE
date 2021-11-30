package com.green.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.green.vo.ReplyVO;



public interface ReplyMapper {
	public int insert(ReplyVO vo); 
	public ReplyVO read(Long rno);
	public int delete(int rno);  
	public int update(ReplyVO reply);

			
	
}