package com.green.mapper;

import java.util.List;

import com.green.vo.ImageVO;

public interface ImageUploadMapper {
	public void regist(ImageVO vo);
	public void delete(String uuid);
	public List<ImageVO> getImageList(int bno);
	public void deleteAll(int bno);
	
	
}
