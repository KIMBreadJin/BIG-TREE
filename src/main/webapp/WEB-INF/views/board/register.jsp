<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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

 <!-- -------------------게시글 등록--------------------------- -->
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">게시글 등록페이지</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">게시글 등록 페이지</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
     
      <form action="/board/register" method="post" id="operForm">
    
        <div class="form-group">
          <label for="writer">작성자</label>
          <input type="text" class="form-control" name="writer" value="${info.user_name}" readonly="readonly"/>
        </div>
        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" class="form-control" name="title"  />
        </div>
         
        <div class="form-group">
          <label for="content">내용</label>
          <textarea name="content" id="content" rows="3" class="form-control" ></textarea>
        </div>
    
        <button data-oper="list" class="btn btn-info" type="button">목록으로가기</button>
        <button data-oper="regist" class="btn btn-danger" type="button">등록하기</button>
  
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
	    $("button[data-oper='list']").click(function (e) {
	      operForm.attr('action', '/board/list').attr('method','get').submit()
	    })
	     $("button[data-oper='regist']").click(function (e) {
			if(confirm("등록하시겠습니까?")){
	      		operForm.submit()
			}
	    })   
})
</script>

</html>