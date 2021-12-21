<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<script src="/resources/js/ckeditor/ckeditor.js"></script>
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
            <form action="/qna/register" method="post" id="operForm">
              <div class="form-group">
                <label for="writer">작성자</label>
                <input type="text" class="form-control" name="writer" value="${info.user_name}" readonly />
              </div>
            <div class="form-group">
              <input type="hidden" class="form-control" name="id" value="${info.user_id}"  />
            </div>
              <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" name="title" />
              </div>

              <div class="form-group">
                <label for="content">내용</label>
                <textarea name="content" id="content" rows="3" class="form-control"></textarea>
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
              <button id="list" class="btn btn-info" type="button">목록으로가기</button>
              <button id="regist" class="btn btn-danger" type="button">등록하기</button>

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
    <!-- ----------------------여기까지 게시글 등록------------------------------   -->

  </body>
  <script>
		var cnt =0;
		var objArr;
		var images=[]
		var myObjArr=[]
		var operForm = $('#operForm')
		//=========ckeditor를 호출해 textarea 변경
	   $(document).ready(function (e) {
		   //비밀글 start
		   $('[name=secret]').click(function(e){
			   var secretValue = $("input[type=radio]:checked").val();
			   console.log(secretValue)
			  ${qna.secret}=secretValue
			  
		   })//비밀글 end
		   
		 		 //==============버튼 유형에 따른 처리========================
     
      $("#list").click(function (e) {
        operForm.attr('action', '/qna/list').attr('method', 'get').submit()
      })
      $("#regist").click(function (e) {
    	  
        if (confirm('등록하시겠습니까?')) {
        	var pass= nullDataCheck()
	    	if(pass.content==true && pass.title==true){
	    		nullImageDelete()
	            operForm.submit()	
	    	}
	    	else{
	    		e.preventDefault()
	    		alert("제목과 내용을 채워주세요")
	    	}
        	
        }
        
      })
      //==============버튼 유형에 따른 처리======================== 	
    	  
    //===========지운 이미지 input태그에서 삭제================= 	
	    const nullImageDelete=()=>{
	    	for(var count=0; count<myObjArr.length; count++){
				var findId="img#img"+(count)
				if($("iframe").contents().find(findId)[0]==null){
					console.log(count+"번째 이미지 없음")
					$("#"+count).remove()
				}	
			}
	    } //nullImageDelete

	    const nullDataCheck=()=>{
	        var nullData={
	        		"title":false,
	        		"content":false,	
	        	}
		    	if(ckediters.getData().length!=0){
		    		nullData.content=true
		    	}
		        if($("input[name='title']").val().length!=0){
		          nullData.title=true
		        }
	        return nullData
	    } //nullDataCheck
	});//========document.end==========================	
	  
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
			    $('a.cke_dialog_ui_button.cke_dialog_ui_button_ok').remove()
			    $('a.cke_dialog_ui_button.cke_dialog_ui_button_cancel').text('확인').css('width','60px')
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
