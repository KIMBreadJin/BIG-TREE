package com.green.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReportVO {
	private int bno;
	private String reason;
	private String details;
	private String reporter_id;
	private Date reportDate;

}
