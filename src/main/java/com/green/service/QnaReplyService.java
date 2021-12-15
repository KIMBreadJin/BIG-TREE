package com.green.service;

import java.util.List;

import com.green.vo.Criteria;
import com.green.vo.QnaReplyPageDTO;
import com.green.vo.QnaReplyVO;
import com.green.vo.ReplyPageDTO;
import com.green.vo.ReplyVO;

public interface QnaReplyService {
	public int register(QnaReplyVO vo);
	public QnaReplyVO get(int rno);
	public int modify(QnaReplyVO vo);
	public int remove(int rno);
	public List<QnaReplyVO> getList(Criteria cri, int qno);
	public QnaReplyPageDTO getListPage(Criteria cri,int qno);
}
