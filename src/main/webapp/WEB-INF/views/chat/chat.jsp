<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>chat</title>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	<div class="container">
		<div class="col-6">
			<label><b>채팅방</b></label>
		</div>
		<div>
			<div id="msgArea" class="col">
			
			</div>
			<div class="col-6">
			<div class="input-group mb-3">
				<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
					<button class="btn btn-outline-danger" type="button" id="button-exit">나가기</button>
				</div>
			</div>
			</div>
		</div>
		<div class="col-6">
		</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script type="text/javascript">

	//전송 버튼 누르는 이벤트
	$("#button-send").on("click", function(e) {
		sendMessage();
		$('#msg').val('')
	});

	var sock = new SockJS("http://localhost:8080/chat");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	$("#button-exit").on("click",function(e){
		console.log("나가기")
		sock.close();
		//location.href = '/board/list'
	})
	function sendMessage() {
		sock.send($("#msg").val());
	}
	
	//서버에서 메시지를 받았을 때
	function onMessage(msg) {
		
		var data = msg.data;
		var sessionId = null; //데이터를 보낸 사람
		var message = null;
		
		var arr = data.split(":");
		
		for(var i=0; i<arr.length; i++){
			console.log('arr[' + i + ']: ' + arr[i]);
		}
		
		var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
		console.log("cur_session : " + cur_session);
		
		sessionId = arr[0];
		message = arr[1];
		
	    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		if(sessionId == cur_session){
			
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-secondary'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
		}
		else{
			
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-warning'>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
		}
		
	}
	//채팅창에서 나갔을 때
	function onClose(evt) {
		
		var user = '${userid}';
		var str = user + " 님이 퇴장하셨습니다.";
		
		$("#msgArea").append(str);
	}
	//채팅창에 들어왔을 때
	function onOpen(evt) {
		
		var user = '${userid}';
		var str = user + "님이 입장하셨습니다.";
		
		$("#msgArea").append(str);
	}
	
	</script>
</body>
</html>
