<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>알림</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<br>
<br>

<div class="container">
<br>
<h2 align = "center">알림 구현</h2>
<br>

<nav class="navbar navbar-inverse">
<div class="container-fluid">
<div class="navbar-header">
<a class="navbar-brand" href="#">WebSiteName</a>
</div>

<ul class="nav navbar-nav navbar-right">
<li class="dropdown">
<a href="#" class="dropdown-toggle" data-toggle="dropdown">
<span class="label label-pill label-danger count"></span>
알림</a>
<!-- 알림 붙는 곳 -->
<ul class="dropdown-menu"></ul>
</li>

</ul>
</div>
</nav>

<br/>

<form method="post" id="comment_form">
<div class="form-group">
<label>제목</label>
<input type="text" name ="subject" id="subject" class="form-control" />
</div>

<div class="form-group">
<label>본문</label>
<textarea name ="comment" id="comment" class="form-control" rows="5"></textarea>
</div>

<div class="form-group">
<input type="submit" name ="post" id="post" class="btn btn-info" value="post"/>
</div>

</form>


</div>


</body>
</html>







