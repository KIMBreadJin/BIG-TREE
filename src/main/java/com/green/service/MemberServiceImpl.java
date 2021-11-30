package com.green.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.MemberMapper;
import com.green.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Override
	public int login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public void signup(MemberVO vo) {
		log.info("회원가입");
		mapper.signup(vo);
	}
	
	@Override
	public MemberVO info(MemberVO vo) {
		return mapper.info(vo);
	}
	@Override
	public MemberVO getMember(long user_num) {
		return mapper.getMember(user_num);
	}
	
	@Override
	public MemberVO findId(MemberVO vo) {
		log.info("아이디 찾기");
		return mapper.findId(vo);
	}
	
	@Override
	public MemberVO findPwd(MemberVO vo) {
		log.info("비밀번호 찾기");
		return mapper.findPwd(vo);
	}
	@Override
	public void updatePwd(MemberVO vo) {
		log.info("비밀번호 변경");
		mapper.updatePwd(vo);
	}
}
