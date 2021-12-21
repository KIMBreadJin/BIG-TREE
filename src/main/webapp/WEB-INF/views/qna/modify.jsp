<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="/resources/js/ckeditor/ckeditor.js"></script>
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
          <input type="text" class="form-control" name="qno" value="${qna.qno}" readonly="readonly" />
        </div>
        <div class="form-group">
          <label for="title">아이디</label>
          <input type="hidden" class="form-control" name="id" value="${qna.id}" readonly="readonly" />
        </div>
        <div class="form-group">
          <label for="writer">작성자</label>
          <input type="text" class="form-control" name="writer" value="${qna.writer}" readonly="readonly" />
        </div>
        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" class="form-control" name="title" value="${qna.title}"  />
        </div>
         
        <div class="form-group">
          <label for="content">내용</label>
          <textarea name="content" id="content" rows="3" class="form-control" >${qna.content}</textarea>
        </div>
       <p>비밀글 공개여부</p>

		<div>
			<input type="radio" id="SecretRadio" name="secret" value="Y"   checked>
			<label >공개</label>
		</div>
		<div>
			<input type="radio" id="nonsecretRadio" name="secret" value="N">
			<label>비공개</label>
		</div>
    	<br/>
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
	   //비밀글 start
	   $('[name=secret]').click(function(e){
		   var secretValue = $("input[type=radio]:checked").val();
		   console.log(secretValue)
		  ${qna.secret}=secretValue
		  
	   })//비밀글 end
	   
	  var operForm = $('#operForm')
	    $("button[data-oper='modify']").click(function (e) {
        e.preventDefault();
        	if(confirm("정말 수정하시겠어요?")){
	      operForm.attr('action', '/qna/modify').attr('method','post').submit();
        	}
	    })
      $("button[data-oper='details']").click(function(e){
        operForm.attr('action','/qna/details').submit()
        console.log("dd")
      })
	    $("button[data-oper='list']").click(function (e) {
	      operForm.find('#qno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
	      operForm.attr('action', '/qna/list').submit()
	    })
	     $("button[data-oper='delete']").click(function (e) {
			if(confirm("정말 삭제하시겠어요?")){
	      		operForm.attr('action', '/qna/delete').attr('method','post').submit()
			}
	    })
	   
})
 	var ckediters = CKEDITOR.replace('content', {
	      filebrowserUploadUrl: '/uploadImage',
	      uiColor: '#14B8C4',
	      toolbarCanCollapse:true
	    })
     CKEDITOR.on('dialogDefinition', function (ev) {//CKEDITOR 불필요한 요소 제거
          var dialogName = ev.data.name;
          var dialog = ev.data.definition.dialog;
          var dialogDefinition = ev.data.definition;
          var uploadTab=dialogDefinition.getContents( 'Upload' )
          var infoTab = dialogDefinition.getContents( 'info' )  //info탭을 제거하면 이미지 업로드가 안된다.
          if (dialogName == 'image') {
              dialog.on('show', function (obj) {
                  this.selectPage('Upload'); //업로드텝으로 시작
              });
              dialogDefinition.removeContents('advanced'); // 자세히탭 제거    
          }     
          infoTab.remove( 'txtHSpace');
          infoTab.remove( 'txtVSpace');
          infoTab.remove( 'txtBorder');
          infoTab.remove( 'ratioLock');
          infoTab.remove( 'cmbAlign');    
      });
	
		   $(document).on('click','div.cke_dialog_body',function(e){// document클릭시 이벤트발생
			    objArr= $("iframe").contents().find('pre').text()//textarea의 이미지
			    var myobj = JSON.parse(objArr);
		   		myObjArr.push(myobj)
			    var fileCallPath = encodeURIComponent(myobj[0].uploadPath + '/s_' + myobj[0].uuid + '_' + myobj[0].fileName)        
		        str = "<img id='img"+(cnt)+"' src='/display?fileName=" + fileCallPath + "'>"//이미지 태그 생성 
               str2="<div id='"+(cnt)+"'>"//form 태그의 input타입 생성하기위한 문자열 선언
               str2 += "<input type='hidden' name='imageList[" + (cnt)+ "].fileName' value='" + myobj[0].fileName + "'>"
               str2 += "<input type='hidden' name='imageList[" + (cnt) + "].uuid' value='" + myobj[0].uuid + "'>"
               str2 += "<input type='hidden' name='imageList[" + (cnt++) + "].uploadPath' value='" + myobj[0].uploadPath + "'>"
		        str2 +="</div>"
               ckediters.setData(ckediters.getData()+str);//기존의 data에 이미지 추가
		        operForm.append(str2)//폼태그에 input(name=imageList) 보내기
		    
	   }) 		   
</script>

</html>