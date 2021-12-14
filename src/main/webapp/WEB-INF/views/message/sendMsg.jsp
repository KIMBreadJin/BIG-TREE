<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8" />
  <head>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <title>Home</title>
    <style type="text/css">
      .red {
        color: red;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div>
        <br style="clear: both" />
        <div class="form-group col-md-4">
          <label id="messageLabel" for="ms_content">Message </label>
          <textarea class="form-control input-sm" name ="ms_content" id="ms_content" placeholder="메세지를 입력해주세요" maxlength="140" rows="7"></textarea>
          <span class="help-block"><p id="characterLeft" class="help-block">You have reached the limit</p></span>
        </div>
        <div>
          <input type="hidden" id="user_id" name="user_id" value="${info.user_id}" />
          <input type="hidden" id="receiver_id" name="receiver_id" value="${find.user_id}" />
          <input type="hidden" id="receiver_name" name="receiver_name" value="${find.user_name}" />
          <input type="hidden" id="send_name" name="send_name" value="${info.user_name}" />
        </div>
        <br style="clear: both" />
        <div class="form-group col-md-2">
          <button class="form-control input-sm btn btn-success disabled" id="btnSubmit" name="btnSubmit" type="button" style="height: 35px">
            send
          </button>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready(function () {
        $('#characterLeft').text('140 characters left')
        $('#ms_content').keydown(function () {
          var max = 140
          var len = $(this).val().length
          if (len >= max) {
            $('#characterLeft').text('You have reached the limit')
            $('#characterLeft').addClass('red')
            $('#btnSubmit').addClass('disabled')
          } else {
            var ch = max - len
            $('#characterLeft').text(ch + ' characters left')
            $('#btnSubmit').removeClass('disabled')
            $('#characterLeft').removeClass('red')
          }
        })
        $('#btnSubmit').click(function (){
        	var content = $('#ms_content').val()
            var id = $('#user_id').val()
            var reName = $('#receiver_name').val()
            var reId = $('#receiver_id').val()
            var seName = $('#send_name').val()
            $.ajax({
                type: 'post',
                url: '/message/sendMsg',
                data: JSON.stringify({
                  user_id: id,
                  ms_content:content,
                  receiver_id : reId,
                  receiver_name : reName,
                  send_name : seName,
                }),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                  if (data == 0) {
                  	alert('다시 시도 해주세요')
                  } else {
                   	alert('쪽지를 보냈습니다')
                   	self.opener = self;
                   	window.close();
                  }
                },
              })
            })
        })
    </script>
  </body>
</html>
