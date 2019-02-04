<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<script>
function popupOpen() {

	var popUrl = "http://www.deliverytracking.kr/"; 

	var popOption = "width=600, height=600, resizable=no, scrollbars=no, status=no;"; 

	window.open(popUrl, "", popOption);

}
$(document).ready(function(){
	var formObj = $("form");
	
	$("#btnbuy").bind("click", function(e){
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
<section id="aa-product-category">
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
				배송 현황
				<hr class="myhr">
			</h1>
			<table class="table">
				<thead>
					<tr>
						<th>운송장번호</th>
						<th>총금액</th>
						<th>주문상태</th>
						<th>수량</th>
						<th>상품정보</th>
						<th>배송조회</th>
						<th>구매확정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${order }" var="order">
						<tr>
							<td><c:out value="${order.del_code}" /></td>
							<td><c:out value="${order.totalprice}" /></td>
							<td><c:out value="${order.status}" /></td>
							<td><c:out value="${order.product_count}" /></td>
							<td><img
								src='/resources/img/<c:out value="${product.filename}"/>'
								alt="afasgaw" />
							<c:out value="${order.pname}" /></td>
							<td>
								<button type="button" class="btn btn-success">
									<a href="javascript:popupOpen();">배송조회</a>
								</button>
							</td>
							<td>
								<button type="submit" id="btnbuy" data-oper='modifyorder' class="btn btn-success">구매확정</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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