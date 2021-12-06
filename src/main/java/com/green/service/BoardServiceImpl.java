package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.BoardMapper;
import com.green.mapper.ImageUploadMapper;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.ImageVO;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_=@Autowired)
	BoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	ImageUploadMapper imageUploadMapper;
	
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
		if(vo.getImageList()==null || vo.getImageList().size() <=0 ) {
			return;
		}
		vo.getImageList().forEach(i->{
			i.setBno(vo.getBno());
			imageUploadMapper.regist(i);
		});
	}

	@Override
	public void updateBoard(BoardVO vo) {
		imageUploadMapper.deleteAll(vo.getBno());//첨부이미지 삭제
		boardMapper.updateBoard(vo);
		
		if(vo.getImageList()!=null && vo.getImageList().size()>0) {
			vo.getImageList().forEach(i->{
				i.setBno(vo.getBno());
				imageUploadMapper.regist(i);
			});
		}
	}

	@Override
	public void deleteBoard(int bno) {
		imageUploadMapper.deleteAll(bno);
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

	@Override
	public List<ImageVO> getImageList(int bno) {
		return imageUploadMapper.getImageList(bno);
	}

}
