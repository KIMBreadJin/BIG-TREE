package com.green.service;

import java.util.List;

import com.green.vo.FriendVO;
import com.green.vo.MemberVO;

public interface FriendService {
	public List<MemberVO> getMemberList(String user_name); //유저찾기했을때 나오는 유저
	public void regist(FriendVO vo);//친구추가 신청
	public void delete(FriendVO vo);//친구 삭제
	public FriendVO getFriendVO(FriendVO vo);//친구추가 수락대기중이거나 친구일때
	public List<FriendVO> getFriendReceived(FriendVO vo);//요청받은 목록
	public List<FriendVO> getFriendSent(FriendVO vo);//요청보낸 목록
	
	public void update(FriendVO vo);//친구거절 or 차단
	
	public List<MemberVO> getMyFriend(String user_id);
	public List<MemberVO> getBlockList(String user_id);
}
