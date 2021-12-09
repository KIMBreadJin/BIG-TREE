<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8" />
  <head>
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/findFrd.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <title>BIGTREE친구찾기</title>
  </head>
  <body>
    <div id="mycard">
    
      <!-- Header -->
      <div id="mycard--header">
        <h1 id="title">
          BIGTREE <span id="title--bold-part">친구찾기</span>
        </h1>
      </div>

      <!-- Body -->
      <form class="form-horizontal" method="post" action="findFrd" name='findform'>
      <div id="mycard--body">
        <div class="row pb-3">
          <div class="col-sm-12">    
              <div class="row">
                <div class="col-sm-8">
                  <input type="text" name="user_id" id="user_id" class="form-control" placeholder="찾으실 친구의 아이디를 입력해주세요.." />
                </div>
                <div id="user-select" class="col-sm-4">
                  <!-- Select -->
                </div>
              </div>
          </div>
        </div>

        <div class="row pt-3">
          <div class="col-sm-12">
            <button type="submit" class="btn btn-default mr-2" id="find-btn"><i class="fa fa-users"></i> 찾아보기</button>
          </div>
        </div>
      
		<c:if test="${checkid == 1}">
				<script>
					opener.document.findform.user_id.value = "";
				</script>
				<label> 입력하신 아이디의 정보가 존재하지 않습니다.</label>
		</c:if>
	
			<!-- 이름과 비밀번호가 일치하지 않을 때 -->
		<c:if test="${checkid == 0 }">
			<table id="feiendResult" class="table table-bordered table-hover">
				<tr>
					<th scope='row'> I D </th>
					<td> ${find.user_id} </td>
				</tr>	
				<tr>
					<th> N A M E</th>
					<td> ${find.user_name }</td>
					
				</tr>
			</table>
			
				<div class="form-label-group">
					<input class="btn btn-lg btn-secondary btn-block text-uppercase"
						type="button" value="친구추가" onclick="login()">
				</div>
				<div class="form-label-group">
					<input class="btn btn-block text-uppercase"
						type="button" value="메세지 보내기" onclick="resetPwd()">
				</div>
		</c:if>
		</div>
		</form>
    </div>
    
  </body>
</html>
