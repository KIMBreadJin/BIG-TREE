package com.green.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.green.mapper.BoardMapper;
import com.green.mapper.ImageUploadMapper;
import com.green.mapper.RecommendedMapper;
import com.green.mapper.ReplyMapper;
import com.green.mapper.ReportMapper;
import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.GetSessionUser;
import com.green.vo.ImageVO;
import com.green.vo.MemberVO;
import com.green.vo.ReportVO;

import lombok.Setter;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Log4j
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_=@Autowired)
	BoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	ImageUploadMapper imageUploadMapper;
	
	@Setter(onMethod_=@Autowired)
	RecommendedMapper recommendedMapper;
	
	@Setter(onMethod_=@Autowired)
	ReportMapper reportMapper;
	
	@Setter(onMethod_=@Autowired)
	ReplyMapper replyMapper;
	
	@Override
	public List<BoardVO> getBoardList() {
		List<BoardVO> boardList=boardMapper.getBoardList();
		for(BoardVO board : boardList) {
			board.setReplyCnt(replyMapper.getCountByBno(board.getBno()));
			
		}
		log.info("boardList="+boardList);
		return boardList;
	}

	@Override
	public BoardVO getBoard(int bno) {
		ReportVO reportVO = new ReportVO();
		reportVO.setBno(bno);
		
		log.info("asdasd"+reportVO);
		BoardVO boardVo =boardMapper.getBoard(bno);
		if(GetSessionUser.getUser()!=null) {
			String userId=GetSessionUser.getUser().getUser_id();
			reportVO.setReporter_id(userId);
			boardVo.setReportWithUser(reportMapper.getReport(reportVO));//게시글을 불러올때 유저가 해당게시글에 신고하였으면 정보를 가져감 
			boardVo.setReportList(reportMapper.getReportList(bno));
		}
		return boardVo;
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
		recommendedMapper.deleteAll(bno);
		replyMapper.deletewithBoard(bno);
		imageUploadMapper.deleteAll(bno);
		boardMapper.deleteBoard(bno);	
	}

	@Override
	public List<BoardVO> getBoardListWithPage(Criteria cri) {
		List<BoardVO> boardList= boardMapper.getBoardListWithPage(cri);
		for(BoardVO board : boardList) {
			board.setReplyCnt(replyMapper.getCountByBno(board.getBno()));
		}
		return boardList;
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public void updateViews(int bno) {
		boardMapper.updateViews(bno);
		
	}

	@Override
	public List<ImageVO> getImageList(int bno) {
		return imageUploadMapper.getImageList(bno);
	}

	@Override
	public List<BoardVO> popularViews() {
		// TODO Auto-generated method stub
		return boardMapper.popularViews();
	}

}
