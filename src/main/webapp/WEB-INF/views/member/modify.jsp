<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>BigTree 회원정보 수정 페이지</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
	<link href="https://fonts.googleapis.com/css?family=Passion+One" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
	  function rand() {
		    var code = Math.floor(Math.random()*(10000-1000)+1000)
		    $('#captcha').val(code)
		    $('#code').attr('value', 'Y')
		    return code
	    }
      function modifyProfile() {
        var birthYear = document.getElementById('birthYear').value
        var birthMonth = document.getElementById('birthMonth').value
        var birthDay = document.getElementById('birthDay').value
        var birth = birthYear + ' ' + birthMonth + ' ' + birthDay
        console.log(birth)
        document.getElementById('user_birth').value = birth
        var phone = phone1.value + '-' + phone2.value + '-' + phone3.value
        document.getElementById('user_phone').value = phone
        console.log(phone)
        if ($('#phnChk').val() == 'N') {
          alert('핸드폰 번호를 확인해주세요')
          return false
        }
        if ($('#code').val() == 'N') {
            alert('보안코드를 확인해주세요')
            return false
         }
        if($('#captcha').val() != $('#scode').val()){
          alert('보안코드가 틀렸습니다')
          return false
        }
        else {
          alert('회원정보 수정이 완료되었습니다.')
          document.modify.submit()
        }
      }
      //폰 중복 체크
      function fn_phnChk() {
        var phone = $('#phone1').val() + $('#phone2').val() + $('#phone3').val()
        var phoneValue = phone1.value + '-' + phone2.value + '-' + phone3.value
        var text = phone
        for (var i = 0; i < text.length; i++) {
          if (text.length !== 11) {
            alert('8자리의 핸트폰 번호를 입력해주세요')
            $('#phone2').val('')
            $('#phone3').val('')
            return
          }
        }
        $.ajax({
          url: '/member/phnChk',
          type: 'post',
          dataType: 'json',
          data: { user_phone: phoneValue },
          success: function (data) {
            if (data == 1) {
              alert('중복된 핸드폰 번호입니다')
            } else if (data == 0) {
              $('#phnChk').attr('value', 'Y')
              $('#phone1').attr('readonly', 'true')
              $('#phone2').attr('readonly', 'true')
              $('#phone3').attr('readonly', 'true')
              alert('인증 되었습니다')
            }
          },
        })
      }
    </script>
  </head>
  <body>
<div class="container">
	<div class="row">
        <div class="panel-heading">
          <div class="panel-title text-center">
            <h1 class="title">BIG TREE modify profile</h1>
            <hr />
          </div>
        </div>
     <div class="main-login main-center">
      <form class="form-horizontal" method="post" name="modify" id="modify" >
        <div class="form-group">
          <label class="control-label col-sm-3">E-MAIL </label>
          <div class="col-md-8 col-sm-9">
           <div class="input-group">
              <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
           	  <input type="email" class="form-control" id="user_email" placeholder="이메일을 입력해주세요" name="user_email" />
            </div>  
          </div>
        </div>
        <div class="form-group">
        <label class="control-label col-sm-3">주소 </label>
          <div class="col-md-5 col-sm-8">
            <select name="user_address" class="form-control" id="user_address">
	            <option value="">지역을 선택해주세요</option>
	            <option value="서울">서울</option>
	            <option value="경기">경기</option>
	            <option value="강원">강원</option>
	            <option value="인천">인천</option>
	            <option value="부산">부산</option>
	            <option value="대구">대구</option>
	            <option value="대전">대전</option>
	            <option value="광주">광주</option>
	            <option value="울산">울산</option>
	            <option value="전남">전남</option>
	            <option value="전북">전북</option>
	            <option value="충남">충남</option>
	            <option value="충북">충북</option>
	            <option value="경남">경남</option>
	            <option value="경북">경북</option>
	            <option value="제주">제주</option>
         	 </select>
          </div>
        </div>
        
        <div class="form-group">
	        <label class="control-label col-sm-3">생년월일</label>
	        <div class="col-xs-8">
	          <div class="form-inline">
	          <select id="birthYear" class="form-control">
	          	<option value="">출생년도</option>
	            <c:forEach var="year" begin="1950" end="2021">	              
	              <option>${year}년</option>
	            </c:forEach>
	          </select>
	          <select id="birthMonth" class="form-control">
	          	<option value="">월</option>
	            <c:forEach var="month" begin="1" end="12">
	              <option>${month}월</option>
	            </c:forEach>
	          </select>
	          <select id="birthDay" class="form-control">
	         	<option value="">일</option>
	            <c:forEach var="day" begin="1" end="31">
	              <option>${day}일</option>
	            </c:forEach>
	          </select>
	           </div>
	          <input type="hidden" id="user_birth" name="user_birth" />
	        </div>
        </div>

        <div class="form-group">
          <label class="control-label col-sm-3">전화번호 <span class="text-danger">*</span></label>
          <div class="col-xs-8">
          		<div class="form-inline">
          			<div class="input-group">
          				<span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
	           	 		<select id="phone1" class="form-control">
	          	 			<option value="010">010</option>
	          	 		</select>
	          	 	</div>
	        	 	 - <input type="text" class="form-control" id="phone2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" size = 4/> -
	        	 	   <input type="text" class="form-control" id="phone3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" size = 4/>       
	        	 <button class="btn btn-info btn-sm" type="button" id="phnChk" onclick="fn_phnChk()" value="N"> 인증 </button>   
	        	 </div>     	   	
        	<input type="hidden" id="user_phone" name="user_phone" />
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-3">Security Code <span class="text-danger">*</span></label>
          <div class="col-md-5 col-sm-8">
            <div>            
                <input type="text" name="captcha" id="captcha" class="form-control label-warning"  value = "" />
                <input type="text" class="form-control" name="scode" id="scode" placeholder="위 보안코드를 작성하시오" value="">
                <button class="btn" type="button" id="code" onclick="rand()" value="N">보안코드 생성</button>                
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="col-xs-offset-3 col-md-8 col-sm-9"><span class="text-muted"><span class="label label-danger">Note:-</span> ' <span class="text-danger">*</span> '표는 필수 입력란 입니다.</span> </div>
        </div>
        <div class="form-group">
          <div class="col-xs-offset-3 col-xs-10">
          	<input type="button" class="btn btn-primary" onclick="modifyProfile()" value="수정" />
          	<a class="btn btn-danger" href="javascript:history.back();">돌아가기</a>
          </div>
        </div>
      </form>
      </div>
    </div>
    </div>
  </body>
</html>
