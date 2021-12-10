package com.green.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper {
	public String cntMsgView(String userid);
}
