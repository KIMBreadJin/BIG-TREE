package com.green.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.green.vo.RecommendedVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTests {
	@Setter(onMethod_=@Autowired)
	RecommendedMapper mapper;
	
	
	//@Test
	public void registTest() {
		for(int i=0; i<50;i++) {
			RecommendedVO vo = new RecommendedVO();
			vo.setBno(49);
			vo.setUser_id("이재욱"+i);
			vo.setLiked(i);
			vo.setHated(i);
			mapper.registRecommended(vo);
		}
	}
	//@Test
	public void getListTest() {
		mapper.getRecommendList(49);
		
	}
	@Test
	public void getRecommended() {
		RecommendedVO vo = new RecommendedVO();
		vo.setUser_id("이재욱0");
		vo.setBno(49);
		mapper.getRecommended(vo);
	}
}
