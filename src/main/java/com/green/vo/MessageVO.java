package com.green.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MessageVO {
	private long mid;
	private String user_id;
	private String ms_content;
	private String receiver_name;
	private String receiver_id;
	private String send_name;
	private String creat_dt;
	private String ms_type;  // 수신 발신 구분
	private String read_yn; // 읽음 안읽음 구분
	private String sender_Image; //수신자 프로필 이미지
}

