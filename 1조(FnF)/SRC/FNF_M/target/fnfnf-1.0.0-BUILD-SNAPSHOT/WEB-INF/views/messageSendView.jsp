<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="msg" value="${data}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피셔스 앤 파머스</title>
<!-- Font awesome -->
<link href="css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">   
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css" href="css/jquery.simpleLens.css">    
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css" href="css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="css/theme-color/default-theme.css" rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="css/sequence-theme.modern-slide-in.css" rel="stylesheet" media="all">
<!-- Main style sheet -->
<link href="css/style1.css" rel="stylesheet">    
<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
<link href="css/sidebar.css" rel="stylesheet">
<link href="css/style2.css" rel="stylesheet">
<script src="js/jquery.min.js"></script> 
<script>
var idx = null;
$(function(){
	var idx = ${msg.idx};
	
	$("#btnDelete").on("click",function(){
		if(confirm('삭제 처리를 진행하시겠습니까?')){
			$.ajax({
				url : "/viewSMSG/"+parseInt(idx),
				//dataType: "json", RequestBody로 받을거 아니면 안적어두 된다.
				method : "PUT",
				success : function(data){
					alert("메시지가 삭제되었습니다.");
					location.href="/sellerSMSG";
				},
				error : function(err){
					console.log("err 발생 : " + err);
				}
			});
		}else{
			return;
		}
	});
	
	//목록버튼
	$("#btnList").on("click",function(){
		 history.back();	 //뒤로가기
	 });
	var contents = "${msg.contents}";
	contents = contents.replace(/\'\'/gi, "'"); 
	contents = contents.replace(/\&lt\;/gi, "<");
	contents = contents.replace(/\&gt\;/gi, ">");
	contents = contents.replace(/\<br\>/gi, "\r\n");
	$("#txtContents").val(contents);
});//function()

</script>
</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->




	<form class="form-horizontal">
	<p style="margin-bottom: 0px;">&nbsp;</p>
<h1 style="text-align:center;margin-top: 0px;margin-bottom: 20px;">보낸 메시지 확인</h1>
		<div class="form-group">
			<label for="txtName" class="col-sm-3 control-label">보낸 사람</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="send_id" readonly="readonly" value="${msg.send_id}">
			</div>
		</div>
		<div class="form-group">
			<label for="txtName" class="col-sm-3 control-label">받은 사람</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="receive_id" readonly="readonly" value="${msg.receive_id}">
			</div>
		</div>
		<div class="form-group">
			<label for="txtTitle" class="col-sm-3 control-label">제목</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="txtTitle"   readonly="readonly" value="${msg.title}">
			</div>
		</div>
		<div class="form-group">
			<label for="txtTitle" class="col-sm-3 control-label">내용</label>
			<div class="col-sm-6">
				<textarea class="form-control" rows="5" id="txtContents" readonly="readonly" ></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="text-center">
				<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>&nbsp;&nbsp;
				<button type="button" id="btnList" class="btn btn-info">목록</button>
			</div>
		</div>
	</form>


<!-- ------------------------------------------------------- -->
<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
 
  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="js/sequence.js"></script>
  <script src="js/sequence-theme.modern-slide-in.js"></script>  
  <!-- Product view slider -->
  <script type="text/javascript" src="js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="js/custom.js"></script> 
</body>
</html>