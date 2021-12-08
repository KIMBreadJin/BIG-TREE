package com.green.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class TestVO {
	private int amount;
	private int pageNum;
	
	public TestVO() {
		this.amount=20;
		this.pageNum=1;
	}
	public TestVO(int amount,int pageNum) {
		this.amount=amount;
		this.pageNum=pageNum;
	}
	
}
