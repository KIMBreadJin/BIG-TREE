package com.green.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;// 시작 페이지
	private int endPage;// 끝 페이지
	private boolean prev,next;// 이전 다음 페이지가 있는가? 
	private int total; //총 데이터(레코드/행)의 갯수 
	private Criteria cri;// 페이지 넘버와 페이지당 갯수
	
	public PageDTO(Criteria cri ,int total) {
		this.cri=cri;
		this.total=total;
		
		this.endPage=(int)(Math.ceil(cri.getPageNum()/10.0))*10;
		this.startPage =this.endPage-9;
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		if(realEnd <this.endPage) this.endPage= realEnd;
		this.prev= this.startPage>1;
		this.next= this.endPage<realEnd;
	}
}
