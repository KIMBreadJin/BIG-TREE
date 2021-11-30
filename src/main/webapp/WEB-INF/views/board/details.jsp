<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
 	body{
	    width: 70%;
	    margin: 0 auto;
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
       		<c:if test="${board.writer}==${info.user_name}">
	        	<button data-oper="modify" class="btn btn-default" type="submit">수정</button>
	        </c:if>
	        <button data-oper="list" class="btn btn-info" type="submit">목록</button>
         	<img src="/resources/images/recommend.png" class="img-thumbnail" id="recommend" width="50px" >
        	<img src="/resources/images/not_recommend.png" class="img-thumbnail" id="notRecommend" width="50px">
        </div>
     
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
$(document).ready(function(e){
	  var operForm = $('#operForm')
	    $("button[data-oper='modify']").click(function (e) {
	      operForm.attr('action', '/board/modify').submit()
	    })
	    $("button[data-oper='list']").click(function (e) {
	      operForm.find('#bno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
	      operForm.attr('action', '/board/list').submit()
	    })
        $(".img-thumbnail").click(function(e){
          console.log("눌렸다")
        })

      const recommend =()=>{
        
      }
})
</script>

</html>