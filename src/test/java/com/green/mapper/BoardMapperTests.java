package com.green.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.green.vo.BoardVO;
import com.green.vo.Criteria;
import com.green.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_=@Autowired)
	BoardMapper boardMapper;
	
	@Setter(onMethod_=@Autowired)
	MemberMapper Mmapper;
	
	//@Test
	public void registTest() {
		for(int i=0; i<50;i++) {
			BoardVO vo = new BoardVO();
			vo.setTitle("제목..."+(i+1));
			vo.setContent("내용...."+(i+1));
			vo.setWriter("작성자....."+(i+1));
			boardMapper.registBoard(vo);
		}
	}
	//@Test
	public void getListTest() {
		boardMapper.getBoardList();
	}
	//@Test
	public void getBoardTest() {
		boardMapper.getBoard(3);
	}
	//@Test
	public void updateTest() {
		BoardVO vo = new BoardVO();
		vo.setBno(15);
		vo.setContent("수정된 내용");
		vo.setTitle("수정된 제목");
		boardMapper.updateBoard(vo);
	}
	
	//@Test
	public void deleteTest() {
		boardMapper.deleteBoard(50);
	}
	
	//@Test
	public void ListwithPageTest() {
		Criteria cri = new Criteria(1,10);
		cri.setKeyword("수정");
		boardMapper.getBoardListWithPage(cri);
	}
	//@Test
	public void getCount() {
		int cnt= boardMapper.getTotalCount();
		log.info("게시글의 총 갯수"+cnt);
	}
	//@Test
	public void infoTest() {
		MemberVO a = new MemberVO();
		a.setUser_id("testid");
		a.setUser_pwd("1234");
		Mmapper.info(a);
	}
	//@Test
	public void idChkTest() {
		MemberVO vo = new MemberVO();
		vo.setUser_id("test");
		Mmapper.idChk(vo);
	}
	@Test
	public void phoneCheck() {
		MemberVO vo = new MemberVO();
		vo.setUser_phone("010-1111-2222");
		Mmapper.phnChk(vo);
	}
}
