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
  </head>
  <script type="text/javascript">
	 window.history.forward();
	 function noBack(){window.history.forward();}
  </script>
  <body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<div class="container">
	<div class="row">
        <div class="panel-heading">
          <div class="panel-title text-center">
            <h1 class="title">BIG TREE read profile</h1>
            <hr />
          </div>
        </div>
     <div class="main-login main-center">
      <form class="form-horizontal" method="get" name="pfileFrm" id="pfileFrm">
        <div class="form-group">
          <label class="control-label col-sm-3">이름 </label>
          <div class="col-md-5 col-sm-8">
            <input type="text" class="form-control" value="${profile.user_name}" readonly="readonly" >
          </div>
        </div>      
        <div class="form-group">
          <label class="control-label col-sm-3"> I D </label>
         	 <div class="col-md-5 col-sm-8">
              	<div class="input-group" >
              		<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
              		<input type="text" class="form-control" value="${profile.user_id}" name="user_id" readonly="readonly"  style="display:inline">    	         	
            	</div>
			</div>		
        </div>
        <div class="form-group">
          <label class="control-label col-sm-3">E-MAIL </label>
          <div class="col-md-5 col-sm-8">
           <div class="input-group">
              <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
           	  <input type="email" class="form-control" value="${profile.user_email}"  readonly="readonly" />
            </div>  
          </div>
        </div>
        <div class="form-group">
        <label class="control-label col-sm-3">주소 </label>
          <div class="col-md-5 col-sm-8">
            <input type="text" class="form-control" value="${profile.user_address}" readonly="readonly" />
          </div>
        </div>
        
        <div class="form-group">
	        <label class="control-label col-sm-3">생년월일</label>
	        <div class="col-md-5 col-sm-8">
	          <input type="text" class="form-control" value="${profile.user_birth}" readonly="readonly" />
	        </div>
        </div>

        <div class="form-group">
          <label class="control-label col-sm-3">전화번호 </label>
          <div class="col-md-5 col-sm-8">   	   	
        	<input type="text" class="form-control" value="${profile.user_phone}" readonly="readonly" />
          </div>
        </div>
        <div class="form-group">
          <div class="col-xs-offset-3 col-xs-10">
          	<a class="btn btn-primary" href="/member/modify">회원정보 수정</a>
          	<a class="btn btn-danger" href="/board/list">돌아가기</a>
          </div>
          &nbsp;
          &nbsp;  
          <div class="col-xs-offset-3 col-xs-10">
          	<input type="hidden" name="user_num" id="user_num" value="${profile.user_num}" />
          	<button type="button" class="btn btn-warning" id="removeBtn" onClick="removeM()">회원 탈퇴하기</button>
          </div>
        </div>
      </form>
      </div>
    </div>
    </div>
  <script type="text/javascript">
  	function removeM() {
  		if(confirm("보내신 메시지와 회원정보가 삭제되고 복구가 불가능합니다\n탈퇴 하시겠습니까?")){ 			
	      var pfileFrm = $('#pfileFrm')
	      var url = '/member/deleteM'
	      console.log('remove click')
	      pfileFrm.attr('action', url).attr('method', 'post').submit()
  		}
    }
  </script>
  </body>
</html>
