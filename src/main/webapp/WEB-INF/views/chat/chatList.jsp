<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <title>chats</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/chatList.css?after" />
  </head>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
  <script type="text/javascript">
    $(document).ready(function () {
      $('#room1').on('click', function () {
        window.resizeTo(600, 800)
        location.replace('room1')
      })

      $('#room2').on('click', function () {
        window.resizeTo(600, 800)
        location.replace('room2')
      })
      $('#room').on('click', function () {
        window.resizeTo(600, 800)
        var rand = Math.floor(Math.random()*2)+1
        if (rand == 2) {
          location.replace('room2')
        } else {
          location.replace('room1')
        }
      })
    })
  </script>
  <body>
    <div class="container anidi_services">
      <div class="row">
        <ul class="links">
          <li>
            <a id="room1" title="채팅 1번방">
              <span class="icon"><i class="fa fa-comments"></i></span>
              <span class="text">채팅방 1</span></a
            >
            <div class="clearfix"></div>
          </li>
          <li>
            <a id="room2" title="채팅 2번방">
              <span class="icon"><i class="fa fa-comments"></i></span>
              <span class="text">채팅방 2</span></a
            >
            <div class="clearfix"></div>
          </li>

          <li class="tab-bar">
            <a href="index" class="tab-bar__tab">
              <i class="fa fa-user"></i>
              <span class="tabl-bar_title">친구</span>
            </a>
            <a id="room" class="tab-bar__tab--selected">
              <i class="fa fa-commenting"></i>
              <span class="tab-bar__title">채팅</span>
            </a>
            <a href="" class="tab-bar__tab">
              <i class="fa fa-ellipsis-h"></i>
              <span class="tab-bar__title">더보기</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </body>
</html>
