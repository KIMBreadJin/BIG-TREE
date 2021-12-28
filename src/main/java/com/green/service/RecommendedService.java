package com.green.service;

import java.util.List;

import com.green.vo.RecommendedVO;

public interface RecommendedService {
	public void registRecommended(RecommendedVO vo);
	public void updateRecommended(RecommendedVO vo);
	public void deleteRecommended(RecommendedVO vo);
	public List<RecommendedVO> getRecommendList(int bno);
	public RecommendedVO getRecommended(RecommendedVO vo);
 
	public int getTotalLike(int bno);
	public int getTotalHate(int bno);
}
