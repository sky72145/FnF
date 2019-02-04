<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="seller" value="${data}" />
<c:set var="currentPage" value="${page}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Fishers N Farmers</title>
<!-- Font awesome -->
<link href="/static/css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="/static/css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="/static/css/jquery.smartmenus.bootstrap.css"
	rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="/static/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="/static/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href="/static/css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="/static/css/theme.css" rel="stylesheet">
<!-- Top Slider CSS -->
<link href="/static/css/slide.css" rel="stylesheet" media="all">

<!-- Main style sheet -->
<link href="/resources/css/style2.css" rel="stylesheet">

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
<link href="/resources/css/sidebar.css" rel="stylesheet">
<style>
	th{
		text-align :center;
	}
</style>
<script src="js/jquery.min.js"></script>
<script>
function list(){
	history.back();
}
</script>
</head>
<body>
	<jsp:include page="header3.jsp" />
	<section id="aa-popular-category">
		<!-- 본문 -->
		<div id="wrapper">
			<!-- 사이드바 -->
			<div id="sidebar-wrapper">
				<div id="aa-sidebar-widget">
					<ul class="sidebar-nav">
						<h3>&nbsp;&nbsp;&nbsp;Member</h3>
						<li><a href="/admin/user">회원 관리</a></li>
						<li><a href="/admin/seller">판매자 관리</a></li>
						<h3>&nbsp;&nbsp;&nbsp;Product</h3>
						<li><a href="/admin/product">상품 관리</a></li>
						<li><a href="/admin/recomm">추천 상품 등록</a></li>
						<h3>&nbsp;&nbsp;&nbsp;Board</h3>
						<li><a href="/admin/board">게시판 관리</a></li>
						<li><a href="/admin/notice">공지사항</a></li>
						<li><a href="/admin/qaa">Q&A 답변</a></li>
						<li><a href="/admin/faq">FAQ</a></li>
					</ul>
				</div>
			</div>
			<!-- /사이드바 -->


			<div id="page-content-wrapper">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-9">
							<h3>판매회원 상세 정보</h3>
							<hr/>
							<table class="table table-striped">
								<tr><th style="width:20%">아이디</td><td>${seller.user_id}</td></tr>
								<tr><th>이름</th><td>${seller.user_name}</td></tr>
								<tr><th>이메일</th><td><a href='/admin/maila/${seller.user_id}' >${seller.email}</a></td></tr>
								<tr><th>생일</th><td>${seller.birth}</td></tr>
								<tr><th>전화번호</th><td>${seller.phone}</td></tr>
								<tr><th>사업번호</th><td>${seller.regi_num}</td></tr>
								<tr><th>회사명</th><td>${seller.com_name}</td></tr>
								<tr><th>회사 URL</th><td>${seller.com_url}</td></tr>
							
							</table>
							<div  align='center'>
							<button type="button" class="btn btn-primary" onclick="list()">목록으로</button>
								</div>
							

						</div>
					</div>
				</div>
			</div>
			<!-- /본문 -->
		</div>
	</section>



	<jsp:include page="footer.jsp" />
</body>
</html>