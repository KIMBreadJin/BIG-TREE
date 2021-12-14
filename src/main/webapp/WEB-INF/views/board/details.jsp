<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<%@ include file="../includes/header.jsp" %>
  <script src="/resources/js/ckeditor/ckeditor.js"></script>
  <style>
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
	.image .reportText{
		position:absolute;
		top:40px;
		right:115px;
	}
  </style>
  <body>
    <!-- -------------------게시글 조회--------------------------- -->
    <!-- /.row -->
    
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
                <button data-oper="modify" id="boardModifyBtn" class="btn btn-warning" type="submit">수정</button>
              <button data-oper="list" class="btn btn-info" type="submit">목록</button>
           		<div class="image" align="right">
              	<img src="/resources/images/report_icon.jpg" class="img-report" id="report" width="30px" hspace=5 />
                <div class="reportText">신고</div>
                <img src="/resources/images/recommend.png" class="img-thumbnail" id="like" width="50px" />
                <div class="likeText">${totalLike}</div>
                <img src="/resources/images/not_recommend.png" class="img-thumbnail" id="hate" width="50px" />
                <div class="hateText">${totalHate}</div>     
              </div>    
             <!-- 신고,추천,비추천 아이콘 -->            
                
            </div>
           </div>
 		</div>
	</div>
            <!-- 리플기능 추가하기 -->
           <br>
      <div class="col-lg-12" >
          <!-- panel -->
          <div class="panel panel-default">
            <div class="panel-heading">
            	<button id="addReplyBtn" class="btn btn-primary btn-xs">댓글등록</button>
            	
            </div>    
          </div> 
          <!-- panel-body -->
         <div class="panel-body">
 			<!-- 댓글 구현창 -->
 			<br>
            <ul class="chat">
             
            </ul>
         
          <div class="panel-footer">
            
           </div>
            <!-- 모달창 -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button class="close">&times</button>
                    <h4 class="modal-title" id="myModalLabel">댓글</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">

                      <div class="form-group">
                        <input type="hidden" class="form-control" name="replyer"  id="replyer" readonly />
                      </div>
                      <div class="form-group">
	                    <label for="">댓글</label>
	                    <input type="text" class="form-control" name="reply" id="reply" />
	                  </div>
                      <div class="form-group">
                        <label for="">댓글작성일</label>
                        <input type="text" class="form-control" name="replyDate" value="" />
                      </div>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn btn-warning" id="modalModBtn" type="button">수정</button>
                    <button class="btn btn-danger" id="modalRemoveBtn" type="button">삭제</button>
                    <button class="btn btn-primary" id="modalRegisterBtn" type="button">등록</button>
                    <button class="btn btn-info" id="modalCloseBtn" type="button">닫기</button>
                  </div>
                </div>
              </div>
            </div>
            <!-- 리플기능 추가하기 끝 -->

            <form action="/board/modify" method="get" id="operForm">
              <input type="hidden" id="bno" name="bno" value="${board.bno}" />
              <input type="hidden" name="pageNum" value="${cri.pageNum}" />
              <input type="hidden" name="amount" value="${cri.amount}" />
              <input type="hidden" name="keyword" value="${cri.keyword}" />
              <input type="hidden" name="type" value="${cri.type}" />
            </form>
          
        </div>
        <!-- /.panel -->
      </div>
		<!-- 신고하기 모달창  -->
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h4 class="modal-title" >신고하기</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
					  <div class="form-group">
                        <input type="hidden" class="form-control" name="bno" id="bno" readonly />
                      </div>
                      <div class="form-group">          
                        <input type="hidden" class="form-control" name="reporter" id="reporter" readonly />
                      </div>
                      <div class="form-group">
					  	<label class="control-label col-sm-3">신고사유 </label>
					    <div class="col-md-5 col-sm-8">
					       <select name="reason" class="form-control" id="reason" >
						      <option value="">사유를 선택해주세요</option>
						      <option value="부적절한 컨텐츠">부적절한 컨텐츠</option>
						      <option value="욕설 ">욕설</option>
						      <option value="자극적인 내용">자극적인 내용</option>
						      <option value="정치적 성향이 짙음">정치적 성향이 짙음</option>
					       </select>
					    </div>
					 </div>      
					 
					 <div class="form-group">
			            <label for="content">세부내용</label>
			            <textarea name="details" id="details" rows="3" class="form-control">${board.reportWithUser.details}</textarea>
		              </div>         
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                   <button class="btn btn-warning" id="reportModifyBtn" type="button">수정</button>
                    <button class="btn btn-danger" id="reportDeleteBtn" type="button">삭제</button>
                    <button class="btn btn-primary" id="reportRegistBtn" type="button">등록</button>
                    <button class="btn btn-default" id="reportCloseBtn" type="button">닫기</button>
                  </div>
                </div>
              </div>
            </div>

    <!-- ----------------------여기까지 게시글 조회------------------------------   -->
  </body>

  <!-- 리플 기능 -->
  <script>
    // replyService 기능 start
    var replyService = (function () {
      function add(reply, callback, error) {
        $.ajax({
          type: 'post',
          url: '/replies/new',
          data: JSON.stringify(reply),
          contentType: 'application/json; charset=utf-8',
          success: function (result, status, xhr) {
            if (callback) callback(result)
          },
          error: function (xhr, status, er) {
            if (error) error(err)
          },
        })
      }
      const getList = (param, callback, error) => {
        var bno = param.bno
        var page = param.page || 1
        $.getJSON('/replies/pages/' + bno + '/' + page + '.json', (data) => {
          if (callback) callback(data.replyCnt, data.list) //controller에서
          //반환되는 pageDTO
        }).fail(function (xhr, status, err) {
          if (error) error()
        })
      }
		const remove = (rno,callback,error)=>{
			$.ajax({
				type:'delete',
				url:'/replies/' +rno,
				success:(deleteResult,status,xhr)=>{
					if(callback) callback(deleteResult)
				},
				error:
					(xhr,status,er)=>{
						if(error) error(er);
					}
			})
		}
		const update= (reply,callback,error)=>{

			$.ajax({
				type:'put',
				url:'/replies/' + reply.rno,
				data:JSON.stringify(reply),
				contentType:"application/json; charset=utf-8",
				success:(result, status, xhr)=>{
					if(callback) callback(result);
				},
				error:
					(xhr,status,er)=>{
					if(error) error(er);
				}
			})
		}
		const get = (rno ,callback ,error)=>{
			$.get("/replies/" +rno +".json" , (result) =>{
				if(callback) {callback(result)}
			}).fail((xhr,status,err) =>{
				if(error) error();
			})
		}
      const displayTime = (timeValue) => {
        var today = new Date()
        var gap = today.getTime() - timeValue
        var dateObj = new Date(timeValue)
        var str = ''
        if (gap < 1000 * 60 * 60 * 24) {
          //하루보다 작으면, 오늘날짜는 시간으로
          var hh = dateObj.getHours()
          var mi = dateObj.getMinutes()
          var ss = dateObj.getSeconds()
          return [(hh > 9 ? '' : '0') + hh, (mi > 9 ? '' : '0') + mi, (ss > 9 ? '' : '0') + ss].join(':') //배열에서 하나씩 꺼내서 문자열 생성  , 결합(join) 은 ":"  로 결합해라
        } else {
          //하루 지난시간
          var yy = dateObj.getFullYear()
          var mm = dateObj.getMonth() + 1 // getMonth는 0부터 시작
          var dd = dateObj.getDate()
          return [yy, (mm > 9 ? '' : '0') + mm, (dd > 9 ? '' : '0') + dd].join('/')
        }
      }
      return { add, getList, remove, update, get, displayTime }
    })()
    //resplyService 기능 end
    
    $(document).ready(function () {
    	if("${board.writer}"!="${info.user_name}"){
    		$("#boardModifyBtn").hide()
    	}
      var bnoValue = '<c:out value="${board.bno}"/>'
      var replyUL = $('.chat')
      const showList = (page) => {
        	 
	          replyService.getList({ bno: bnoValue, page: page || 1 }, (replyCnt,list) => {
	        	if(page==-1){
	        		page = Math.ceil(replyCnt/10.0);
	        		showList(pageNum)
	        		return;
	        	}
	            var str = ''
	            if (list == null || list.length == 0) {
	              // 데이터가 없으면 종료함
	              replyUL.html('')
	              return
	            } //if문 end
	                  for (var i = 0, len = list.length || 0; i < len; i++) {
	                    str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>"
	                    str += " <div><div class='header'><strong class='primary-font'>" + list[i].replyer + '</strong>'
	                    str += "   <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + '</small></div>'
	                    str += ' <p>' + list[i].reply + '</p></div></li>'
	                  } //for문 end
	              
	            replyUL.html(str)
	            showReplyPage(replyCnt)
	          })//람다함수(replyCnt,list를 파라미터로갖고있는)의 end 
	         }//showList function end 
		 showList(1);
	     
         
	

      // 모달기능 start
      var modal = $('#myModal')
      var modalInputReply = modal.find("input[name='reply']")
      var modalInputReplyer = modal.find("input[name='replyer']") //!! 회원로그인했을경우 회원의아이디로 되게 만들것!
      var modalInputReplyDate = modal.find("input[name='replyDate']")
      var modalModBtn = $('#modalModBtn')
      var modalRemoveBtn = $('#modalRemoveBtn')
      var modalRegisterBtn = $('#modalRegisterBtn')

      $('#addReplyBtn').click(function (e) {
    	  if(${info.user_name!=null}){
    		  console.log("${info.user_name}")
	    	modalInputReplyer.val("${info.user_name}").attr('readonly','readonly')
	        modalInputReplyDate.closest('div').hide()
	        modal.find("button[id != 'modalCloseBtn' ]").hide()
	        modalRegisterBtn.show()
	        modal.modal('show')
    	  }
    	  else {
    		 
    		  alert("비회원은 이용할수 없습니다")
    	  }
      }) //addReply btn end

      $('#modalCloseBtn').click(function (e) {
        modal.modal('hide')
      }) //모달창닫을대 버튼 end

      modalRegisterBtn.on('click',(function (e) {

        var reply = {
          replyer: modalInputReplyer.val(),
          reply: modalInputReply.val(),
          bno: bnoValue,
        }
        replyService.add(reply, (result) => {
          alert(result)
          modal.find('input').val('')
          modal.modal('hide')
          //showList(1) // 댓글목록갱신
         showList(-1);
        })
      }) 
      )// modalRegisterBtn end
      
     $('.chat').on('click', 'li', function (e) {
    	  var replyer=$(this).find('strong').text()
          var rno = $(this).data('rno')
          replyService.get(rno, function (reply) {
          modalInputReply.val(reply.reply)
          modalInputReplyer.val(reply.replyer)
          modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr('readonly', 'readonly')
          modal.data('rno', reply.rno)
			
          modal.find("button[id!='modalCloseBtn']").hide()
          if("${info.user_name}"==replyer){
        	  console.log("${info.user_name}")
         	 console.log($(this).find('strong').text())
        	modalModBtn.show()
          	modalRemoveBtn.show()
          }
          
          else{
        	  $("#reply").attr('readonly',true)
        	  modalModBtn.hide()
          	  modalRemoveBtn.hide()
          }
          $('#myModal').modal('show')
          
        }) 

      }) //특정댓글의 이벤트 클릭이벤츠처리 424p참조할것 

      modalModBtn.click(function (e) {
          var reply = { rno: modal.data('rno'), reply: modalInputReply.val() }
          replyService.update(reply, (result) => {
            alert(result)
            modal.modal('hide')
            showList(pageNum)
          })
        }) //modalModBtn(수정)기능 end
       
        modalRemoveBtn.click(function (e) {
          var rno = modal.data('rno')
          replyService.remove(rno, (result) => {
            alert(result)
            modal.modal('hide')
            showList(pageNum)
          })
        }) //modalRemoveBtn(삭제)기능 end
        replyPageFooter.on('click', 'li a', function (e) {
            //li 태그로 만든 페이지 번호를 누르면     
            e.preventDefault()
            var targetPageNum = $(this).attr('href')
            //this는 누른 페이지 li 태그이고 이때의 li태그의 href 속성을 얻음   href = "3(페이지)"
            pageNum = targetPageNum
            showList(pageNum)
      }) //페이지번호를 클릭(replyPageFooter.on)하면 이동할수있게
    }) //document ready end

    // page계산함수
      var pageNum = 1
      var replyPageFooter = $('.panel-footer');

      const showReplyPage = (replyCnt) => {
        var endNum = Math.ceil(pageNum / 10.0) * 10
        var startNum = endNum - 9
        var prev = startNum != 1
        var next = false

        if (endNum * 10 >= replyCnt) {
          endNum = Math.ceil(replyCnt / 10.0)
        }
        if (endNum * 10 < replyCnt) {
          next = true
        }
        var str = "<ul class='pagination float-right'>";
        if (prev) {
          str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>이전 페이지</a></li>"
        }
        for (var i = startNum; i <= endNum; i++) {
          var active = pageNum == i ? 'active' : ''
          str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + '</a></li>'
        }
        if (next) {
          str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>다음 페이지</a></li>"
        }
        str += '</ul></div>'

        replyPageFooter.html(str)
      } // showReplyPage Function end
      
       
   
    
  </script>

  <!-- 추천,비추천기능 -->
  <script>
      var reported="${board.reportList}".includes("reporter=${info.user_name}")
      var likeClicked= ${recommended.likeCnt}!=1 ? false : true
      var hateClicked= ${recommended.hateCnt}!=1 ? false : true
      var totalLike=${totalLike}
      var totalHate=${totalHate}
	
      $(document).ready(function (e) {
    	  $("#reason").val("${board.reportList}")
    	 reportButtonChange()
    	 changeColor()//좋아요,싫어요 버튼 테두리씌우는함수 호출
        <!-- 수정,목록가기 버튼 클릭시 호출함수 -->
    	 var operForm = $('#operForm')
        $("button[data-oper='modify']").click(function (e) {
          operForm.attr('action', '/board/modify').submit()
        })
        $("button[data-oper='list']").click(function (e) {
          operForm.find('#bno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
          operForm.attr('action', '/board/list').submit()
        })
  <!-- 추천,비추천 이미지버튼 클릭시 -->
    $(".img-thumbnail").click(function(e){
  
    	if("${recommended.userName}"==="비회원"){
    		alert("비회원이용할수없습니다")
    		return false;

      }
    	
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
    
      	changeColor()//이미지 색상변경 함수호출
     	updateRecommended()//추천수 업데이트함수호출
     	<!-- 추천,비추천 함수 끝-->
    	 })//click end
    	 
    
    	 <!--report 클릭시 호출하게되는 함수 145번줄  -->
    	 $("#report").click(function(e){ 
    		 console.log(${info!=null})
    		 if(reported){
    			 if(confirm("이미 신고접수된 게시글입니다 수정하시겠습니까?")){
    				 $("#reportModal").modal('show')
    				 $("#reason option").each(function(){//신고사유의 옵션들을 하나씩가져와 비교후 reporter와 일치하면 selected로변경 
    					 if($(this).val()=="${board.reportWithUser.reason}" ){
					       $(this).attr("selected","selected"); // attr적용안될경우 prop으로 					
					    }					
					  });
    				 $("#reportModifyBtn").show()
    				 $("#reportDeleteBtn").show()
    				 $("#reportRegistBtn").hide()
    			 }
    			 else{
    				 return false
    			 }
    		 }
    		 else if(${info!=null}){
    			 $("#reportModal").modal('show')
    			 $("#reportRegistBtn").show()
    			 $("#reportModifyBtn").hide()
    			 $("#reportDeleteBtn").hide()
    		 } 
    		 else{
    			 alert("비회원은 이용하실 수 없습니다")
    		 }
    	 })
    	
    	 $("#reportRegistBtn").click(function(e){
    		 var reason=$("#reason").val()
    		 var details=$("#details").val()
    		 var data={"bno":${board.bno},"reporter":"${info.user_name}",
    					"reason":reason	,"details":details 
    		 }
    		 if(reason.length==0){
    			 alert("신고사유를 선택하세요")
    			 return false
    		 }
    		 if(details.length==0){
    			 data.details="세부내용없음"
    		 }
    		 $.ajax({
    			 type:'POST',
    			 data:data,
    			 url:'/reportRegist',
    			 dataType:'json',
    			 success: function(data){
    				alert(data.reporter+"님의 신고접수가 완료되었습니다")
    			 }
    		 })
   		
    		 $("#reportModal").modal('hide')
    		  reported =!reported 
    		  $("#reason option").each(function(){//신고사유의 옵션들을 하나씩가져와 비교후 reporter와 일치하면 selected로변경 	
    			  if($(this).val()== reason ){
				       $(this).attr("selected","selected"); // attr적용안될경우 prop으로 					
				    }					
				  });
    		  $("#details").val(details)
    		  reportButtonChange()
    	 })
    	 $("#reportModifyBtn").click(function(e){
    		 var reason=$("#reason").val()
    		 var details=$("#details").val()
    		 var data={"bno":${board.bno},"reporter":"${info.user_name}",
    					"reason":reason	,"details":details 
    		 }
    		 if(reason.length==0){
    			 alert("신고사유를 선택하세요")
    			 return false
    		 }
    		 if(details.length==0){
    			 data.details="세부내용없음"
    		 }
    		 $.ajax({
    			 type:'POST',
    			 data:data,
    			 url:'/reportRegist',
    			 dataType:'json',
    			 success: function(data){
    				alert(data.reporter+"님의 신고접수가 수정되었습니다")
    			 }
    		 })
    		 $("#reportModal").modal('hide')
    		 $("#reason option").each(function(){//신고사유의 옵션들을 하나씩가져와 비교후 reporter와 일치하면 selected로변경 
    					 if($(this).val()== reason ){
					       $(this).attr("selected","selected"); // attr적용안될경우 prop으로 					
					    }					
					  });
    		  $("#details").val(details)
    		  reportButtonChange()
    	 })
    	 
    	 $("#reportCloseBtn").click(function(e){
    		 $("#reportModal").modal('hide')
    	 })
    	 $("#reportDeleteBtn").click(function(e){
    		 var reason=$("#reason").val()
    		 var details=$("#details").val()
    		 var data={"bno":${board.bno},"reporter":"${info.user_name}",
    					"reason":reason	,"details":details 
    			}
    		 $.ajax({
    			 type:'POST',
    			 data:data,
    			 url:'/reportDelete',
    			 dataType:'json',
    		
    		 })
    		  $("#reportModal").modal('hide')
    		  reported =!reported 
    		  reportButtonChange()
    		 alert("${info.user_name} 님의 신고접수가 취소되었습니다")
    	 })
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

       })//ajax end
      }
      
      
 	 <!--신고여부 확인 후 이미지 테두리씌우는 함수  --> 
 	const reportButtonChange=()=>{
			 if(reported){
				 $(".reportText").css('color','red').text('신고완료')
			 }
			 else{
				 $(".reportText").css('color','black').text('신고')
			 } 
 	}
      
      var ckediters = CKEDITOR.replace('content', {
    		toolbarCanCollapse:true
    		
        })
  </script>
