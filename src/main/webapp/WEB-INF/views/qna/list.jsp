<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp" %>
<style>
ul.pagination{
    width: 300px;
  margin-left: auto;
  margin-right: auto;
}


th.th1{
	width:50px;
	
}
th.th2{
	width:300px;
	
}
th.th3{
	width:100px;
	
}
td{
text-align:center;
}
tr{
text-align:center;
}

/* a태그의 move 클래스에 hover효과  */
td{
font-size: 25px;
}
a.move{
  position: relative;
  
  
}
a.move:after{
  content: "";
  position: absolute;
  left: 0;
  bottom: 1px;
  width: 0px;
  height: 5px;
  margin: 5px 0 0;
  transition: all 0.2s ease-in-out;
  transition-duration: 0.3s;
  opacity: 0;
  background-color: #FFADC5;
}
a.move:hover:after{
  width: 100%;
  opacity: 1;
}



</style>
<!-- /.row body내용-->
<div class="row">
  <div class="col-lg-12">
    
  	<!-- /.col-lg-12 -->
  	  <div class="panel-heading">
        <div class="panel-heading head-title">문의 게시판</div>
       
        <button id="regBtn" type="button" class="btn btn-outline-success">새로운 게시글 등록</button>      	
      </div>      
		<br>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <table  class="table table-hover" id="dataTables-example">
          <thead>
            <tr class="table-success">
              <th class="thNum">번호</th>
              <th class="thTitle">제목</th>
              <th class="thWriter">작성자</th>
              <th class="thRegdate">작성일</th>
            </tr>
          </thead>
          <c:forEach items="${list}" var="qna">
            <tr >
              <td>${qna.qno}</td> <!-- 글번호 -->
              <td>
                     	
          	<c:if test="${qna.secret eq 'Y' }">
         	<a class='move' href='${qna.qno}'>${qna.title}</a>
         	</c:if>      		
         	<c:if test="${qna.secret eq 'N' }">
			<c:choose>			
                <c:when test= "${info.user_type eq 1||info.user_name eq qna.writer}">
                    <a class='move' href='${qna.qno}'><c:out value="${qna.title}"/></a>
                </c:when>              
               <c:otherwise><a class='move2' href=''>비밀글은 작성자와 관리자만 볼 수 있습니다.</a></c:otherwise>              
            </c:choose>
         	</c:if>          	         	
               
            </td> <!-- 제목 -->
              <td>${qna.writer}</td> <!-- 작성자  -->
              <td><fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd" /></td>           
            </tr>
          </c:forEach>
        </table>
        <div class="row">
          <div class="col-lg-12">
            <form class="form-inline my-2 my-lg-0" action="/qna/list" id="searchForm" method="get">
              <select name="type" class="form-control" style="border:2px solid rgba(0,0,0,.26);">
                <option value="TWC" 
                	<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>전체</option>
                <option value="T" 
                	<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
                <option value="C"
                	<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>> 내용</option>
                <option value="W"
                	<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
                <option value="TC"
                	<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 또는 내용</option>
                <option value="TW"
                	<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 또는 작성자</option>
                
              </select>
              <input type="text" name="keyword" class="form-control"/>
              <input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}' class="form-control">
              <input type="hidden" name="amount" value='${pageMaker.cri.amount}' class="form-control">
              
              <button class="btn btn-outline-success">검색</button>
            </form>
          </div>
        </div>    
        <br>     
          <ul class="pagination" >
            <c:if test="${pageMaker.prev}">
              <li class="page-item active">
                <a class="page-link" href="${pageMaker.startPage-1}">&laquo;</a> <!-- &laquo;는 이전페이지가 화살표모양(<<)으로 바뀜 -->
              </li>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
              <li class="page-item button ${pageMaker.cri.pageNum==num ? "active" : ""}">
                <a class="page-link" href="${num}">${num}</a>
              </li>
            </c:forEach>
            <c:if test="${pageMaker.next}">
              <li class="page-item">
                <a class="page-link" href="${pageMaker.endPage+1}">&raquo;</a>
              </li>
            </c:if>
          </ul>
        <!--  end pagination -->
        <form class="d-flex" action="/qna/list" id='actionForm' method="get">
        	<input class="form-control me-sm-2" type='hidden' name="pageNum" value="${pageMaker.cri.pageNum}">
        	<input class="form-control me-sm-2" type='hidden' name="amount" value="${pageMaker.cri.amount}">
        	<input class="form-control me-sm-2" type="hidden" name="type" value='${pageMaker.cri.type}'>
            <input class="form-control me-sm-2" type="hidden" name="keyword" value='${pageMaker.cri.keyword}'>
            
        </form>
        <!-- 모달 추가 -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              
              <div class="modal-body">처리가 완료되었습니다.</div>
              <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">닫기</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      <!-- /.panel-boby -->
    </div>
    <!-- /.panel -->
  </div>
<!-- /.row -->
<script>
  $(document).ready(function () {
    var result = '<c:out value="${result}"/>'
    checkModal(result)
    console.log($("#pageNumber"))
    history.replaceState({}, null, null) //추가
    function checkModal(result) {
      if (result === '' || history.state) return
      //register에서 등록하면 result에 정보가 담기지만 list에서  refresh하면
      //result에 값이 없어서 반환함
      if (parseInt(result) > 0) $('.modal-body').html('게시글 ' + parseInt(result) + ' 번이 등록되었습니다.')
      $('#myModal').modal('show')
    }
    $('#regBtn').click(function () {
    	 if(${info.user_name!=null}){
    		 self.location = '/qna/register'
    	 }
    	 else(alert("비회원은 이용할 수 없습니다."))

    })
    var actionForm = $("#actionForm");
   $(".page-item.button a").click(function(e){
	   e.preventDefault();
	   console.log($(this).attr("href"))
	   
	   var thisis = $(this).attr("href"); 
	   console.log("페이지 로직이 눌렸어요",thisis);
	   actionForm.find("input[name='pageNum']").val(thisis);
	   actionForm.submit();// 추가 
   })
   $(".move").click(function(e){
	   e.preventDefault();
	   
     var qno=$("input[name=qno]").val()
/*       if(${info.user_type != 1 || info.user_name != qna.writer}){
    	 alert("비밀글은 작성자와 관리자만 볼 수 있습니다.")
  	   
     }  */
     if(qno){
    	 qno=$(this).attr('href')
    	 actionForm.append("<input type='hidden' name='qno' value='" +qno+"'>");
     }
     else{  
    	 actionForm.append("<input type='hidden' name='qno' value='" +$(this).attr("href")+"'>");
     }
	   console.log($(this).attr('href'))
	   actionForm.attr("action","/qna/details");
	  actionForm.submit();
   })
   
   $(".move2").click(function(e){
	   e.preventDefault();
   		alert('비밀글은 작성자와 관리자만 볼 수 있습니다.')
   })

   var searchForm = $("#searchForm");
   $("#searchForm button").click(function(e){
	   console.log("버튼눌림")
	   if(!searchForm.find("option:selected").val()){
		   alert("검색 종류를 선택하세요");
		   return false;
	   }
	  
	   searchForm.find("input[name='pageNum']").val("1");
	   e.preventDefault();
	   searchForm.submit();
	   
	   //브라우저에서 검색 버튼을 클릭하면 form 태그의 전송은 막고 페이지의 번호는 1이 되도록 처리 
	   //화면에서 키워드가 없으면 검색을 허용하지 않음 
   })

  })
</script>



