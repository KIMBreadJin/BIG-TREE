<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<%@ include file="../includes/header.jsp" %>
  <script src="/resources/js/ckeditor/ckeditor.js"></script>
  <body>
    <!-- -------------------게시글 조회--------------------------- -->
    <!-- /.row -->    
      <div class="col-lg-12">
        <div class="panel panel-default">
          <div class="panel-heading">문의게시판 페이지</div>
          <!-- /.panel-heading -->
          <div class="panel-body">
            <div class="form-group">
              <label for="title">번호</label>
              <input type="text" class="form-control" name="qno" value="${qna.qno}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="title">제목</label>
              <input type="text" class="form-control" name="title" value="${qna.title}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="writer">작성자</label>
              <input type="text" class="form-control" name="writer" value="${qna.writer}" readonly="readonly" />
            </div>
            <div class="form-group">
              <label for="content">내용</label>
              <textarea name="content" id="content" rows="3" class="form-control" readonly="readonly">${qna.content}</textarea>
            </div>
            <div>
                <button data-oper="modify" id="boardModifyBtn" class="btn btn-warning" type="submit">수정</button>
              <button data-oper="list" class="btn btn-info" type="submit">목록</button>           		                
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

            <form action="/qna/modify" method="get" id="operForm">
              <input type="hidden" id="qno" name="qno" value="${qna.qno}" />
              <input type="hidden" name="pageNum" value="${cri.pageNum}" />
              <input type="hidden" name="amount" value="${cri.amount}" />
              <input type="hidden" name="keyword" value="${cri.keyword}" />
              <input type="hidden" name="type" value="${cri.type}" />
            </form>
          
        </div>
        <!-- /.panel -->
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
          url: '/replies2/new',
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
        var qno = param.qno
        var page = param.page || 1
        $.getJSON('/replies2/pages/' + qno + '/' + page + '.json', (data) => {
          if (callback) callback(data.replyCnt, data.list) //controller에서
          //반환되는 pageDTO
        }).fail(function (xhr, status, err) {
          if (error) error()
        })
      }
		const remove = (rno,callback,error)=>{
			$.ajax({
				type:'delete',
				url:'/replies2/' +rno,
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
				url:'/replies2/' + reply.rno,
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
			$.get("/replies2/" +rno +".json" , (result) =>{
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

      var qnoValue = '<c:out value="${qna.qno}"/>'
      var replyUL = $('.chat')
      const showList = (page) => {
        	 
	          replyService.getList({ qno: qnoValue, page: page || 1 }, (replyCnt,list) => {
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
          qno: qnoValue,
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
<script>
      $(document).ready(function (e) {

        <!-- 수정,목록가기 버튼 클릭시 호출함수 -->
    	 var operForm = $('#operForm')
        $("button[data-oper='modify']").click(function (e) {
          operForm.attr('action', '/qna/modify').submit()
        })
        $("button[data-oper='list']").click(function (e) {
          operForm.find('#qno').remove() //operForm 에서 id가 bno인 것을 찾아 데이터 삭제
          operForm.attr('action', '/qna/list').submit()
        })

      
      })
      
      

  </script>
