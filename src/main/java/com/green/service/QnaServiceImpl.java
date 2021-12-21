package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.ImageUploadMapper;
import com.green.mapper.QnaMapper;
import com.green.mapper.QnaReplyMapper;
import com.green.mapper.ReplyMapper;
import com.green.vo.Criteria;
import com.green.vo.ImageVO;
import com.green.vo.QnaVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
@Log4j
public class QnaServiceImpl implements QnaService{

	@Setter(onMethod_=@Autowired)
	QnaMapper qnaMapper;
	
	@Setter(onMethod_=@Autowired)
	ImageUploadMapper imageUploadMapper;
	
	@Setter(onMethod_=@Autowired)
	QnaReplyMapper replyMapper;
	
	@Override
	public List<QnaVO> getQnaList() {
		List<QnaVO> qnaList=qnaMapper.getQnaList();
	
		return qnaList;
	}

	@Override
	public QnaVO getQna(int qno) {
		QnaVO qnaVo = qnaMapper.getQna(qno);
		return qnaVo;
	}

	@Override
	public void registQna(QnaVO vo) {
		qnaMapper.registQna(vo);
		if(vo.getImageList()==null || vo.getImageList().size() <=0 ) {
			return;
		}
		vo.getImageList().forEach(i->{
			i.setBno(vo.getQno());
			imageUploadMapper.regist(i);
		});
	}

	@Override
	public void updateQna(QnaVO vo) {
		imageUploadMapper.deleteAll(vo.getQno());//첨부이미지 삭제
		qnaMapper.updateQna(vo);
		
		if(vo.getImageList()!=null && vo.getImageList().size()>0) {
			vo.getImageList().forEach(i->{
				i.setBno(vo.getQno());
				imageUploadMapper.regist(i);
			});
		}
		
	}

	@Override
	public void deleteQna(int qno) {
		replyMapper.deleteWithQna(qno);
		imageUploadMapper.deleteAll(qno);
		qnaMapper.deleteQna(qno);
	}



	@Override
	public List<QnaVO> getQnaListWithPage(Criteria cri) {
		List<QnaVO> qnaList= qnaMapper.getQnaListWithPage(cri);
		return qnaList;
	}

	@Override
	public int getTotalCount() {
		
		return qnaMapper.getTotalCount();
	}

	@Override
	public List<ImageVO> getImageList(int qno) {
		
		return imageUploadMapper.getImageList(qno);
	}




}
