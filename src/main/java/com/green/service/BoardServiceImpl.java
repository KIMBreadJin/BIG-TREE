package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.BoardMapper;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_=@Autowired)
	BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> getBoardList() {
		return boardMapper.getBoardList();
	}

	@Override
	public BoardVO getBoard(int bno) {
		return boardMapper.getBoard(bno);
	}

	@Override
	public void registBoard(BoardVO vo) {
		boardMapper.registBoard(vo);
	}

	@Override
	public void updateBoard(BoardVO vo) {
		boardMapper.updateBoard(vo);
	}

	@Override
	public void deleteBoard(int bno) {
		boardMapper.deleteBoard(bno);	
	}

	@Override
	public List<BoardVO> getBoardListWithPage(Criteria cri) {
		return boardMapper.getBoardListWithPage(cri);
	}

	@Override
	public int getTotalCount() {
		return boardMapper.getTotalCount();
	}

	@Override
	public void updateViews(int bno) {
		boardMapper.updateViews(bno);
		
	}

}
