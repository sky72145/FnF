<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%
String myid = (String)session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피셔스 앤 파머스</title>

<!-- Font awesome -->
<link href="/resources/css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="/resources/css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="/resources/css/jquery.smartmenus.bootstrap.css"
	rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="/resources/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="/resources/css/theme-color/default-theme.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="/resources/css/sequence-theme.modern-slide-in.css"
	rel="stylesheet" media="all">
<!-- Main style sheet -->
<link href="/resources/css/style1.css" rel="stylesheet">
<link href="/resources/css/style2.css" rel="stylesheet">
<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
 <link href="/resources/css/sidebar.css" rel="stylesheet">
<link href="/resources/css/fix.css" rel="stylesheet"> 
<script type="text/javascript" src="/resources/js/mymessage.js"></script>
 <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	var messageUL = $(".chat");
	var myid = '<c:out value="<%=myid%>"/>';
	showList(1);
	function showList(page){
		messageService.getrecList({receive_id:"<%=myid%>",page:page||1},function(list){
			var str="";
			if(list == null || list.length == 0){
				messageUL.html("");
				return;
			}
			for(var i=0, len=list.length||0;i<len;i++){
				str += "	<tr><td data-idx='"+list[i].idx+"'>"+list[i].idx+"</td>";
				str += "	<td data-idx='"+list[i].idx+"'>"+list[i].send_id+"</td>";
				str += "	<td data-idx='"+list[i].idx+"'>"+list[i].receive_id+"</td>";
				str += "	<td data-idx='"+list[i].idx+"'>"+list[i].title+"</td>";
				str += "	<td data-idx='"+list[i].idx+"'>"+list[i].status+"</td>";
				str += "	<td data-idx='"+list[i].idx+"'>"+list[i].writedate+"</td></tr>";
			}
			messageUL.html(str);
		});
	}
	var modal = $(".modal");
	var modalidx = modal.find("input[name='idx']");
	var modalSend_id = modal.find("input[name='send_id']");
	var modalreceive_id = modal.find("input[name='receive_id']");
	var modaltitle = modal.find("input[name='title']");
	var modalcontents = modal.find("textarea[name='contents']");
	
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	
	$("#btnList").on("click",function(e){
		modal.find("input").val("");
		modalRegisterBtn.show();
		modal.find("button[id!='modalRegisterBtn']").hide();
		$(".modal").modal("show");
	});
	$(".chat").on("click","td",function(e){
		var idx = $(this).data("idx");
		messageService.get(idx,function(message){
			modalSend_id.val(message.send_id);
			modalreceive_id.val(message.receive_id);
			modaltitle.val(message.title);
			modalcontents.val(message.contents);
			modal.data("idx",message.idx);
			modalRemoveBtn.show();
			modal.find("button[id!='modalRemoveBtn']").hide();
			$(".modal").modal("show");
			
		})
	});
	modalRemoveBtn.on("click",function(e){
		var idx = modal.data("idx");
		messageService.removerec(idx,function(result){
			alert("REMOVE");
			modal.modal("hide");
			showList(1);
		});
	});
	modalRegisterBtn.on("click",function(e){
		var message = {
				send_id:myid,
				receive_id:modalreceive_id.val() ,
				title:modaltitle.val() ,
				contents:modalcontents.val() 
		};
		messageService.add(message,function(result){
			alert("success");
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(1);
		});
	});
	
});
</script>
<style type="text/css">
	#mymodal{
		  z-index:999999;
	}
</style>
</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<section id="aa-catg-head-banner">
	<img src="/resources/img/slider/farm.jpg" alt="farm" height="300"
		width="823"
		style="margin-left: auto; margin-right: auto; display: block;">
	<div class="aa-catg-head-banner-area">
		<div class="container">
			<div class="aa-catg-head-banner-content">
				<h2>상품목록</h2>
			</div>
		</div>
	</div>
</section>
<section id="sd-ss">		
	<!-- 본문 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<h3>&nbsp;&nbsp;&nbsp;Category</h3>
			<li><a href='/myorder?user_id=<sec:authentication property="principal.username"/>'>주문 배송</a></li>
				<li><a href='/mymsdviews?user_id=<sec:authentication property="principal.username"/>'>보낸 메세지</a></li>
				<li><a href='/mymrcviews?user_id=<sec:authentication property="principal.username"/>'>받은 메세지</a></li>
				<li><a href='/mile?user_id=<sec:authentication property="principal.username"/>'>마일리지</a></li>
				<li><a href='/modifys?user_id=<sec:authentication property="principal.username"/>'>회원 정보 수정</a></li>
				<li><a href='/remove?user_id=<sec:authentication property="principal.username"/>'>회원 탈퇴</a></li>
			</ul>
		</div>
		<div class="container">
			<h1>
				Receive Message<button type="button" id="btnList" class="btn btn-info pull-right">New Message</button>
				<hr class="myhr">
			</h1>
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>보낸사람</th>
						<th>받는사람</th>
						<th>제목</th>
						<th>상태</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody class="chat">
						<tr>
						
						</tr>
				</tbody>
			</table>
			<div class="form-group">
		</div>
		</div>
	</div>
</section>

<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
<div class="modal fade" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
      <div class="modal-header">
      	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      	<h4 class="modal-title" id="myModalLabel">MESSAGE</h4>
      </div>                      
        <div class="modal-body">
        <div class="form-group">
        	<label>보낸사람</label>
        	<input class="form-control" name='send_id' placeholder='<c:out value="<%=myid%>"/>' readonly="readonly">
        </div>
        <div class="form-group">
        	<label>받은사람</label>
        	<input class="form-control" name='receive_id' value="71">
        </div>
        <div class="form-group">
        	<label>제목</label>
        	<input class="form-control" name='title' value="71">
        </div>
        <div class="form-group">
        	<label>내용</label>
        	<textarea class="form-control" name='contents' ></textarea>
        </div>
        <div class="modal-footer">
        	<button id='modalRegisterBtn' type="button" class="btn btn-primary">보내기</button>
        	<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
        </div>
        </div>                        
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div>
<script type="text/javascript" src="/static/js/mymessage.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="/resources/js/bootstrap.js"></script>
<!-- SmartMenus jQuery plugin -->
<script type="text/javascript" src="/resources/js/jquery.smartmenus.js"></script>
<!-- SmartMenus jQuery Bootstrap Addon -->
<script type="text/javascript" src="/resources/js/jquery.smartmenus.bootstrap.js"></script>
<!-- To Slider JS -->
<script src="/resources/js/sequence.js"></script>
<script src="/resources/js/sequence-theme.modern-slide-in.js"></script>
<!-- Product view slider -->
<script type="text/javascript" src="/resources/js/jquery.simpleGallery.js"></script>
<script type="text/javascript" src="/resources/js/jquery.simpleLens.js"></script>
<!-- slick slider -->
<script type="text/javascript" src="/resources/js/slick.js"></script>
<!-- Price picker slider -->
<script type="text/javascript" src="/resources/js/nouislider.js"></script>
<!-- Custom js -->
<script src="/resources/js/custom.js"></script>


</body>

</html>