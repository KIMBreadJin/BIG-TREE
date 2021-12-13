package com.green.vo;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class GetSessionUser {
	public static MemberVO getUser() {
		ServletRequestAttributes servletRequestAttributes=(ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		
		HttpSession httpSession = servletRequestAttributes.getRequest().getSession(true);
		return (MemberVO)httpSession.getAttribute("info");
	}
}
