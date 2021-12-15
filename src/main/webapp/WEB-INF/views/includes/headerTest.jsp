<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html lang="ko">
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="" />
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <link rel="stylesheet" type="text/css" href="/resources/css/header.css" />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <script src="/resources/js/ckeditor/ckeditor.js"></script>
  <head>
  <script type="text/javascript">
	function passMin(e){
	  	var now = new Date()
	  	var old = e
  		console.log("passMin" + old)
	  	old = Date.parse(old)	  	
	  	var passDay = Math.floor((now - old)/(1000*60*60*24))
	  	var passH = Math.floor((now - old)/(1000*60*60))	 
	  	var passM = Math.floor((now - old)/(1000*60))
	  	console.log(passH , passM)
	  	if (passH == 0) {return  $("#passTime").val('passM + " mins ago"')}
	  	if (passDay == 0) {return  $("#passTime").val(passH + " hours ago");}	
	  	else {return  $("#passTime").val(passDay +" days ago")}
	}
  </script>
  </head>

  <header>
    <nav class="navbar navbar-light bg-light">
      <div style="float: none; margin: 0 auto">
        <a class="navbar-brand" href="/board/list"><h3>Big Tree Community</h3></a>
      </div>
      <div>
        <ul class="navbar-nav">
          <li class="nav-item dropdown messages-menu">
            <a
              class="nav-link dropdown-toggle"
              href="http://example.com"
              id="navbarDropdownMenuLink"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              <i class="fa fa-envelope" aria-hidden="true"></i>
              <span class="label label-success">${cntMsg}</span>
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <ul class="dropdown-menu-over list-unstyled">
                <li class="header-ul text-center">You have ${cntMsg} messages</li>
                <li>
                  <!-- inner menu: contains the actual data -->
                  <ul class="menu list-unstyled"> 
                  <!-- start message -->
                    <c:forEach items="${mlist}" var="mlist">                
                      <li>               
                        <a href="#">
                          <div class="pull-left">
                              <img src="http://via.placeholder.com/160x160" class="rounded-circle " alt="User Image">
                          </div>
                          <h4>
                            ${mlist.send_name}
                            <i class="fa fa-clock-o"></i> <small> ${mlist.creat_dt}</small>
                          </h4>
                          <p>${mlist.ms_content}</p>
                          <%-- <input type="text" id="creat_dt" value="${mlist.creat_dt}" />    --%>
                         <script>
                         	console.log("1")
                    	    passMin("${mlist.creat_dt}")                  	  	
                      	 </script>   
                          
                        </a>
                      </li>                      
                    </c:forEach>
                    <!-- end message -->
                  </ul>
                </li>
                <li class="footer-ul text-center"><a href="/message/msgList">See All Messages</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
      <div class="row">
        <div class="col-lg-12">
          <c:if test="${info == null}">
            <h7 class="page-header"><a href="/member/login">로그인하러가기</a></h7>
          </c:if>
          <c:if test="${info != null}">
            <span id="recMs" name="recMs" style="float: right; cursor: pointer; margin-right: 10px; color: pink"
              ><i class="fa fa-users"></i
            ></span>
            <h7 class="page-header">${info.user_name}님 반갑습니다 <a href="/member/logout">로그아웃</a></h7>
          </c:if>
          <br />
          <button
            class="navbar-toggler float-right"
            type="button"
            data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
            style="background-color: gray"
          >
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
      </div>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto float-right">
          <li class="nav-item active">
            <a class="nav-link" href="/board/list">홈<span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" id="goChat">실시간 채팅</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" id="goFind">친구찾기</a>
          </li>
          <li class="nav-item dropdown">
            <a
              class="nav-link dropdown-toggle ${info!=null ?"": "disabled"}""
              href="#"
              id="navbarDropdown"
              role="button"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              나의 정보 조회/수정
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">action</a>
              <a class="dropdown-item" href="#">Another action</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="#">Something else here</a>
            </div>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <style>
    .navbar.navbar-light.bg-light {
      position: relative;
      z-index: 1;
    }

    .navbar.navbar-light.bg-light:after {
      background-image: url('/resources/images/big_tree_header_back.jpg') !important;
      opacity: 0.3;
      top: 0;
      left: 0;
      position: absolute;
      z-index: -1;
      content: '';
      width: 100%;
      height: 100%;
    }
    a {
      font-weight: bold;
    }
  </style>
  <script>
    $(document).ready(function () {
      $('#goChat').click(function (e) {
        e.preventDefault()
        window.open('/chat/chatList', '채팅목록,', 'width=700,height=430')
        window.resizeTo(700, 430)
        return false
      })
      $('#goFind').click(function (e) {
        e.preventDefault()
        window.open('/member/findFrd', '친구찾기,', 'width=1100,height=700')
        window.resizeTo(700, 430)
        return false
      })
    })
  </script>
</html>