<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8" />
  <head>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.1.0/css/all.css"
      integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt"
      crossorigin="anonymous"
    />
    <style>
      .container {
        max-width: 720px;
      }
      .row {
        margin-top: 50px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6 pb-5">
          <!--Form with header-->

          <form action="sendMsg" name="sendMsg" method="get">
            <div class="card border-primary rounded-0">
              <div class="card-header p-0">
                <div class="bg-info text-white text-center py-2">
                  <h3><i class="fa fa-envelope"></i> Message</h3>
                  <p class="m-0">받은 쪽지 입니다</p>
                </div>
              </div>
              <div class="card-body p-3">
                <!--Body-->
                <div class="form-group">
                  <div class="input-group mb-2">
                    <div class="input-group-prepend">
                      <div class="input-group-text">
                        <i class="fa fa-arrow-right text-info"></i>
                        <p class="m-0">🌳Sender</p>
                      </div>
                    </div>
                    <input type="text" class="form-control" id="sender" name="sender" readonly />
                  </div>
                </div>
                <div class="form-group">
                  <div class="input-group mb-2">
                    <div class="input-group-prepend">
                      <div class="input-group-text">
                        <i class="fa fa-arrow-left text-info"></i>
                        <p class="m-0">🌲Receiver</p>
                      </div>
                    </div>
                    <input type="email" class="form-control" id="receiver" name="receiver" readonly />
                  </div>
                </div>

                <div class="form-group">
                  <div class="input-group mb-2">
                    <div class="input-group-prepend">
                      <div class="input-group-text">
                        <i class="fa fa-comment text-info"></i>
                        <p class="m-0">-Content</p>
                      </div>
                    </div>
                    <textarea class="form-control" readonly> ${readM.ms_content } </textarea>
                  </div>
                </div>

                <div class="text-center">
                  <input value="답장하기" id="answer" class="btn btn-info btn-block rounded-0 py-2" />
                </div>
              </div>
            </div>
          </form>
          <!--Form with header-->
        </div>
      </div>
    </div>
    <script type="text/javascript">
      $(document).ready(function () {
        $('#answer').click(function () {
          var reId = '${readM.user_id }'
          var reName = '${readM.send_name }'
          $.ajax({
            type: 'post',
            url: '/message/readMsg',
            data: {
              receiver_id: reId,
              receiver_name: reName,
            },
            success: function (data) {
              if (data == 0) {
                alert('다시 시도 해주세요')
              } else {
                document.sendMsg.submit()
              }
            },
          })
        })
        var sender = '${readM.send_name}(' + '${readM.user_id}'.substr(0, 3) + '***)'
        var receiver = '${readM.receiver_name}(' + '${readM.receiver_id}'.substr(0, 3) + '***)'
        console.log(sender)
        console.log(receiver)

        $('#sender').val(sender)
        $('#receiver').val(receiver)
      })
    </script>
  </body>
</html>
