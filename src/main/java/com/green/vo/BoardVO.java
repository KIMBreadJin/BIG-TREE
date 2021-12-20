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

public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updateDate;
	private int replyCnt;
	private int views;
	private int report;
	private String id;
	
	
	private ReplyVO reply;
	private List<ImageVO> imageList;
	private List<ReportVO> reportList;//해당게시글의 신고목록
	private ReportVO reportWithUser;//해당게시글의 해당사용자가 신고한 신고글
	
}
