<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
    <head> 
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

		<link rel="stylesheet" type="text/css" href="/resources/css/main.css">

		<!-- Website Font style -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		
		<!-- Fonts -->
		<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>

		<title>BIGTREE</title>
	</head>
	<body>
		<div class="container">
			<div class="row main">
				<div class="panel-heading">
	               <div class="panel-title text-center">
	               		<h1 class="title">BIG TREE</h1>
	               		<hr />
	               	</div>
	            </div> 
				<div class="main-login main-center">
					<form class="form-horizontal" method="post" action="findPwd" name='findform'>
					
						<div class="form-group">
							<label for="userid" class="cols-sm-2 control-label">User ID</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-sign-in fa-lg" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="user_id" id="user_id"  placeholder="Enter your UserID"/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="username" class="cols-sm-2 control-label">User name</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="user_name" id="user_name"  placeholder="Enter your Username"/>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="Phone" class="cols-sm-2 control-label">Phone</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-phone fa-lg" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="user_phone" id="user_phone"  placeholder="Enter your Phone (' - '포함 작성)"/>
								</div>
							</div>
						</div>
						

						<div class="form-group ">
							<input type="submit" class="btn btn-primary btn-lg btn-block login-button" value="check"></input>
						</div>
					<c:if test="${check == 1}">
						<script>
							opener.document.findform.user_id.value = "";
							opener.document.findform.user_name.value = "";
							opener.document.findform.user_phone.value = "";
						</script>
						<label>일치하는 정보가 존재하지 않습니다.</label>
					</c:if>
					<c:if test="${check == 0 }">
						<div>
							<label>비밀번호를 변경해주세요.</label>
						</div>
						<div class="form-label-group">
							<input type="hidden" id="user_id" name="updateid" value="${updateid}">
						
							<input type="password" id="user_pwd" name="user_pwd" class="form-control"/>
							<label for="password">password</label>
						</div>
						
						<div class="form-label-group">
							<input type="password" id="confirmUser_pwd" name="confirmUser_pwd" class="form-control"/>
							<label for="confirmpassword">confirm password</label>
						</div>
						
						<div class="form-label-group">
								<input class="btn btn-lg btn-secondary btn-block text-uppercase"
									type="button" value="update password" onclick="updatePassword()">
						</div>
					</c:if>
					
					</form>
					<script type="text/javascript">
						function updatePassword(){
							if(document.findform.user_pwd.value==""){
								alert("비밀번호를 입력해주세요.");
								document.findform.user_pwd.focus();
							} else if(document.findform.user_pwd.value != document.findform.confirmUser_pwd.value){
								alert("비밀번호가 일치하지 않습니다.");
								document.findform.confirmUser_pwd.focus();
							} else if(document.findform.user_pwd.value.length <6 || document.findform.user_pwd.value.length > 12){
								alert('비밀번호는 6자리 이상 12자리 이상이어야 합니다.')
							}
							else {
								document.findform.action="update_password";
								alert("비밀번호가 변경 되었습니다.");
								document.findform.submit();
							}
						}
					</script>
				</div>
			</div>
		</div>
	</body>
</html>