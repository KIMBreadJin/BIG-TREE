package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.FriendMapper;
import com.green.mapper.MemberMapper;
import com.green.vo.FriendVO;
import com.green.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FriendServiceImpl implements FriendService {
	
	@Setter(onMethod_=@Autowired)
	FriendMapper friendMapper;
	
	@Setter(onMethod_=@Autowired)
	MemberMapper memberMapper;

	@Override
	public List<MemberVO> getMemberList(String user_name) {
		return friendMapper.getMemberList(user_name);
	}

	@Override
	public void regist(FriendVO vo) {
		 if(friendMapper.getFriendVO(vo)!=null) {
			 return;
		 }
		 else {
			 friendMapper.regist(vo);
		}
		
	}

	@Override
	public void delete(FriendVO vo) {
		friendMapper.delete(vo);
	}

	@Override
	public FriendVO getFriendVO(FriendVO vo) {
		return friendMapper.getFriendVO(vo);
	}

	@Override
	public void update(FriendVO vo) {
		friendMapper.update(vo);
	}

	@Override
	public List<FriendVO> getFriendReceived(FriendVO vo) {
		return friendMapper.getFriendRecieved(vo);
	}

	@Override
	public List<FriendVO> getFriendSent(FriendVO vo) {
		return friendMapper.getFriendSent(vo);
	}

}
