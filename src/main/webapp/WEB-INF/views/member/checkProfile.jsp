<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>BigTree 회원정보 조회</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
	<link href="https://fonts.googleapis.com/css?family=Passion+One" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    	function check(){
    		var pwd=document.getElementById('user_pwd').value
    		if("${pwd}" != pwd){
    			alert("비밀번호를 잘못 입력하셨습니다..")
    			return false
    		}
    		else{
    			alert("회원정보 조회 페이지로 이동합니다.")
    			location.href = '/member/profile'
    		}
    	}
    </script>
</head>
<body>
	<div class="container">
	<div class="row">
        <div class="panel-heading">
          <div class="panel-title text-center">
            <h1 class="title">BIG TREE read profile</h1>
            <hr />
          </div>
		</div>
		<div class="main-login main-center">
			<form class="form-horizontal" method="get">
				<div class="form-group">
					<label class="control-label col-sm-3">비밀번호</label>
					<div class="col-md-5 col-sm-8">
						<div class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input type="password" class="form-control" name="user_pwd" id="user_pwd" placeholder="비밀번호를 입력해주세요" />
						</div>
					</div>
				</div>
				<div class="form-group">
          			<div class="col-xs-offset-3 col-xs-10">
          				<input type="button" class="btn btn-primary" onclick="check()" value="확인" />
          				<a class="btn btn-danger" href="javascript:history.back();">돌아가기</a>
         			 </div>
         		</div>
			</form>
		</div>
    </div>
	</div>
</body>
</html>