<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>BigTree 비밀번호 변경</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
	<link href="https://fonts.googleapis.com/css?family=Passion+One" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    	function check(){
    		var pwd=document.getElementById('user_pwd').value
    		var p1=document.getElementById('password').value
    		var p2=document.getElementById('password2').value
    		var pwdCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/);
    		if(p1 != p2){
    			alert("두 비밀번호가 일치하지 않습니다.")
    			return false
    		}
    		else if("${pwd}" != pwd){
    			alert("비밀번호를 잘못 입력하셨습니다..")
    			return false
    		}
    		else if(!pwdCheck.test(p1)) {
    	          alert('비밀번호는 영어, 숫자, 특수문자를 하나 이상 포함하여 8~16자로 작성해주세요')
    	          return false
    	        }
    		else{
    			alert("비밀번호가 변경되었습니다.")
    			document.updatePwd.submit()
    		}
    	}
    </script>
</head>
<body>
	<div class="container">
	<div class="row">
        <div class="panel-heading">
          <div class="panel-title text-center">
            <h1 class="title">BIG TREE change password</h1>
            <hr />
          </div>
		</div>
		<div class="main-login main-center">
			<form class="form-horizontal" method="post" id="updatePwd" name="updatePwd">
				<div class="form-group">
					<label class="control-label col-sm-3">비밀번호</label>
					<div class="col-md-5 col-sm-8">
						<div class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input type="password" class="form-control" name="user_pwd" id="user_pwd" placeholder="현재 비밀번호를 입력해주세요" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3">새 비밀번호</label>
					<div class="col-md-5 col-sm-8">
						<div class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input type="password" class="form-control" name="password" id="password" placeholder="새로운 비밀번호를 입력해주세요" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3">비밀번호 확인</label>
					<div class="col-md-5 col-sm-8">
						<div class="input-group">
							<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
							<input type="password" class="form-control" name="password2" id="password2" placeholder="동일한 비밀번호를 입력해주세요" />
						</div>
					</div>
				</div>
				<div class="form-group">
          			<div class="col-xs-offset-3 col-xs-10">
          				<input type="button" class="btn btn-primary" onclick="check()" value="변경" />
          				<a class="btn btn-danger" href="javascript:history.back();">돌아가기</a>
         			 </div>
         		</div>
			</form>
		</div>
    </div>
	</div>
</body>
</html>