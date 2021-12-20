package com.green.service;

import java.util.List;

import com.green.vo.MessageVO;

public interface MessageService {
	public void sendMsg(MessageVO vo); // 쪽지 보내기
	public List<MessageVO> msgList(MessageVO vo); // 받은 쪽지 목록 
	public MessageVO readMsg(long mid); // 쪽지 읽기
	public void deleteMsg(long mid); // 쪽지 삭제
	
	public String countMsg(String receiver_id); //쪽지 개수
	
}
