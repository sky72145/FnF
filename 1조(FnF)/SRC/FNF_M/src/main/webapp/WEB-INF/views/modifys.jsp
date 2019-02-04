<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
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

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");

		$('button').on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			formObj.submit();
		});
	});
</script>
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
					<li><a
						href='/myorder?user_id=<sec:authentication property="principal.username"/>'>주문
							배송</a></li>
					<li><a
						href='/mymsdviews?user_id=<sec:authentication property="principal.username"/>'>보낸
							메세지</a></li>
					<li><a
						href='/mymrcviews?user_id=<sec:authentication property="principal.username"/>'>받은
							메세지</a></li>
					<li><a
						href='/mile?user_id=<sec:authentication property="principal.username"/>'>마일리지</a></li>
					<li><a
						href='/modifys?user_id=<sec:authentication property="principal.username"/>'>회원
							정보 수정</a></li>
					<li><a
						href='/remove?user_id=<sec:authentication property="principal.username"/>'>회원
							탈퇴</a></li>
				</ul>
			</div>
			<div class="col-md-12">
				<div class="aa-memberlogin-area">
					<div class="wrapper">
						<div class="col-md-10">
							<div class="aa-memberlogin-login">
								<h1 id="title">
									<strong>회원 정보 수정</strong>
								</h1>
								<hr width="100%">
								<form action="/modifys" id="signupform" name="signupform"
									method="post">
									<label id="signid" name="signeid"
										class="col-md-offset-1 col-sm-3  control-label">ID</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" name='user_id'
											id='user_id' value='<c:out value="${member.user_id }"/>'
											readonly="readonly">
									</div>
									<br /> <br /> <br /> <label id="signupemail"
										name="signupemail"
										class="col-md-offset-1 col-sm-3 control-label">Email</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id="email"
											name="email" value='<c:out value="${member.email }"/>' />
									</div>
									<br /> <br /> <br /> <label id="signuppswd" name="password"
										class="col-md-offset-1 col-sm-3 control-label">비밀번호</label>
									<div class="col-sm-5">
										<input type="password" class="form-control" id="signuppswd"
											name="password" required />
									</div>
									<br /> <br /> <br /> <label id="signupname"
										name="signupname"
										class="col-md-offset-1 col-sm-3 control-label">이름</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id="signupname"
											name="user_name"
											value='<c:out value="${member.user_name }"/>' />
									</div>
									<br /> <br /> <br /> <label id="signupnum" name="signupnum"
										class="col-md-offset-1 col-sm-3 control-label">휴대 전화</label>
									<div class="col-sm-5">
										<input type="phone number" class="form-control" id="signupnum"
											name="phone" value='<c:out value="${member.phone }"/>' />
									</div>
									<br /> <br /> <br /> <label id="signupname"
										name="signupbirth"
										class="col-md-offset-1 col-sm-3 control-label">생일</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id="signupbirth"
											name="birth" value='<c:out value="${member.birth }"/>'
											readonly="readonly" />
									</div>
									<br /> <br /> <br /> <label id="question_label" name=""
										class="col-md-offset-1 col-sm-3 control-label">본인인증질문*</label>
									<div class="col-sm-5">
										<select id="question" name="question" class="form-control">
											<option value="findplace">가장 기억에 남는 장소는?</option>
											<option value="findfood">가장 좋아하는 음식은?</option>
											<option value="findbook">가장 감명깊게 읽은 책은?</option>
											<option value="findbrand">가장 좋아하는 브랜드는?</option>
										</select>
									</div>
									<br /> <br /> <br /> <label id="answer_label"
										name="answer_label"
										class="col-md-offset-1 col-sm-3 control-label">답변*</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id="answer"
											name="answer" required />
									</div>
									<br />
									<br />
									<hr width="100%">
									<br />
									<button type="submit" id="btnregister" data-oper='modifys'
										class="btn btn-success col-md-offset-4">수정하기</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- footer -->
	<jsp:include page="footer.jsp"></jsp:include>
	<!-- / footer -->
	<!-- ------------------------------------------------------- -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="/resources/js/bootstrap.js"></script>
	<!-- SmartMenus jQuery plugin -->
	<script type="text/javascript" src="/resources/js/jquery.smartmenus.js"></script>
	<!-- SmartMenus jQuery Bootstrap Addon -->
	<script type="text/javascript"
		src="/resources/js/jquery.smartmenus.bootstrap.js"></script>
	<!-- To Slider JS -->
	<script src="/resources/js/sequence.js"></script>
	<script src="/resources/js/sequence-theme.modern-slide-in.js"></script>
	<!-- Product view slider -->
	<script type="text/javascript"
		src="/resources/js/jquery.simpleGallery.js"></script>
	<script type="text/javascript" src="/resources/js/jquery.simpleLens.js"></script>
	<!-- slick slider -->
	<script type="text/javascript" src="/resources/js/slick.js"></script>
	<!-- Price picker slider -->
	<script type="text/javascript" src="/resources/js/nouislider.js"></script>
	<!-- Custom js -->
	<script src="/resources/js/custom.js"></script>

</body>

</html>