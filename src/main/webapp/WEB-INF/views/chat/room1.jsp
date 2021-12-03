<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ page import="java.util.Date" %> <%@ page import="java.text.SimpleDateFormat" %> <% Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("E요일, yyyy년 MM월 dd일"); %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
      integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" type="text/css" href="/resources/css/room.css" />
    <title>채팅방</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script type="text/javascript">
      var sock = new SockJS('http://localhost:8080/chat')
      sock.onmessage = onMessage
      sock.onclose = onClose
      sock.onopen = onOpen

      //이벤트 헨들러
      function onOpen(evt) {
        console.log('Info: connection opened.')
        sock.send('1' + ',' + '${userid}' + ',' + 'ENTER')
      }

      //소켓한테 메시지 받아옴
      function onMessage(event) {
        var sm = event.data
        //sl에는 sendId, content가 들어있음
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
        //setTimeout( function() {connect(); }, 1000); // retry connection!!
      }

      sock.onError = function (err) {
        console.log('Error:', err)
      }
      function send() {
        let currT = new Date().getHours() + ':' + new Date().getMinutes()
        let msg = $('#msg').val()
        if (sock.readyState !== 1) return

        //protocol: RoomNum, 보내는id, 내용
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
        $('#backChats').on('click', function (evt) {
          sock.onclose()
          location.replace('chatList')
          sock.send('1,' + '${userid}' + ',' + 'OUT')
        })

        $('#btnSend').on('click', function (evt) {
          send()
          $('.chat').scrollTop($('.chat')[0].scrollHeight)
        })

        $('#wsClose').on('click', function (e) {
          sock.onclose()
        })
        $('#msg').on('keydown', function (evt) {
          if (evt.keyCode == 13) {
            send()
            $('.chat').scrollTop($('.chat')[0].scrollHeight)
            
          }
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
        <span class="header__text">ROOM1</span>
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
