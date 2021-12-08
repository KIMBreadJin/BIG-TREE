<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" %>
<%@ include file="../includes/header.jsp" %>

<!-- /.row -->
<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading">
        게시판 목록 페이지
        <button id="regBtn" type="button" class="btn btn-primary btn-raised float-right">새로운 게시글 등록</button>
      </div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
          <thead>
            <tr>
              <th width="50px">번호</th>
              <th width="500px">제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>조회수</th>
            </tr>
          </thead>
          <c:forEach items="${list}" var="board">
            <tr>
              <td>${board.bno}</td>
              <td id="tdTitle"><a class='move' href='${board.bno}'> ${board.title}
              	<b>[${board.replyCnt}]</b>
              </a></td>
              <td>${board.writer}</td>
              <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd" /></td>
              <td>${board.views}</td>
            </tr>
          </c:forEach>
        </table>
        <div class="row">
          <div class="col-lg-12">
            <form action="/board/list" id="searchForm" method="get">
              <select name="type">
                <option value="" <c:out value="${pageMaker.cri.type==null?'selected':''}"/>>type</option>
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
                <option value="TWC" 
                	<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 또는 작성자 또는 내용</option>
              </select>
              <input type="text" name="keyword"/>
              <input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
              <input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
              
              <button class="btn btn-primary">검색</button>
            </form>
          </div>
        </div>
         <nav aria-label="Page navigation example" class="float-right">
          <ul class="pagination justify-content-center">
            <c:if test="${pageMaker.prev}">
              <li class="page-item">
                <a class="page-link" href="${pageMaker.startPage-1}">이전</a>
              </li>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
              <li class="page-item button ${pageMaker.cri.pageNum==num ? "active": ""}">
                <a class="page-link" href="${num}">${num}</a>
              </li>
            </c:forEach>
            <c:if test="${pageMaker.next}">
              <li class="page-item">
                <a class="page-link" href="${pageMaker.endPage+1}">다음</a>
              </li>
            </c:if>
          </ul>
        </nav>
      
        <!--  end pagination -->
        <form action="/board/list" id='actionForm' method="get">
        	<input type='hidden' name="pageNum" value="${pageMaker.cri.pageNum}">
        	<input type='hidden' name="amount" value="${pageMaker.cri.amount}">
        	<input type="hidden" name="type" value='${pageMaker.cri.type}'>
            <input type="hidden" name="keyword" value='${pageMaker.cri.keyword}'>
            
        </form>
        <!-- 모달 추가 -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <button class="close" data-dismiss="modal" type="button">&times;</button>
              <h4 class="modal-title" id="myModalLabel">모달 제목</h4>
              <div class="modal-body">처리가 완료되었습니다.</div>
              <div class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal">닫기</button>
                <button class="btn btn-primary" type="button">변경된 내용 저장</button>
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
  <!-- /.col-lg-12 -->
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
      self.location = '/board/register'
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
     var bno=$("input[name=bno]").val()
     if(bno){
    	 bno=$(this).attr('href')
    	 actionForm.append("<input type='hidden' name='bno' value='" +bno+"'>");
     }
     else{  
    	 actionForm.append("<input type='hidden' name='bno' value='" +$(this).attr("href")+"'>");
     }
	   console.log($(this).attr('href'))
	   actionForm.attr("action","/board/details");
	  actionForm.submit();
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

