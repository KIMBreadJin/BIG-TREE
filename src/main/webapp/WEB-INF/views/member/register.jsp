<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>BigTree 회원가입 페이지</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <style>
      h3 {
        text-indent: 3em;
      }
      #birthYear {
        width: 30%;
      }
      #birthMonth {
        width: 30%;
      }
      #birthDay {
        width: 30%;
      }
      #phone1 {
        width: 30%;
      }
      #phone2 {
        width: 30%;
      }
      #phone3 {
        width: 30%;
      }
      .form-control {
        display: initial !important;
      }
    </style>
    <script type="text/javascript">
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
        if (p1.length < 6 || p1.length > 12) {
          alert('비밀번호는 6자리 이상 12자리 이상이어야 합니다.')
          return false
        }
        if (p1 != p2) {
          alert('두 비밀번호가 일치하지 않습니다.')
          return false
        } if($('#idChk').val() == 'N'){
        	alert('아이디를 확인해주세요')
        	return false
        } if($('#phnChk').val() == 'N'){
        	alert('핸드폰 번호를 확인해주세요')
        	return false
        } else {
          alert('회원가입이 완료되었습니다')
          document.register.submit()
        }
      }
      //아이디 중복 체크
      function fn_idChk() {
    	  var phone = phone1.value+phone2.value+phone1.value
    	  var text =$("#user_id").val();
    	  var regexp = /[0-9a-z]/;
    	  for(var i=0; i<text.length; i++){
    		  if(text.charAt(i) != " " && regexp.test(text.charAt(i)) == false){
    			  alert("한글이나 특수문자 입력이 불가합니다");
    			  $('#user_id').val("");
    			  return;
    		  }
    		  if(text.length < 4){
    			  alert('ID는 4자 이상 입력해주세요');
    			  $('#user_id').val("");
    			  return;
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
            } else if (data == 0) {
              $('#idChk').attr('value', 'Y')
              $('#user_id').attr('readonly','true')
              alert('사용 가능한 아이디입니다')
            }
          },
        })
      }
      //폰 중복 체크
      function fn_phnChk() {
    	  var phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
    	  var phoneValue = phone1.value + '-' + phone2.value + '-' + phone3.value
    	  var text = phone
    	  for(var i=0; i<text.length; i++){
    		  if(text.length !== 11){
    			  alert('8자리의 핸트폰 번호를 입력해주세요');
    			  $('#phone2').val("");
    			  $('#phone3').val("");
    			  return;
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
              $('#phone1').attr('readonly','true')
              $('#phone2').attr('readonly','true')
              $('#phone3').attr('readonly','true')
              alert('인증 가능한 핸드폰 번호입니다')
            }
          },
        })
      }
    </script>
  </head>
  <body>
    <h3>BigTree 회원가입</h3>
    <form class="form-horizontal" name="register" action="register" method="post">
      <div class="form-group">
        <label class="col-sm-1 control-label">이름</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="user_name" name="user_name" placeholder="성명을 입력해주세요" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">아이디</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해주세요" />
         </div> 
         <button class="idChk" type="button" id="idChk" onclick="fn_idChk()" value="N">중복확인</button>
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">비밀번호</label>
        <div class="col-sm-3">
          <input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="6글자 이상 12글자 이하" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">비밀번호 확인</label>
        <div class="col-sm-3">
          <input type="password" class="form-control" id="password2" placeholder="동일한 비밀번호를 입력해주세요" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">주소</label>
        <div class="col-sm-3">
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
        <label class="col-sm-1 control-label">휴대폰</label>
        <div class="col-sm-3">
          <select id="phone1" class="form-control">
            <option value="010">010</option></select
          > - <input type="text" class="form-control" id="phone2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" /> -
          <input type="text" class="form-control" id="phone3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" />
        </div>
        <button class="phnChk" type="button" id="phnChk" onclick="fn_phnChk()" value="N">핸드폰 인증</button>
        <input type="hidden" id="user_phone" name="user_phone" />
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">이메일</label>
        <div class="col-sm-3">
          <input type="email" class="form-control" id="user_email" placeholder="이메일을 입력해주세요" name="user_email" />
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-1 control-label">생년월일</label>
        <div class="col-sm-3">
          <select id="birthYear" class="form-control">
            <c:forEach var="year" begin="1950" end="2021">
              <option>${year}년</option>
            </c:forEach>
          </select>
          <select id="birthMonth" class="form-control">
            <c:forEach var="month" begin="1" end="12">
              <option>${month}월</option>
            </c:forEach>
          </select>
          <select id="birthDay" class="form-control">
            <c:forEach var="day" begin="1" end="31">
              <option>${day}일</option>
            </c:forEach>
          </select>
          <input type="hidden" id="user_birth" name="user_birth" />
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-1 col-sm-3">
          <input type="button" class="btn btn-primary" onclick="login()" value="회원가입" />
          <a class="btn btn-danger" href="/member/login">돌아가기</a>
        </div>
      </div>
    </form>
  </body>
</html>
