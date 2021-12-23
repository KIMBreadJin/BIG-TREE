package com.green.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class QnaReplyVO {

	private int rno;
	private int qno;
	private String reply;
	private String replyer;
	private Date ReplyDate;
	private Date updateDate;
	private String replyerId;//


	private String replyerProfile;//오라클 연동x
}
