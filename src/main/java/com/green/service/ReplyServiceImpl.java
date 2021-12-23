package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.MemberMapper;
import com.green.mapper.ReplyMapper;
import com.green.vo.Criteria;
import com.green.vo.ReplyPageDTO;
import com.green.vo.ReplyVO;

import lombok.Setter;
@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod_=@Autowired )
	ReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	MemberMapper memberMapper;
	
	@Override
	public int register(ReplyVO vo) {
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(int rno) {
		// TODO Auto-generated method stub
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int remove(int rno) {
		// TODO Auto-generated method stub
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		List<ReplyVO> replyList=mapper.getListWithPaging(cri, bno);
		
		for(ReplyVO reply : replyList) {
			String replyerId=reply.getReplyerId()!=null? reply.getReplyerId(): "";
			String image=memberMapper.getImage(replyerId) != null? 
						memberMapper.getImage(replyerId) :
						"<img src='/resources/images/basicProfileIcon.png'>";
			
			reply.setReplyerProfile(image);//replyer의 프로필이미지
		}
			
		return replyList;
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

}
