package com.green.mapper;

import java.util.List;



import com.green.vo.BoardVO;
import com.green.vo.Criteria;

public interface BoardMapper {
	public List<BoardVO> getBoardList();//게시글 목록가져오기
	public BoardVO getBoard(int bno);//게시글 가져오기
	public void registBoard(BoardVO vo);//게시글 등록
	public void updateBoard(BoardVO vo);//게시글 업데이트
	public void deleteBoard(int bno);//게시글 삭제
	
	public List<BoardVO> getBoardListWithPage(Criteria cri);//페이징처리
	public int getTotalCount();//게시글 갯수 가져오기
	public void updateViews(int bno);

}
