	var socket  = null;
	$(document).ready(function(){
	    // 웹소켓 연결
	    sock = new SockJS('http://localhost:8080/message')
	    socket = sock;
		console.log(sock)
	    // 데이터를 전달 받았을때 
	    sock.onmessage = onMessage; // toast 생성

	function goSubmit(){
		var gsWin = window.open("","Message","width=600,height=410");
		var frm = document.sendMsgForm;
		frm.action = "/message/sendMsg";
		frm.target="Message";
		gsWin.focus();
		frm.submit();
	}
	$('#sendMsgBtn').click(function(){
		console.log("눌리나")
		goSubmit();
	})
	});
    function onMessage(evt){
        var data = evt.data;
        // toast
        let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
        toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
        toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
        toast += "<span aria-hidden='true'>&times;</span></button>";
        toast += "</div> <div class='toast-body'>" + data + "</div></div>";
        $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
        $(".toast").toast({"animation": true, "autohide": false});
        $('.toast').toast('show');
    };

