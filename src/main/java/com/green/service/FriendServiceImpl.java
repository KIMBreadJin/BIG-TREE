package com.green.service;

import java.util.ArrayList;
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

	@Override
	public List<MemberVO> getMyFriend(String user_id) {//jo8419
		List<MemberVO> memberList= new ArrayList<>();
		List<FriendVO> friendList = friendMapper.getMyFriend(user_id);
		for(FriendVO friend: friendList) {
			log.info(""+friend);
			MemberVO vo = new MemberVO();

			String getUserId=friend.getSend_id();//send_id,
			vo.setUser_id(getUserId.equals(user_id) ? friend.getReceiver_id() : getUserId);
			memberList.add(memberMapper.findFrd(vo));
		}
		
		return memberList;
	}

	@Override
	public List<MemberVO> getBlockList(String user_id) {
		List<MemberVO> memberList= new ArrayList<>();
		List<FriendVO> friendList = friendMapper.getBlockList(user_id);
		for(FriendVO friend: friendList) {
			MemberVO vo = new MemberVO();
			String getUserId=friend.getSend_id();
			vo.setUser_id(getUserId.equals(user_id) ? friend.getReceiver_id() : getUserId);
			memberList.add(memberMapper.findFrd(vo));
		}
		return memberList;
	}

}
