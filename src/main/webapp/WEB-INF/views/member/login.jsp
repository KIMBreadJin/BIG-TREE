<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/main.css" />

    <!-- Website Font style -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css" />

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Passion+One" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css" />

    <title>BIGTREE</title>
    <script>
      $(document).ready(function () {
        $('#loginBtn').click(function () {
          console.log('클릭')
          var id = $('#inputId').val()
          var pw = $('#inputPwd').val()
          var remember_id = $('#remember_id').is(':checked')
          $.ajax({
            type: 'post',
            url: 'login',
            data: {
              user_id: id,
              user_pwd: pw,
              remember_userID: remember_id,
            },
            success: function (data) {
              if (data == 0) {
                //로그인 실패시
                console.log(data)
                $('#spanLoginCheck').text(' 아이디 혹은 비밀번호가 틀렸습니다.')
              } else {
                //로그인 성공시
                console.log(data)
                location.href = '/board/list'
              }
            },
          })
        })
      })
    </script>
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
          <c:if test="${not empty cookie.user_check}">
            <c:set value="checked" var="checked" />
          </c:if>
          <form class="form-horizontal" method="post" action="#">
            <div class="form-group">
              <label for="inputId" class="cols-sm-2 control-label">User ID</label>
              <div class="cols-sm-10">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                  <input type="text" class="form-control" name="inputId" id="inputId" placeholder="Enter your ID" />
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="password" class="cols-sm-2 control-label">Password</label>
              <div class="cols-sm-10">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                  <input
                    type="password"
                    class="form-control"
                    name="inputPwd"
                    id="inputPwd"
                    placeholder="Enter your Password"
                    onkeypress="if(event.keyCode == 13){ $('#loginBtn').click(); }"
                  />
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="cols-sm-2 control-label"></label>
              <span id="spanLoginCheck"></span>
            </div>
            <div class="form-group">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="remember_id" name="remember_userID" ${checked} />
                <label class="custom-control-label" for="remember_id">Remember me</label>
              </div>
              <button id="loginBtn" type="button" class="btn btn-primary btn-lg btn-block login-button" style="width: 280px">
                Sign in
              </button>
            </div>
            <div class="form-group" id="kakaologin">
              <input type="hidden" name="kakaoemail" id="kakaoemail" />
              <input type="hidden" name="kakaoname" id="kakaoname" />
              <input type="hidden" name="kakaobirth" id="kakaobirth" />
              <a
                href="https://kauth.kakao.com/oauth/authorize?client_id=8d1b9885c6894cd6e125aaad761bdfc7&redirect_uri=http://localhost:8080/member/login&response_type=code"
              >
                <img src="../resources/images/kakao_login_medium_wide.png" style="width: 280px" />
              </a>
            </div>
            <div class="login-register">
              회원이 아니십니까? <a href="/member/register"> sign up</a><br />
              forget your <a href="/member/findId">ID</a> or <a href="/member/findPwd">password</a>?
            </div>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
