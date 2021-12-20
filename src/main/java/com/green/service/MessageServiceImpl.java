package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.MemberMapper;
import com.green.mapper.MessageMapper;
import com.green.vo.MemberVO;
import com.green.vo.MessageVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MessageServiceImpl implements MessageService{
	
	@Setter(onMethod_=@Autowired)
	private MessageMapper mapper;

	@Override
	public void sendMsg(MessageVO vo) {
		mapper.sendMsg(vo);
		
	}

	@Override
	public MessageVO readMsg(long mid) {
		return mapper.readMsg(mid);
	}


	@Override
	public List<MessageVO> msgList(MessageVO vo) {	
		return mapper.msgList(vo);
	}

	@Override
	public String countMsg(String receiver_id) {
		return mapper.countMsg(receiver_id);
	}

	@Override
	public void deleteMsg(long mid) {
		mapper.deleteMsg(mid);
	}
		
}
