<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <style>
    body {
      width: 70%;
      margin: 0 auto;
    }
    .image {
      position: relative;
    }
    .image .likeText {
      position: absolute;
      top: 40px;
      right: 60px;
    }
    .image .hateText {
      position: absolute;
      top: 40px;
      right: 5px;
    }
  </style>
  <body>
    <!-- -------------------게시글 조회--------------------------- -->
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header">게시글 조회</h1>
      </div>
      <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
      <div class="col-lg-12">
        <div class="panel panel-default">
          <div class="panel-heading">게시글 조회 페이지</div>
          <!-- /.panel-heading -->
          <div class="panel-body">
            <div class="form-group">
              <label for="title">번호</label>
              <input type="text" class="form-control" name="bno" value="${board.bno}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="title">제목</label>
              <input type="text" class="form-control" name="title" value="${board.title}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="writer">작성자</label>
              <input type="text" class="form-control" name="writer" value="${board.writer}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="content">내용</label>
              <textarea name="content" id="content" rows="3" class="form-control" readonly="readonly">${board.content}</textarea>
            </div>
            <div class="form-group">
              <label for="views">조회수</label>
              <input type="text" class="form-control" name="views" value="${board.views}" readonly="readonly" />
            </div>
            <div>
              <%--<c:if test="${board.writer}==${info.user_name}">
                --%>
                <button data-oper="modify" class="btn btn-default" type="submit">수정</button>
                <%--</c:if
              >
              --%>
              <button data-oper="list" class="btn btn-info" type="submit">목록</button>
              <div class="image" align="right">
                <img src="/resources/images/recommend.png" class="img-thumbnail" id="like" width="50px" />
                <div class="likeText">${totalLike}</div>

                <img src="/resources/images/not_recommend.png" class="img-thumbnail" id="hate" width="50px" />
                <div class="hateText">${totalHate}</div>
              </div>
            </div>
              <!-- 리플기능 추가하기 -->

            <li class="fa fa-comments fa-fw"></li>
            	댓글
            <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글 달기</button>
            <ul class="chat">
              <li class="left clearfix" data-rno="12">
                <div>
                  <div class="header">
                    <strong class="primary-font">user00</strong>
                    <small class="pull-right text-muted">2021-12-01 16:55</small>
                  </div>
                  <p>댐댐?</p>
                </div>
              </li>
            </ul>
            <!-- 리플기능 추가하기 끝 -->
            <form action="/board/modify" method="get" id="operForm">
              <input type="hidden" id="bno" name="bno" value="${board.bno}" />
              <input type="hidden" name="pageNum" value="${cri.pageNum}" />
              <input type="hidden" name="amount" value="${cri.amount}" />
              <input type="hidden" name="keyword" value="${cri.keyword}" />
              <input type="hidden" name="type" value="${cri.type}" />
            </form>
          </div>
          <!-- /.panel-boby -->
        </div>
        <!-- /.panel -->
      </div>
    </div>
    <!-- ----------------------여기까지 게시글 조회------------------------------   -->
  </body>
  <script>
      var likeClicked= ${recommended.likeCnt}!=1 ? false : true
      var hateClicked= ${recommended.hateCnt}!=1 ? false : true  
      var totalLike=${totalLike}
      var totalHate=${totalHate}
      
      $(document).ready(function (e) {
    	changeColor()	
        var operForm = $('#operForm')
        $("button[data-oper='modify']").click(function (e) {
          operForm.attr('action', '/board/modify').submit()
        })
        $("button[data-oper='list']").click(function (e) {
          operForm.find('#bno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
          operForm.attr('action', '/board/list').submit()
        })

    $(".img-thumbnail").click(function(e){
    	 var img=$(".img-thumbnail")
         if(img.eq(0)[0]==$(this)[0]){//눌린 버튼이 추천일때
             if(hateClicked==false && likeClicked==false){//아무버튼이 눌려져있지않은경우
             	$(".likeText").text(++totalLike)
             	likeClicked= !likeClicked
             }
             else if(likeClicked==true && hateClicked==false){//추천이눌러진경우 추천을다시눌렀을때
             	$(".likeText").text(--totalLike)
             	likeClicked= !likeClicked
             }
             else if(likeClicked==false && hateClicked==true){//비추천이눌려져있을경우 추천을눌렀을때
             	$(".hateText").text(--totalHate)
             	$(".likeText").text(++totalLike)
             	hateClicked= !hateClicked
             	likeClicked = !likeClicked
             }
           }
          else{//눌른버튼이 비추천일때
         	 if(hateClicked==false && likeClicked==false){//아무버튼이 눌려져있지않은경우
              	$(".hateText").text(++totalHate)
              	hateClicked = !hateClicked
              }
              else if(likeClicked==false && hateClicked==true){//비추천이눌러진경우 비추천을다시눌렀을때
              	$(".hateText").text(--totalHate)
              	hateClicked= !hateClicked
              }
              else if(likeClicked==true && hateClicked==false){//추천이눌려져있을경우 비추천을눌렀을때
              	$(".likeText").text(--totalLike)
              	$(".hateText").text(++totalHate)
              	hateClicked= !hateClicked
              	likeClicked = !likeClicked
              }
           }
    
      	changeColor()
     	updateRecommended()
    	 })//click end
      })//document end

      const changeColor=()=>{
        if(likeClicked==true && hateClicked==false){
          $("#like").css('background-color','red')
          $("#hate").css('background-color','white')
        }
        else if(likeClicked==false && hateClicked==false){
          $("#like").css('background-color','white')
          $("#hate").css('background-color','white')
        }
        else if(likeClicked==false && hateClicked==true){
          $("#like").css('background-color','white')
          $("#hate").css('background-color','red')
        }
      }
      const updateRecommended=()=>{
        var param={"bno":${board.bno} ,"userName":"${info.user_name}",
    				"likeCnt":(likeClicked ? 1: 0), "hateCnt":(hateClicked ? 1: 0)
    	  }
        $.ajax({
     	  type:'POST',
     	  data:param,
        	url:'/updateRecommended',
     	  dataType:"json",
     	  success:function(data){
     		  console.log(data)
     	  },
     	  error:function(data){
          console.log(data)
     		  
     	  }
       })//ajax end
      }
  </script>
  <script type="text/javascript" src="/resources/js/reply.js"></script>
  <script>
    $(document).ready(function () {
      var bnoValue = '<c:out value="{board.bno}"/>'
      var replyUL = $('.chat')
      showList(1)

      function showList(page) {
        replyService.getList({ bno: bnoValue, page: page || 1 }, function (list) {
          var str = ''
          if (list == null || list.length == 0) {
            replyUL.html('')
            return
          }
          for (var i = 0, len = list.length || 0; i < len; i++) {
            str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>"
            str += "<div><div class='header'><strong class='primary-font'>" + list[i].replyer + '</strong>'
            str += "<small class='pull-right text-muted'>" + replySerivce.displayTime(list[i].replyDate) + '</small></div>'
            str += '<p>' + list[i].reply + '</p></div></li>'
          }
          replyUL.html(str)
        }) //함수끝
      } // 쇼리스트 끝//
    })
  </script>
</html>
