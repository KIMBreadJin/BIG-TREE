package com.green.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.green.mapper.MessageMapper;
import com.green.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChattingHandler extends TextWebSocketHandler{
	
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	Map<String, List<String>> roomUsers = new HashMap<>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionEstablished");
		Map<String, Object> sessionVal =  session.getAttributes();
		MemberVO vo = (MemberVO)sessionVal.get("info");
		System.out.println(vo.getUser_name());
		String userId = vo.getUser_name();
		if(userSessions.get(userId) != null) {
			//userId에 원래 웹세션값이 저장되어 있다면 update
			userSessions.replace(userId, session);
		} else {
			//userId에 웹세션값이 없다면 put
			userSessions.put(userId, session);
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
System.out.println("handleTextmessage: " + session + " : " + message);
		
		//protocol: RoomNum, 보내는id, 내용 
		String msg = message.getPayload();
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 3) {
				String roomNum = strs[0];
				String sendId = strs[1];
				String content = strs[2];
				
				//입장일시 
				if(content.equals("ENTER")) {
					//해당 roomNum의 Map의 userId 리스트에 sendId를 넣어준다.
					System.out.println("ENTER안에 있음");
					
					if(roomUsers.get(roomNum) == null) {
						List<String> list = new ArrayList<>();
						roomUsers.put(roomNum, list);
					}
					
					roomUsers.get(roomNum).add(sendId);
					System.out.println(sendId + "가 들어왔습니다.");
					
					List<String> roomUserList = roomUsers.get(roomNum);
					for(int i = 0; i < roomUserList.size(); i++) {
						System.out.println(i + roomUserList.get(i) + " " + userSessions.get(roomUserList.get(i)));
					}
				} 
				//퇴장일시
				else if(content.equals("OUT")) {
					// room을 나갈시 Map의 userId 리스트에 sendId를 지운다.
					roomUsers.get(roomNum).remove(sendId);
					System.out.println("나갔습니다.");
					List<String> roomUserList = roomUsers.get(roomNum);
					for(int i = 0; i < roomUserList.size(); i++) {
						System.out.println(i + roomUserList.get(i) + " " + userSessions.get(roomUserList.get(i)));
					}
				}
				
				//해당 room의 userList를 가져옴
				List<String> roomUserList = roomUsers.get(roomNum);
				
				for(int i = 0; i < roomUserList.size(); i++) {
					//room의 userId의 session에 보내기
					userSessions.get(roomUserList.get(i)).sendMessage(new TextMessage(sendId + "," + content));
				}
			}
		}
	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionClosed");
		
		log.info(session.getId() + "님이 퇴장하셨습니다.");
	}
}
