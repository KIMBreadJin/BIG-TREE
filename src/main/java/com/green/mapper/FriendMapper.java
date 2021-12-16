package com.green.mapper;

import java.util.List;

import com.green.vo.FriendVO;
import com.green.vo.MemberVO;

public interface FriendMapper {
	public List<MemberVO> getMemberList(String user_name); //유저찾기했을때 나오는 유저
	public void regist(FriendVO vo);//친구추가 신청
	public void delete(FriendVO vo);//친구 거절 or 삭제
	public FriendVO getFriendVO(FriendVO vo);//친구추가 되있거나 수락대기중일때 사용하기
	public List<FriendVO> getFriendRecieved(FriendVO vo);//받은요청
	public List<FriendVO> getFriendSent(FriendVO vo);//보낸요청
	public void update(FriendVO vo);//친구 차단or수락
	
	public List<FriendVO> getMyFriend(String user_id);//친구목록보기
	public List<FriendVO> getBlockList(String user_id);
}
