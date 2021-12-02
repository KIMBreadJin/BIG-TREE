package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.ReplyMapper;
import com.green.vo.Criteria;
import com.green.vo.ReplyVO;

import lombok.Setter;
@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_=@Autowired )
	ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		return mapper.getListWithPaging(cri, bno);
	}

}
