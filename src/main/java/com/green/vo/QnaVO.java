package com.green.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class QnaVO {
	private int qno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private String secret;
	private String id;
	
	private List<ImageVO> imageList;
	//qna게시판 댓글 추가할것
}
