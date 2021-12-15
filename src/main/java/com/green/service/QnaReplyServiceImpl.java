package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.QnaReplyMapper;
import com.green.mapper.ReplyMapper;
import com.green.vo.Criteria;
import com.green.vo.QnaReplyPageDTO;
import com.green.vo.QnaReplyVO;
import com.green.vo.ReplyPageDTO;
import com.green.vo.ReplyVO;

import lombok.Setter;
@Service
public class QnaReplyServiceImpl implements QnaReplyService{

	@Setter(onMethod_=@Autowired )
	QnaReplyMapper mapper;
	
	@Override
	public int register(QnaReplyVO vo) {
		
		return mapper.insert(vo);
	}

	@Override
	public QnaReplyVO get(int rno) {
		// TODO Auto-generated method stub
		return mapper.read(rno);
	}

	@Override
	public int modify(QnaReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int remove(int rno) {
		// TODO Auto-generated method stub
		return mapper.delete(rno);
	}

	@Override
	public List<QnaReplyVO> getList(Criteria cri, int qno) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, qno);
	}

	@Override
	public QnaReplyPageDTO getListPage(Criteria cri, int qno) {
		// TODO Auto-generated method stub
		return new QnaReplyPageDTO(mapper.getCountByBno(qno), mapper.getListWithPaging(cri, qno));
	}

}
