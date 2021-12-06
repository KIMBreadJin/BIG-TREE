<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ page import="java.util.Date" %> <%@ page import="java.text.SimpleDateFormat" %> <% Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("E요일, yyyy년 MM월 dd일"); %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" />
    <link rel="stylesheet" type="text/css" href="/resources/css/room.css?after" />
    <title>채팅방2</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script type="text/javascript">
      var sock = new SockJS('http://localhost:8080/chat')
      sock.onmessage = onMessage
      sock.onclose = onClose
      sock.onopen = onOpen
      sock.onerror = onError

      //웹소켓 연결
      function onOpen(event) {
        console.log('Info: connection opened.')
        sock.send('1' + ',' + '${userid}' + ',' + 'ENTER')
      }

      //웹소켓에서 메세지 받기
      function onMessage(event) {
        var sm = event.data
        //sl에는 아이디, enter,out 여부입력
        var sl = sm.split(',')
        let sendId = sl[0]
        let content = sl[1]
        let html = $('#nextMsg').html()
        if (content == 'ENTER') {
          html += "<div class='enter'>" + sendId + '님이 들어오셨습니다.</div>'
        } else if (content == 'OUT') {
          html += "<div class='enter'>" + sendId + '님이 나가셨습니다.</div>'
        } else if (sendId != '${userid}') {
          let currT = new Date().getHours() + ':' + new Date().getMinutes()
          html +=
            '<div class="chat__message chat__message-to-me"><div class="chat__message-center"><h3 class="chat__message-username">' +
            sendId +
            '</h3><span class="chat__message-body">' +
            content +
            '</span></div><span class="chat__message-time">' +
            currT +
            '</span></div>'
        }

        $('#nextMsg').html(html)

        console.log('ReceiveMessage:' + event.data + '\n')
      }

      function onClose(event) {
        console.log('Info: connection closed')
      }

      function onError(err) {
        console.log('Error:', err)
      }
      function send() {
        let currT = new Date().getHours() + ':' + new Date().getMinutes()
        let msg = $('#msg').val()
        if (sock.readyState !== 1) return

        //채팅방, id, 메세지
        sock.send('1,' + '${userid}' + ',' + msg)

        let html =
          $('#nextMsg').html() +
          '<div class="chat__message chat__message-from-me"><span class="chat__message-time">' +
          currT +
          '</span><span class="chat__message-body">' +
          msg +
          '</span></div>'
        $('#nextMsg').html(html)
        $('#msg').val('')
      }
      $(document).ready(function () {
        $('#backChats').on('click', function (e) {
          sock.onclose()
          sock.send('1,' + '${userid}' + ',' + 'OUT')
          window.resizeTo(720, 498)
          location.replace('chatList')
        })

        $('#btnSend').on('click', function (e) {
          send()
          $('.chat').scrollTop($('.chat')[0].scrollHeight)
        })

        $('#wsClose').on('click', function (e) {
          sock.onclose()
        })
        $('#msg').on('keydown', function (e) {
          if (e.keyCode == 13) {
            send()
            $('.chat').scrollTop($('.chat')[0].scrollHeight)
          }
        })
        $(window).bind('beforeunload', function (e) {
          sock.send('1,' + '${userid}' + ',' + 'OUT')
          sock.onclose()
        })
      })
    </script>
  </head>
  <body class="body-chat">
    <header class="top-header chat-header">
      <div class="header__column">
        <i class="fa fa-chevron-left fa-lg" id="backChats"></i>
      </div>
      <div class="header__column">
        <span class="header__text">채팅방2</span>
      </div>
    </header>
    <div class="chat">
      <div class="date-divider">
        <span class="date-divider__text"> <%= sf.format(nowTime) %></span>
      </div>

      <div id="nextMsg"></div>
    </div>
    <div class="type-message">
      <div class="type-message__input">
        <input type="text" id="msg" />
        <span id="btnSend">전송</span>
      </div>
    </div>
  </body>
</html>
