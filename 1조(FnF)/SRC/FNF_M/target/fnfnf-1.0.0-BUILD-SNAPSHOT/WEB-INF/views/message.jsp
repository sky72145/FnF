<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//    HttpSession Session = request.getSession(true);
//    String user_id = "6666";//String sellerid = request.getParameter("id");// id=넘어오는 name값
//    Session.setAttribute("user_id", user_id); //test를 user_id세션에 저장
//    //${sessionScope.user_id}

//    String inquiry_user_id = (String)Session.getAttribute("user_id");//user_id 세션의 값 ="writer"
  %>

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
$(function(){
	//취소버튼 
	$("#btnCancle").on("click",function(){
		 history.back();	 //뒤로가기
	 });
	
	 //보내기 버튼
	 $("#btnSend").on("click",function(){
		if($("#receive_id").val() =="") alert("받는 사람을 적어주세요.");
		else if($("#txtTitle").val() =="") alert("제목을 적어주세요.");
		else if($("#txtContents").val() =="") alert("내용을 적어주세요.");
		else{//다 체워 졌을 때
			$.ajax({
				 url : "/sendMSG",  //--> controller   /sendMSG
				 dataType : "json",  //받는 type
				 method : "POST",  //controller  RequestMethod.POST
				 contentType : "application/json; charset=UTF-8",	//보내는 Type
				 data : JSON.stringify({
					 "send_id" :  $("#send_id").val(),
					 "receive_id" : $("#receive_id").val(),
					 "title" : $("#txtTitle").val(),
					 "contents" : $("#txtContents").val()
				 }),
				 success : function(data){
					 if(data.code){
						 alert("메시지를 보냈습니다.");
						 location.href="/sellerSMSG"; //seller면 sellerSMSG user면 userSMSG
					 }else alert("메시지 전송을 실패했습니다.");
				 },
				 error : function(err){
					 console.log("err 발생 : " + err);
				 }
			 });
		}
	 })
	 
	//user_id 있는지 없는지 검사
    $("#receive_id").change(function() {
        var receive_id =  $("#receive_id").val();
        $.ajax({
            async: true,
            type : 'POST',
            data : receive_id,
            url : "/useridcheck",
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data) {
            	if($("#receive_id").val() == $("#send_id").val()){
                	alert("자신에게 보낼 수 없습니다.");
                	$("#btnSend").prop('disabled', true);
                }
            	else if (data.cnt == 1) {
                    alert("해당 유저가 존재합니다. 메시지를 보내실 수 있습니다.");
                    $("#btnSend").prop('disabled', false);
                }else if(data.cnt == -1){
                	alert("받는 사람을 입력해주세요.");
                	$("#btnSend").prop('disabled', true);
                }else {
                	alert("받는 사람이 존재하지 않습니다.");
                    $("#btnSend").prop('disabled', true);
                }
            },
            error : function(error) {
                console.log("error : " + error);
            }
        });
        
    });
	 
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
<h1 style="text-align:center;margin-top: 0px;margin-bottom: 20px;">메시지 쓰기</h1>
		<div class="form-group">
			<label for="txtName" class="col-sm-3 control-label">보내는 사람</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="send_id" value="${sessionScope.user_id}" readonly="readonly">
			</div>
		</div>
		<div class="form-group">
			<label for="txtName" class="col-sm-3 control-label">받는 사람</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="receive_id"  placeholder="Recipient" >
			</div>
		</div>
		<div class="form-group">
			<label for="txtTitle" class="col-sm-3 control-label">제목</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="txtTitle"  placeholder="Title">
			</div>
		</div>
		<div class="form-group">
			<label for="txtTitle" class="col-sm-3 control-label">내용</label>
			<div class="col-sm-6">
				<textarea class="form-control" rows="5" id="txtContents" placeholder="Contents"></textarea>
			</div>
		</div>
		<div class="form-group">
			<div class="text-center">
				<button type="button" id="btnSend" class="btn btn-success" disabled>보내기</button>
				<button type="button" id="btnCancle" class="btn btn-danger">취소하기</button>
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