<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>BigTree 카카오 간편가입</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/register.css" />
	<link href="https://fonts.googleapis.com/css?family=Passion+One" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script type="text/javascript">
	  function rand() {
		    var code = Math.floor(Math.random()*(10000-1000)+1000)
		    $('#captcha').val(code)
		    $('#code').attr('value', 'Y')
		    return code
	    }
      function login() {
        var p1 = document.getElementById('user_pwd').value
        var p2 = document.getElementById('password2').value
        var birthYear = document.getElementById('birthYear').value
        var birthMonth = document.getElementById('birthMonth').value
        var birthDay = document.getElementById('birthDay').value
        var birth = birthYear + ' ' + birthMonth + ' ' + birthDay
        console.log(birth)
        document.getElementById('user_birth').value = birth
        var phone = phone1.value + '-' + phone2.value + '-' + phone3.value
        document.getElementById('user_phone').value = phone
        console.log(phone)
        var pwdCheck = RegExp(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/);
        if (!pwdCheck.test($('#user_pwd').val())) {
          alert('비밀번호는 영어, 숫자, 특수문자를 하나 이상 포함하여 8~16자로 작성해주세요')
          return false
        }
        if (p1 != p2) {
          alert('두 비밀번호가 일치하지 않습니다.')
          return false
        }
        if ($('#idChk').val() == 'N') {
          alert('아이디를 확인해주세요')
          return false
        }
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
          alert('회원가입이 완료되었습니다')
          document.register.submit()
        }
      }
      //아이디 중복 체크
      function fn_idChk() {
    	  
        var phone = phone1.value + phone2.value + phone1.value
        var text = $('#user_id').val()
        var idCheck = RegExp(/^[0-9a-z]{4,12}$/);
        console.log(text.length+"4")
        console.log(text)
        for (var i = 0; i < text.length+1; i++) {
          if (!idCheck.test($('#user_id').val())) {
            alert('4~12자 한글이나 특수문자 입력이 불가합니다')
            $('#user_id').val('')
            return
          }
          if (text == "" || text.length < 4) {
            alert('ID는 4자 이상 입력해주세요')
            $('#user_id').val('')
            return
          }
        }
        $.ajax({
          url: '/member/idChk',
          type: 'post',
          dataType: 'json',
          data: { user_id: $('#user_id').val() },
          success: function (data) {
            if (data == 1) {
              alert('중복된 아이디입니다.')
              $('#user_id').val('')
            } else if (data == 0) {
              $('#idChk').attr('value', 'Y')
              $('#user_id').attr('readonly', 'true')
              alert('사용 가능한 아이디입니다')
              console.log($('#user_id').val())
            }
          },
        })
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
            <h1 class="title">BIG TREE sign up</h1>
            <hr />
          </div>
        </div>
     <div class="main-login main-center">
      <form class="form-horizontal" method="post" name="register" action="register" >
        <div class="form-group">
          <label class="control-label col-sm-3">이름 <span class="text-danger">*</span></label>
          <div class="col-md-4 col-sm-8">
            <input type="text" class="form-control" name="user_name" id="user_name" value="${name}" readonly="readonly">
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-3"> I D <span class="text-danger">*</span></label>
         	 <div class="col-md-5 col-sm-8">
              	<div class="input-group" >
              		<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
              		<input type="text" class="form-control" name="user_id" id="user_id" placeholder="아이디를 입력해주세요 (4~12자)"  style="display:inline">    	         	
            	</div>
            	<button class="btn btn-info btn-xs" type="button" id="idChk" onclick="fn_idChk()" value="N" style="display:inline">ID중복확인</button> 
			</div>		
        </div>
        
        <div class="form-group">
          <label class="control-label col-sm-3">비밀번호 <span class="text-danger">*</span></label>
          <div class="col-md-5 col-sm-8">
            <div class="input-group">
              <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
              <input type="password" class="form-control" name="user_pwd" id="user_pwd" placeholder="8~16자 영어,숫자,특수문자 포함" >
           </div>   
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-3">비밀번호 확인 <span class="text-danger">*</span></label>
          <div class="col-md-5 col-sm-8">
            <div class="input-group">
              <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
              <input type="password" class="form-control" name="password2" id="password2" placeholder="동일한 비밀번호를 입력해주세요" >
            </div>  
          </div>
        </div>
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
        	<input type="hidden" id="user_kakao" name="user_kakao" value="${id}" />
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
          	<input type="button" class="btn btn-primary" onclick="login()" value="회원가입" />
          	<a class="btn btn-danger" href="/member/login">돌아가기</a>
          </div>
        </div>
      </form>
      </div>
    </div>
    </div>
  </body>
</html>
