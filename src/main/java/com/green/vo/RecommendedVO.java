package com.green.vo;

import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class RecommendedVO {
	public int bno;
	public String userName;
	public int likeCnt;
	public int hateCnt;
	
	
}
