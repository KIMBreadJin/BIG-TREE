package com.green.service;

import java.util.List;

import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.ImageVO;
import com.green.vo.ReplyPageDTO;

public interface BoardService {
	public List<BoardVO> getBoardList();//게시글 목록가져오기
	public BoardVO getBoard(int bno);//게시글 가져오기
	public void registBoard(BoardVO vo);//게시글 등록
	public void updateBoard(BoardVO vo);//게시글 업데이트
	public void deleteBoard(int bno);//게시글 삭제
	public void updateViews(int bno);
	public List<BoardVO> getBoardListWithPage(Criteria cri);
	public int getTotalCount(Criteria cri);//게시글 수 조회
	public List<ImageVO>getImageList(int bno);
	public List<BoardVO> popularViews(); //인기 게시글 조회


}
