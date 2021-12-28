package com.green.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.mapper.RecommendedMapper;
import com.green.vo.RecommendedVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class RecommendedServiceImpl implements RecommendedService{

	@Setter(onMethod_=@Autowired)
	RecommendedMapper mapper;
	
	@Override
	public void registRecommended(RecommendedVO vo) {
		mapper.registRecommended(vo);
	}

	@Override
	public void updateRecommended(RecommendedVO vo) {
		mapper.updateRecommended(vo);
	}

	@Override
	public List<RecommendedVO> getRecommendList(int bno) {
		return mapper.getRecommendList(bno);
	}

	@Override
	public RecommendedVO getRecommended(RecommendedVO vo) {
		return mapper.getRecommended(vo);
	}

	@Override
	public int getTotalLike(int bno) {
		return mapper.getTotalLike(bno);
	}

	@Override
	public int getTotalHate(int bno) {
		return mapper.getTotalHate(bno);
	}

	@Override
	public void deleteRecommended(RecommendedVO vo) {
		mapper.deleteRecommended(vo);	
	}

}
