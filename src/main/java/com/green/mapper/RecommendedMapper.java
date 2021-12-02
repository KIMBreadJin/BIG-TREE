package com.green.mapper;

import java.util.List;

import com.green.vo.RecommendedVO;

public interface RecommendedMapper {
	public void registRecommended(RecommendedVO vo);
	public void updateRecommended(RecommendedVO vo);
	public List<RecommendedVO> getRecommendList(int bno);
	public RecommendedVO getRecommended(RecommendedVO vo);
	
	public int getTotalLike(int bno);
	public int getTotalHate(int bno);
}
