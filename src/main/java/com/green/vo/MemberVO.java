package com.green.vo;

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
public class MemberVO {
	private long user_num;
	private String user_name;
	private String user_id;
	private String user_pwd;
	private String user_address;
	private String user_phone;
	private String user_email;
	private String user_birth;
	private String user_kakao;
	private String user_nickName;
	private int user_type;
	private String user_profileImage;
	
	
	
	private int boardCnt;//오라클 연동x 게시글수 저장용
}