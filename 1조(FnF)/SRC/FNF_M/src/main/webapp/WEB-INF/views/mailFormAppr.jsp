<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="seller" value="${data}" />
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
<link rel="stylesheet" type="text/css" href="/static/css/nouislider.css">
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
<link href="/resources/css/sidebar2.css" rel="stylesheet">
<link href="../css/bootstrap.css" rel="stylesheet">
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#txtEmail").val("${seller.email}");
	});
</script>
</head>
<body>
	<jsp:include page="header2.jsp" />
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

							<form action="/admin/mailSending" method="post">
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-10">
										<h3>메일 보내기</h3>
										<p>
										<div align="center">
											<input type="text" name="tomail" size="60"
												class="form-control" id="txtEmail">
										</div>
										<p>
										<div align="center">
											<input type="text" name="title" size="120"
												value="[FnF] 판매자로 승인되었습니다." class="form-control">
										</div>
										<p>
										<div align="center">
											<textarea name="content" cols="120" rows="12"
												style="resize: none"
												class="form-control">판매자로 승인 되었습니다.</textarea>
										</div>
										<p>
										<div align="center">
											<input type="submit" value="메일 보내기" class="btn btn-warning">
										</div>
									</div>
									<div class="col-md-1"></div>
								</div>
							</form>
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