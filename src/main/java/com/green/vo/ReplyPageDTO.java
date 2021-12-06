package com.green.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter

public class ReplyPageDTO {

	//댓글목록을위한 DTO
	private int replyCnt;
	private List<ReplyVO> list;
}
