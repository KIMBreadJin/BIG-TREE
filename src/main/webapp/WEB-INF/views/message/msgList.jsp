<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %><%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
  <meta charset="UTF-8" />
  <head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" />
    <link
      rel="stylesheet"
      href="https://unpkg.com/bootstrap-material-design@4.1.1/dist/css/bootstrap-material-design.min.css"
      integrity="sha384-wXznGJNEXNG1NFsbm0ugrLFMQPWswR3lds2VeinahP8N0zJw9VWSopbjv2x7WCvX"
      crossorigin="anonymous"
    />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet" />
    <link
      rel="stylesheet"
      type="text/css"
      href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons"
    />
    <link rel="stylesheet" type="text/css" href="/resources/css/msgList.css" />
  </head>
  <body>
    <div class="container">
      <div class="title">
        <h3 style="text-align: center">쪽지함</h3>
      </div>
      <div class="row">
        <div class="col-md-12">
          <h4 style="text-align: center">받은 쪽지</h4>
        </div>
        <div class="col-lg-8 col-md-10 ml-auto mr-auto">
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <th class="text-center">#</th>
                  <th>보낸사람</th>
                  <th>쪽지 내용</th>
                  <th>받은 날짜</th>
                  <th class="text-center">Actions</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${mlist}" var="mlist" varStatus="status">
                  <tr>
                    <td class="text-center">${status.count}</td>
                    <td>
                      <a id="senderInfo${status.count}" href="#" data-toggle="modal" data-test="${mlist.user_id}">${mlist.send_name}</a>
                    </td>
                    <td>
                      <div>
                        <a
                          id="readM"
                          href="/message/readMsg?mid=${mlist.mid}"
                          onclick="window.open(this.href, '_blank', 'width=600, height=480'); return false;"
                          >${mlist.ms_content}</a
                        >
                      </div>
                    </td>
                    <td>${mlist.creat_dt}</td>
                    <td class="td-actions text-center">
                      <a
                        id="writeB"
                        href="/message/sendMsg?user_id=${mlist.user_id}"
                        onclick="window.open(this.href, '_blank', 'width=600, height=480'); return false;"
                      >
                        <button type="button" class="btn btn-success btn-just-icon btn-sm" id="backMsg${mlist.mid}">
                          <i class="material-icons">send</i>
                        </button>
                      </a>
                      &nbsp;&nbsp;
                      <button
                        type="submit"
                        class="btn btn-danger btn-just-icon btn-sm"
                        id="removeMsg${mlist.mid}"
                        onClick="removeMessage(${mlist.mid})"
                      >
                        <i class="material-icons">close</i>
                      </button>
                    </td>
                    <td>
                      <form action="/message/sendMsg" method="get" name="actForm" id="actFrm">
                        <input type="hidden" id="user_id${mlist.mid}" name="user_id" value="${mlist.user_id}" />
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script type="text/javascript">
    function removeMessage(mid) {
      var actForm = $('#actFrm')
      var url = '/message/deleteMsg?mid=' + mid
      console.log('remove click')
      actForm.attr('action', url).attr('method', 'post').submit()
    }
    $(document).ready(function () {
      for (var i = 0; i <= $('.table >tbody tr').length; i++) {
        $('#senderInfo' + i).on('click', function (e) {
          var data = $(this).data('test')
          console.log(data)
          $.ajax({
            type: 'get',
            url: '/getUser',
            data: {
              user_name: data,
            },
            success: function (data) {
              $('#memberName').val(data.user_name)
              $('#memberId').val(data.user_id)
              $('#postCnt').val(data.boardCnt)
              if (data.user_profileImage != null) {
                $('#profileImage').find('img').hide()
                $('#profileImage').append(data.user_profileImage)
              } else {
                $('#profileImage').find('img').show()
              }
            },
          })

          $('#memberInfo').modal('show')

          resetClicked()
        })
      }
    })
  </script>
</html>
