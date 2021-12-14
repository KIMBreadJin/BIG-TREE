package com.green.service;

import java.util.List;


import com.green.vo.Criteria;
import com.green.vo.ImageVO;
import com.green.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> getQnaList();//게시글 목록가져오기
	public QnaVO getQna(int qno);//게시글 가져오기
	public void registQna(QnaVO vo);//게시글 등록
	public void updateQna(QnaVO vo);//게시글 업데이트
	public void deleteQna(int qno);//게시글 삭제
	public List<QnaVO> getQnaListWithPage(Criteria cri);
	public int getTotalCount();//게시글 수 조회
	public List<ImageVO>getImageList(int qno);
	
} 
