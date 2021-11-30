package com.green.service;

import com.green.vo.MemberVO;

public interface MemberService {
	public int login(MemberVO vo); //로그인 하기
	public void signup(MemberVO vo);
	public MemberVO info(MemberVO vo);
	public MemberVO getMember(long user_num);
	
	public MemberVO findId(MemberVO vo); //아이디 찾기
	public MemberVO findPwd(MemberVO vo); //비밀번호 찾기
	public void updatePwd(MemberVO vo); // 비밀번호 변경
}
