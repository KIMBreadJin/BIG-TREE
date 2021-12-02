<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 로그인중..</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
		window.onload =function(){
			console.log("여기까진 잘되나")
			$.ajax({
		    	url: '/member/kakaoCheck',
		        type: 'post',
		        dataType: 'json',
		        data: { user_kakao: $('#user_kakao').val() },
		        success: function (data) {
		          if (data == 1) {
		          	console.log(data);
		          	location.href = "board/list"
		          } else if (data == 0) {
		          	location.href = "/member/kakaoReg"
		          }
		        },
		  	})
	}
</script>
</head>
<body>
	<h4>로그인 중..</h4>
</body>
</html>