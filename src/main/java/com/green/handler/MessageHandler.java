package com.green.handler;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.green.service.MessageService;
import com.green.vo.GetSessionUser;
import com.green.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageHandler extends TextWebSocketHandler{
	  @Autowired
	    MessageService messageService;
	
		// 로그인중인 개별유저
		Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
		
		
		// 클라이언트가 서버로 연결시
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
			Map<String, Object> sessionVal =  session.getAttributes();
			MemberVO vo = (MemberVO)sessionVal.get("info") !=null ? 
								(MemberVO)sessionVal.get("info"): GetSessionUser.getUser();
			
			String senderId = vo.getUser_id(); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
			System.out.println("senderId: " + senderId);
			//몇개의 매시지 왔는지						
			session.sendMessage(new TextMessage("recMs :"+messageService.countMsg(senderId)));
			if(senderId!=null) {	// 로그인 값이 있는 경우만
				log.info(senderId + " 연결 됨");
				users.put(senderId, session);   // 로그인중 개별유저 저장
				System.out.println("users: " + users);
			}
		}
		// 클라이언트가 Data 전송 시
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			System.out.println("handleTextmessage: " + session + " : " + message);
			
			// 특정 유저에게 보내기			
			String msg = message.getPayload();
			if(msg != null) {
				String[] strs = msg.split(",");
				log(strs.toString());
				if(strs != null && strs.length == 3) {
					String send_name = strs[0]; 					
					String receiver_id = strs[1];
					String ms_content = strs[2];
		
					switch (strs[2]) {
					case "친구 요청":
					    ms_content="님으로부터 "+strs[2]+"이 들어왔습니다 "
					    	+"<button class='btn btn-outline-secondary float-right' id='msgRequestFriend'>바로가기</button>";
						break;
					case "친구 수락":
						ms_content="님께서 "+strs[2]+"하셨습니다 "
						    +"<button class='btn btn-outline-secondary float-right' id='msgMyFriend'>친구목록</button>";
						break;
					default :
						break;
					}
					
					WebSocketSession targetSession = users.get(receiver_id);  // 메시지를 받을 세션 조회
					System.out.println("targetSession : " + targetSession);
					// 실시간 접속시
					if(targetSession!=null) {
						targetSession.sendMessage(new TextMessage("recMs :"+messageService.countMsg(receiver_id)));
						// ex: [send_name] 신청이 들어왔습니다.
						TextMessage tmpMsg = new TextMessage("["+send_name+"]"+ " "+ ms_content );	
						System.out.println("tmpMsg" + tmpMsg);
						targetSession.sendMessage(tmpMsg);						
					}
				}else if (strs!=null && strs.length == 4) {
					String send_name = strs[0]; 					
					String receiver_id = strs[1];
					String ms_content = strs[2];	
					int bno_short =  Integer.parseInt(strs[3]);
					
					ms_content="게시물에 댓글이 등록되었습니다 " 
							+" <a id='bno_short' href='/board/details?bno="+bno_short+"'>바로가기</a>";
					WebSocketSession targetSession = users.get(receiver_id);  // 메시지를 받을 세션 조회
					System.out.println("targetSession : " + targetSession);
					// 실시간 접속시
					if(targetSession!=null) {
						// ex: [send_name] 게시물에 댓글이 등록되었습니다.
						TextMessage tmpMsg = new TextMessage("["+send_name+"]"+ " : "+ ms_content );	
						System.out.println("tmpMsg" + tmpMsg);
						targetSession.sendMessage(tmpMsg);
					}
			} //else if(게시판)문 end
				else if (strs!=null && strs.length == 5) {
					String send_name = strs[0]; 					
					String receiver_id = strs[1];
					String ms_content = strs[2];	
					int qno_short =  Integer.parseInt(strs[3]);
					
					ms_content="게시물에 댓글이 등록되었습니다 " 
							+" <a id='qno_short' href='/qna/details?qno="+qno_short+"'>바로가기</a>";
					WebSocketSession targetSession = users.get(receiver_id);  // 메시지를 받을 세션 조회
					System.out.println("targetSession : " + targetSession);
					// 실시간 접속시
					if(targetSession!=null) {
						// ex: [name]게시물에 댓글이 등록되었습니다.
						TextMessage tmpMsg = new TextMessage("["+send_name+"]"+ " : "+ ms_content );	
						System.out.println("tmpMsg" + tmpMsg);
						targetSession.sendMessage(tmpMsg);
					}
				}
			}
		}
		// 연결 해제될 때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			Map<String, Object> sessionVal =  session.getAttributes();
			MemberVO vo = (MemberVO)sessionVal.get("info");
			String senderId = vo.getUser_name(); // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
			if(senderId!=null) {	// 로그인 값이 있는 경우만
				log(senderId + " 연결 종료됨");
				users.remove(senderId);
			}
		}
		// 에러 발생시
		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			log(session.getId() + " 익셉션 발생: " + exception.getMessage());

		}
		// 로그 메시지
		private void log(String logmsg) {
			System.out.println(new Date() + " : " + logmsg);
		}
	}