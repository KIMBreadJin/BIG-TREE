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

 <!-- -------------------게시글 조회--------------------------- -->
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">게시글 수정페이지</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">게시글 수정 페이지</div>
      <!-- /.panel-heading -->
      <div class="panel-body">
     
      <form action="/board/modify" method="get" id="operForm">
        <div class="form-group">
          <label for="title">번호</label>
          <input type="text" class="form-control" name="bno" value="${board.bno}" readonly="readonly" />
        </div>
        <div class="form-group">
          <label for="writer">작성자</label>
          <input type="text" class="form-control" name="writer" value="${board.writer}" readonly="readonly" />
        </div>
        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" class="form-control" name="title" value="${board.title}"  />
        </div>
         
        <div class="form-group">
          <label for="content">내용</label>
          <textarea name="content" id="content" rows="3" class="form-control" >${board.content}</textarea>
        </div>
       
        
        <button data-oper="modify" class="btn btn-default" type="button">수정하기</button>
        <button data-oper="details" class="btn btn-info" type="submit">돌아가기</button>
        <button data-oper="list" class="btn btn-info" type="submit">목록으로가기</button>
        <button data-oper="delete" class="btn btn-danger" type="submit">삭제하기</button>
        
          
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
        e.preventDefault();
        	if(confirm("정말 수정하시겠어요?")){
	      operForm.attr('action', '/board/modify').attr('method','post').submit();
        	}
	    })
      $("button[data-oper='details']").click(function(e){
        operForm.attr('action','/board/details').submit()
        console.log("dd")
      })
	    $("button[data-oper='list']").click(function (e) {
	      operForm.find('#bno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
	      operForm.attr('action', '/board/list').submit()
	    })
	     $("button[data-oper='delete']").click(function (e) {
			if(confirm("정말 삭제하시겠어요?")){
	      		operForm.attr('action', '/board/delete').attr('method','post').submit()
			}
	    })
	   
})
</script>

</html>