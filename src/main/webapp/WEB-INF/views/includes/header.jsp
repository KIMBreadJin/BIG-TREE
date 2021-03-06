<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html>
 
<html lang="en">
  
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
  	<script src="https://code.jquery.com/jquery-3.6.0.js" type="text/javascript"></script>
  	<link rel="stylesheet" type="text/css" href="/resources/css/header.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" >
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons" />
    <script src="/resources/js/ckeditor/ckeditor.js"></script>
    <script src="/resources/js/header.js"></script>
    <link
      rel="stylesheet"
      href="https://unpkg.com/bootstrap-material-design@4.1.1/dist/css/bootstrap-material-design.min.css"
      integrity="sha384-wXznGJNEXNG1NFsbm0ugrLFMQPWswR3lds2VeinahP8N0zJw9VWSopbjv2x7WCvX"
      crossorigin="anonymous"
    />
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header>
<nav class="navbar navbar-light bg-light ">
	<div class="text-title" style="float:none; margin:0 auto">
  		<a class="navbar-brand" href="/board/list"><h1 class="title1">Big Tree</h1><h1 class=title2> Community</h1></a>
  	</div>
 <div>
        <ul class="navbar-nav">
          <li class="nav-item dropdown messages-menu">
	            <a
	              class="nav-link dropdown-toggle"
	              href=""
	              id="navbarDropdownMenuLink"
	              data-toggle="dropdown"
	              aria-haspopup="true"
	              aria-expanded="false"             
	            >          
	              <i class="fa fa-envelope" aria-hidden="true"></i>
	              <span id="recMs" name="recMs" class="label label-success"></span>
	            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <ul class="dropdown-menu-over list-unstyled">
              <form action="/message/msgHeader" name="msgReForm" id="msgReForm">
                <li id = "cntMsgli" class="header-ul text-center"></li>                
             	<input type="submit" id="reMsg" value="&#xf021"/>
	          </form>
                <li>
                  <!-- inner menu: contains the actual data -->
                  <ul class="menu list-unstyled"> 
                  <!-- start message -->
                    <c:forEach items="${mlist}" var="mlist">                
                      <li>               
                        <a id="readM" href="/message/readMsg?mid=${mlist.mid}" onclick="window.open(this.href, '_blank', 'width=600, height=480'); return false;">
                          <div class="pull-left" id="user_profile">                           
                              ${mlist.sender_Image}
                              <c:if test="${mlist.sender_Image==null}">
                              <img src="/resources/images/basicProfileIcon.png">
                              </c:if>
                          </div>
                          <h4>
                            ${mlist.send_name}
                            <i class="fa fa-clock-o"></i> <small> ${mlist.creat_dt}</small>
                          </h4>
                          <p>${mlist.ms_content}</p>                
                        </a>
                        <form action="/message/deleteMsg" method="post" name="delForm">
                          <input type="hidden" name="mid" value="${mlist.mid}"/>
                          <input type="submit" id="deleteMsg" value="&#xf1f8"/>
                        </form>
                      </li>                      
                    </c:forEach>
                    <!-- end message -->
                  </ul>
                </li>
                <li class="footer-ul text-center"><a href="/message/msgList">??????????????? ??????</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
  <div class="row">
  	<div class="col-lg-12">
		  <c:if test="${info == null}">
		  <h7 class="page-header"><a href='/member/login'>?????????????????????</a></h7>
		  </c:if>
		  <c:if test="${info != null}">
		  <h7 class="page-header">
		 
		  ${info.user_name}??? ??????????????? <a href='/member/logout'>????????????</a></h7>
		  </c:if>
		  <br>
		  <button class="navbar-toggler float-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
		  	aria-expanded="false" aria-label="Toggle navigation" style="background-color:gray;">
		    <span class="navbar-toggler-icon"></span>
		  </button>
	</div>
</div>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto  float-right">
      <li class="nav-item active">
        <a class="nav-link" href="#" id="myPost">?????? ?????????<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#" id="goChat">????????? ??????</a>
      </li>
      <li class="nav-item active">
      <a class="nav-link" href=/qna/list id="qna">????????????</a>
      </li>
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle ${info!=null ? "": "disabled"}"" href="#" id="friend" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	??????
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item"  id="friendRequest">?????? ??????</a>
          <a class="dropdown-item"  id="friendList">?????? ??????</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item"  id="blockList">?????? ??????</a>
        </div>
      </li> 
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle ${info!=null ? "": "disabled"}"" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	?????? ?????? ??????/??????
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="/member/updatePwd">???????????? ??????</a>
          <a class="dropdown-item" href="/member/checkProfile">?????? ??????</a>
          <a class="dropdown-item" href="/member/checkPwd">?????? ??????</a>
      
      </li> 
      
		<form class="navbar-form" role="search" action="#" id="searchUser">
		    <div class="form-group">
		      <input type="text" class="form-control" placeholder="????????????" id="searchUserName">
		    	<p id="searchResult"></p>
		    </div>
	  	</form>
    </ul>
  </div>
</nav>

         <!-- ???????????????????????? modal    -->
			<div class="modal fade" id="memberList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
             
                    <h4 class="modal-title" id="myModalLabel">????????????</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
	 				<ul class="userList">
             
            		</ul>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn btn-info" id="memberListCloseBtn" type="button">??????</button>
                  </div>
                </div>
              </div>
            </div>
        <!-- ???????????????????????? modal end    -->
        
        <!-- ????????? ????????? ???????????? modal -->
        <div class="modal fade" id="memberInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">     
                    <h4 class="modal-title" id="myModalLabel">????????????</h4>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
                  	   <div class="form-group" id="profileImage" style="text-align:center;">
	                    <p class='text-center'>????????? ??????</p><img src="/resources/images/basicProfileIcon.png" width="80%">
	                  
	                  </div>
	                  <form class="form-horizontal" method="get" action="" name='sendMsgForm'>
	 					<div class="form-group">
	                    <label for="">?????????</label>
	                    <input type="text" class="form-control" name="user_id" id="memberId" readonly />
	                  </div>
	                  </form>
                      <div class="form-group">
                        <label for="">??????</label>
                        <input type="text" class="form-control" name="memberName" id="memberName" value=""  readonly />
                      </div>
                       <div class="form-group">
                        <label for="">????????? ???????????? </label><div class='btn btn-outline-primary float-right' id="showUserPost">????????????</div>
                        <input type="text" class="form-control" name="postCnt"  id="postCnt" value=""  readonly />
                      </div>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn " id="sendMsgBtn" type="submit"><img src="/resources/images/sendMsg.png" width="50px"></button>
                    &nbsp;&nbsp;&nbsp;                
                    <button class="btn " id="friendRegistBtn" type="button"><img src="/resources/images/friendRegistbtnIcon.jpg" width="50px"></button>
                    &nbsp;&nbsp;&nbsp;
                    <button class="btn btn-info" id="memberInfoCloseBtn" type="button" width="50px">??????</button>
                  </div>
                </div>
              </div>
            </div>
         <!-- ????????? ????????? ???????????? modal end -->

         <div class="modal fade" id="requestList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header" style="margin:0;padding:0;">
                   <nav class="navbar " style="width:248px;margin:0;padding:0;">
					  <form class="form-inline" style="margin:0;padding:0;">
					    <button class="btn btn-outline-secondary" type="button" style="width:248.66px;" id="requestSent"><h3>?????? ??????</h3></button>
					  </form>  
					</nav>
					 <nav class="navbar" style="width:248px;margin:0;padding:0;">
					  <form class="form-inline" >
					    <button class="btn btn-outline-secondary" type="button" style="width:248.66px" id="requestReceived"><h3>?????? ??????</h3></button>
					  </form>  
					</nav>
                  </div>
                  <!-- modal-header -->
                  <div class="modal-body">
	 				<ul class="requestResultList">
             			
            		</ul>
                  </div>
                  <!-- modal-body -->
                  <div class="modal-footer">
                    <button class="btn btn-info" id="requestListCloseBtn" type="button">??????</button>
                  </div>
                </div>
              </div>
            </div>
         
         
</header>
 <style>
	  .navbar.navbar-light.bg-light{
		  position:relative;
		  z-index:1;
	  }
	  
	  .navbar.navbar-light.bg-light:after {
	  	background-image:url('/resources/images/big_tree_header_back.jpg') !important;
	  	opacity:0.3;
	  	top:0;
	  	left:0;	 
	  	position:absolute; 	
	  	z-index:-1;
	  	content:"";
	  	width:100%;
	  	height:100%;
	  }
	a{
		font-weight:bold;
	}
	#sendMsgBtn{
		margin:0;
		padding:0;
	}
	#friendRegistBtn{
		margin:0;
		padding:0;
	}
	.userList img{
		width:45px;
		height:45px;
	}
	.requestResultList img{
		width:45px;
		height:45px;
	}
	#profileImage img{
		width:373px;
		height:373px;
	}
	
  </style>
  
<script type="text/javascript">
var requestCnt=0;
var cnt=0;
var timer=null;
var targetId=""
var clicked={
		"rejectClicked":false,
		"acceptClicked":false,
		"blockClicked":false,
		"deleteClicked":false,
		"friendListClicked":false,
		"blockListClicked":false,
		}

const rejectClicked=()=>{//???????????? ??????????????? 
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['rejectClicked']=true	
}
const acceptClicked=()=>{//???????????? ????????????
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['acceptClicked']=true
}
const blockClicked=()=>{//???????????? ?????????
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['blockClicked']=true
}
const deleteClicked=()=>{//???????????? ???????????? ?????????
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['deleteClicked']=true
}

const blockListClicked=()=>{
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['blockListClicked']=true
}
const friendListClicked=()=>{
	for(let i in clicked){
		clicked[i]=false
	}
	clicked['friendListClicked']=true
}


const resetClicked=()=>{
	for(let i in clicked){
		clicked[i]=false
	}
}

$(document).on('click','#resultNameList',function(e){//???????????? ???????????? ??????????????? ??????
	var getUrl="/"
		for(let key in clicked){
			if(clicked[key]){
				getUrl += key
			}	
		}
		if(getUrl=="/" || getUrl=="/blockListClicked" || getUrl=="/friendListClicked") return false
		$.ajax({
			type:'get',
			url:getUrl,
			data:{
				"receiver_id":getUrl=="/deleteClicked" ?  receiver_id: "${info.user_id}",
				"send_id":getUrl=="/deleteClicked" ? "${info.user_id}" :receiver_id 
			},
			success:function(data){
				alert(data)
				$(".requestResultList").modal('hide')
				$(".requestResultList").modal('show')
				getUrl=="/deleteClicked" ? 
						$("#requestSent").trigger('click'):
						$("#requestReceived").trigger("click")
				$(".modal-backdrop").remove()
				if(getUrl=="/acceptClicked"){
					sock.send("${info.user_id}"+","+receiver_id+","+ "?????? ??????")
				}
				resetClicked()
				
			}
		})
})



$(document).ready(function(){
	$("#memberInfo").on('hidden.bs.modal',function(e){
		
    	if($("#memberInfo").find('img').length==4){
			 $("#memberInfo").find('img')[1].remove()
		 }
	   
	})
	var userList;
	var userName= $("#searchUserName").val()
	$('#goChat').click( function (e) {
		e.preventDefault()
	    window.open('/chat/chatList',"????????????,","width=550,height=345")
	    window.resizeTo(550,345); 
	    return false;
	 })		 
	 $("#searchUser").submit(function(e){
		 e.preventDefault()
		 if($("#searchUserName").val().length<2){
			 alert("????????? ??????????????? ?????? ????????? ?????? ??????????????????")
			 return false;
		 }
		 
		 userName= $("#searchUserName").val()
		 $.ajax({
			 type:'get',
			 url:'/searchUser',
			 data:{
				 user_name:userName
			 },
			 success: function(data){
				 if(data==0){
					 $("#searchResult").css('color','red').text("??????????????? ????????????.")
				 }
				 else{
					 $("#searchResult").css('color','blue').text(data+'?????? ??????????????? ???????????? (????????????)')
				 }
			 }
		 })//end ajax
	 }) 
		 $("#searchResult").click(function(e){//???????????? ???????????? ????????????
			 var userName= $("#searchUserName").val()//?????????
			 var str=""
			$.ajax({
				type:'get',
				url:'/getUserList',
				data:{
					user_name:userName//?????????
				},
				success:function(list){
					 $(".userList").html('')
					 for (var i = 0, len = list.length || 0; i < len; i++) { 	
		                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'>"
		                    str += list[i].user_profileImage!=null ? 
		                    		list[i].user_profileImage
		                    		: "<img src='/resources/images/basicProfileIcon.png' />" 
		                    str += "<strong class='primary-font' >" + list[i].user_name + '</strong><p>'+list[i].user_id + '</p>'
		                    str += " </div>"
		                    str += '</div></li>'
		                  }
					 if (list == null || list.length == 0) {			              
						 str="<div>?????? ?????? ??????!</div>"
					 }
					$(".userList").html(str)
					$("#memberList").modal('show')
				},
				error:function(data){
					console.log("??????"+data)
				}
			})//end ajax
		 })//end click
		
		 $(".requestResultList").on("click","li",function(){
			 receiver_id=$(this).find('p').text()
			$("#memberName").val($(this).data('name'))
			$("#memberId").val(receiver_id)
		 })
		 
		 $(".userList").on("click","li",function(e){
			 var send_id="${info.user_id}"
			var receiver_id=$(this).find('p').text()
			 if(clicked['friendListClicked']==true){
				    $("#memberList").modal('hide')
		 		 }
	 		 else if(clicked['blockListClicked']==true){
	 			$("#memberList").modal('hide')
	 		 }
			 else{
				 $.ajax({
					 type:'get',
					 url:'/getUser',
					 data:{
						"user_name":receiver_id
						},
					success:function(data){
						$("#memberName").val(data.user_name)
						$("#memberId").val(data.user_id)
						$("#postCnt").val(data.boardCnt)
						if(data.user_profileImage!=null){
							$("#profileImage").find('img').hide()
							$("#profileImage").append(data.user_profileImage)
						}
						else{
							$("#profileImage").find('img').show()
						}
					}
				 }) 
				 
				 $("#memberInfo").modal('show') 
			 }
			 
			 resetClicked()
		 })
		 	 
		 
		 $("#memberListCloseBtn").click(function(e){
			$("#memberList").modal('hide')
		 })
		 $("#memberInfoCloseBtn").click(function(e){
			 
			$("#memberInfo").modal('hide')
		 })
		 $("#requestListCloseBtn").click(function(e){
			 $("#requestList").modal('hide')
		 })

		$("#friendRegistBtn").click(function(e){
			var send_id="${info.user_id}"
			var receiver_id=$("#memberId").val()
			if( confirm("??????????????? ??????????????????????\n "
					+"??????  :  "+$("#memberName").val()+
					"\n?????????: "+receiver_id		
			 )){//?????? ????????????
				if(${info.user_id==null}){
					alert("???????????? ????????? ??? ????????????.")
					return false;
				}
			    
				else if("${info.user_id}"==receiver_id){
					alert("??????????????? ????????? ??? ????????????")
					return false
				}
			 
				else{$.ajax({
						type:'get',
						url:'/registFriend',
						contentType: 'application/json; charset=utf-8',
						data:{
							send_id:send_id,
							receiver_id:receiver_id,
						},
						success:function(data){
							alert(data)
							if(data.includes("??????")){
								sock.send(send_id+","+receiver_id+","+ "?????? ??????")
							}
						}
					})
				}
				
			}
		})	
		$("#friendRequest").click(function(e){//???????????? ????????? ???????????????????????? trigger??? ????????? ??????????????? ?????????????????? ?????? 
			e.preventDefault();
			$("#requestList").modal('show')
			$("#requestSent").trigger("click")
		})
	
		$("#requestReceived").click(function(e){//???????????? ?????????
			 $(".requestResultList").html('')
				$(this).attr('class','btn btn-secondary')
				$("#requestSent").attr('class','btn btn-outline-secondary')
				
				$.ajax({
					type:'get',
					url: '/requestReceived',
					data:{
						"receiver_id":"${info.user_id}"				
					},
					success:function(data){
						var str=""
						for (var i = 0, len = data['memberList'].length || 0; i < len; i++) {	
		                    str += "<li class='left clearfix' data-name='" + data['memberList'][i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'>"
	                    	str += data['memberList'][i].user_profileImage != null ? 
	                    			data['memberList'][i].user_profileImage :
	 	                    		"<img src='/resources/images/basicProfileIcon.png'/>"
		                    str += "<strong class='primary-font' >" + data['memberList'][i].user_name +'<div class="float-right" id="btns">'
		                    str += '<button class="btn btn-primary" id="accept" onclick="acceptClicked()">??????</button>'
				            str += '<button class="btn btn-danger" id="reject"  onclick="rejectClicked()">??????</button>'
				            str +='<button class="btn btn-secondary" id="block" onclick="blockClicked()">??????</button> </div>'
		                    str +='</strong><p>'+data['memberList'][i].user_id+'</p>'
		                    str += '</div></div></li>'
		                  }
						 if (data == null ||  data['requestList'].length == 0) {       
							 str="<div>?????? ?????? ??????!</div>"
						 }
						$(".requestResultList").append(str)
					}
				})
		})
		$("#requestSent").click(function(e){//???????????? ?????????
			 $(".requestResultList").html('')
				$(this).attr('class','btn btn-secondary')
				$("#requestReceived").attr('class','btn btn-outline-secondary')
				
				$.ajax({
					type:'get',
					url: '/requestSent',
					data:{
						"send_id":"${info.user_id}"				
					},
					success:function(data){
						var str=""
						for (var i = 0, len = data['memberList'].length || 0; i < len; i++) {
						 	
		                    str += "<li class='left clearfix' data-name='" + data['memberList'][i].user_name + "' id='resultNameList' style='margin:4px' >"
		                    str += " <div><div class='header'>"
	                    	str += data['memberList'][i].user_profileImage != null ? 
	                    			data['memberList'][i].user_profileImage :
	 	                    		"<img src='/resources/images/basicProfileIcon.png'/>"
		                    str += "<strong class='primary-font' >" + data['memberList'][i].user_name 
		                    str +='<div id="btns"><button class="btn btn-danger float-right" id="delete" onclick="deleteClicked()">??????</button></div>'
		                    str += '</strong><p>'+data['memberList'][i].user_id + '</p>'
		                    str += " </div>"
		                    str += '</div></li>'
		                  }
						 if (data == null ||  data['requestList'].length == 0) {
							 str="<div>?????? ?????? ??????!</div>"
						 }
						$(".requestResultList").html(str)
					}
				})	
		})
		
		$("#showUserPost").click(function(e){
			$("#actionForm").find('input[name="pageNum"]').val(1)
			$("#actionForm").find('input[name="amount"]').val(20)
			$("#actionForm").find('input[name="type"]').val('D')
			$("#actionForm").find('input[name="keyword"]').val($("#memberId").val())
			if($("#postCnt").val()!=0){
				$("#actionForm").submit()	
			}
			else{
				alert("????????? ???????????? ???????????? ????????????.")
			}
		})
		$("#myPost").click(function(e){
			$("#actionForm").find('input[name="pageNum"]').val(1)
			$("#actionForm").find('input[name="amount"]').val(20)
			$("#actionForm").find('input[name="type"]').val('D')
			$("#actionForm").find('input[name="keyword"]').val("${info.user_id}")

			$("#actionForm").submit()	
			
		})
			
	 })//end document

	 $("#friendList").click(function(e){
		$(".userList").html('')
		var str=""
		$.ajax({
			type:'get',
			url:'/getFriendList',
			data:{
				user_id:"${info.user_id}"
			},
			success:function(list){
				 for (var i = 0, len = list.length || 0; i < len; i++) { 	
	                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
	                    str += " <div><div class='header'>" 
	                    str += list[i].user_profileImage != null ? 
	                    		list[i].user_profileImage :
	                    		"<img src='/resources/images/basicProfileIcon.png'/>"
	                    str += "<strong class='primary-font' >" + list[i].user_name + '<button class="btn btn-danger float-right" id="getDelete" onclick="friendListClicked()">????????????</button>'
	                    str +='</strong><p>'+list[i].user_id + '</p>'
	                    str += " </div>"
	                    str += '</div></li>'
	                  }
				 if (list == null || list.length == 0) {			              
					 str="<div>?????? ?????? ??????!</div>"
				 }
				$(".userList").html(str)
				$("#memberList").modal('show')
			},
			error:function(data){
				console.log("??????"+data)
			}
		})//end ajax
	  })
	  
	  $("#blockList").click(function(e){
		$(".userList").html('')
		var str=""
		$.ajax({
			type:'get',
			url:'/getBlockList',
			data:{
				user_id:"${info.user_id}"
			},
			success:function(list){
				 for (var i = 0, len = list.length || 0; i < len; i++) { 	
	                    str += "<li class='left clearfix' data-name='" + list[i].user_name + "' id='resultNameList' style='margin:4px' >"
	                    str += " <div><div class='header'>"
                   	    str += list[i].user_profileImage != null ? 
	                    			list[i].user_profileImage :
	                    			"<img src='/resources/images/basicProfileIcon.png'/>"
	                    str += "<strong class='primary-font' >" + list[i].user_name + '<button class="btn btn-secondary float-right" id="getDelete" onclick="blockListClicked()">????????????</button></strong><p>'+list[i].user_id + '</p>'
	                    str += " </div>"
	                    str += '</div></li>'
	                  }
				 if (list == null || list.length == 0) {			              
					 str="<div>?????? ?????? ??????!</div>"
				 }
				$(".userList").html(str)
				$("#memberList").modal('show')
			},
			error:function(data){
				console.log("??????"+data)
				}
		})//end ajax
	 
		
		
		
	 
	  })
	 $(document).on("click","button.ml-2",function(){//?????? x????????? ?????? ?????? ?????? 
		  $(this).parent().parent().remove()
	  })
	 $(document).on("click","#msgRequestFriend",function(){//???????????? ???????????????????????????
		  $("#friendRequest").trigger('click')
		  $("#requestReceived").trigger('click')
		  $(this).parent().parent().remove()
	 })
	  $(document).on("click","#msgMyFriend",function(){//???????????? ???????????????????????????
		  $("#friendList").trigger('click')
		  $(this).parent().parent().remove()
	 }) 
	 $(document).on("click","#getDelete",function(){
		 var send_id=$(this).parent().parent().find('p').text();
		 var receiver_id="${info.user_id}"
		 
		 $.ajax({
			 type:'get',
		 	 url:'/getDelete',
		 	 data:{
		 		 "send_id":send_id,
		 		 "receiver_id":receiver_id
		 	 },
		 	 success:function(data){
		 		 alert(data)
		 		
		 	 }
		 })
	 })
	 
 	 $(document).keydown(function(event) {
	    if ( event.keyCode == 27 || event.which == 27 ) {
	    	if($("#memberInfo").find('img').length==4){
				 $("#memberInfo").find('img')[1].remove()
			 }
	    }
	 });
</script>
<body>
<div id="msgStack"></div>
</body>
</html> 


 


