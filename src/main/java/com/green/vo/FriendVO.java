package com.green.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class FriendVO {
	private int fno;
	private String send_id;
	private String receiver_id;
	private Date send_time;
	private int check_frd;
}
