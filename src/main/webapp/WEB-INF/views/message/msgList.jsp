<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %><%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8" />
  <head> </head>
  <body>
   	
    	<ul>
    	<c:forEach items="${mlist}" var="mlist">
    	<li>
    	${mlist.ms_content}
    	</li>
    	   </c:forEach>
    	</ul>>
 
  </body>
</html>
