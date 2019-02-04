﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="notice" value="${data}" />
<c:set var="currentPage" value="${page}" />
<c:set var="currentIdx" value="${notice.idx}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>Fishers N Farmers</title>
    
    <link href="../../css/bootstrap.css" rel="stylesheet">  
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="../../css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="../../css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="../../css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="../../css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="../../css/theme.css" rel="stylesheet">
    <!-- Top Slider CSS -->
    <link href="../../css/slide.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="../../css/style2.css" rel="stylesheet">   


<style type="text/css">
h2{
	margin:80px 0 50px 0; 
	color:#3673be;
}
h3{
	text-align:center;
	margin:30px 0 30px 0;
}
#conarea{
	margin:80px 0 80px 0;
}
#btnarea{
	text-align:center;
	margin:30px 0 80px 0;
}
#viewform{
	background-color:#f9f9f9;
}
#file{
	text-align:center;
}
</style>

<script src="../../js/jquery.min.js"></script>
<script>
var idx = null;
$(document).ready(function() {
	idx = ${notice.idx};
	$("#txtIdx").val("${notice.idx}");
	$("#user_id").val("${notice.user_id}");
	$("#txtReadnum").val("${notice.readnum}");
	$("#btnCancel").bind("click", function() {
		history.back();
	});
	
	var contents = "${notice.contents}";
	   contents = contents.replace(/\'\'/gi, "'"); 
	   contents = contents.replace(/\&lt\;/gi, "<");
	   contents = contents.replace(/\&gt\;/gi, ">");
	   contents = contents.replace(/\<br\>/gi, "\n");
	   $("#conarea").text(contents);
	   
	$("#btnDelete").bind("click", function() {
		$.ajax({
			url : "/admin/cs/" + idx,
			method : "DELETE",
			success : function(data) {
				if (data.code) {
					alert("삭제되었습니다.");
					location.href = "/admin/cs";
				}
			},
			error : function(err) {
				console.log("Error 발생 : " + err);
			}
		});
	});
});


</script>
</head>
<body>
<!-- -------------------------------Header---------------------------------- -->
 <jsp:include page="header3.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->
<div class="col-sm-12">
<h2 class="text-center">공지사항</h2>
<hr>
	<form>
	
		<div class="row">
			<div class="col-md-offset-3 col-sm-6"  >
				<div class="aa-blog-content" style="word-break:break-all;overflow: auto" id=viewform>
					<h3><strong>${notice.title}</strong></h3>
					<div class="aa-boardarticle-info"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span id="txtIdx"><span class="glyphicon glyphicon-log-in" aria-hidden="true"></span> ${notice.idx}</span>&nbsp;
						<span id="user_id"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> ${notice.user_id}</span>&nbsp;
						<span id="txtWritedate"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> ${notice.writedate}</span>&nbsp;
						<span id="txtReadnum"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span> ${notice.readnum}</span>
					</div>
					<hr>
					<p style="text-align: center;" id="conarea">
					</p>
					<p id="file">
						<c:if test="${notice.filename != null}" >
							<img src="../../img/fileupload/${notice.filename}" width="600px" height="400px">
						</c:if>
						<c:if test="{notice.filename == null}" >
							<span></span>
						</c:if>
						
					</p>
				</div>
		
		<div class="row col-sm-offset-4 col-sm-8" id="btnarea">
			<div class="col-sm-2 aa-login-form">
				<button class="btn btn-primary" type="button" id = "btnCancel"> 목록</button>
			</div>
			<div class="col-sm-2 aa-login-form">
				<button class="btn btn-primary" type="button" onclick="location.href='/admin/cs/update/${currentPage}/${currentIdx}'"> 수정</button>
			</div>
			<div class="col-sm-2 aa-login-form">
				<button class="btn btn-primary" type="button" id="btnDelete"> 삭제</button>
			</div>
		</div>
			</div>
		</div>
		
	   	
		
	   	
	</form>
</div>
	
<!-- -------------------------------Footer---------------------------------- -->
<jsp:include page="footer.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->
	
</body>
</html>