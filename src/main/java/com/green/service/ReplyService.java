package com.green.service;

import java.util.List;

import com.green.vo.Criteria;
import com.green.vo.ReplyPageDTO;
import com.green.vo.ReplyVO;

public interface ReplyService {
	public int register(ReplyVO vo);
	public ReplyVO get(int rno);
	public int modify(ReplyVO vo);
	public int remove(int rno);
	public List<ReplyVO> getList(Criteria cri, int bno);
	public ReplyPageDTO getListPage(Criteria cri,int bno);
}
