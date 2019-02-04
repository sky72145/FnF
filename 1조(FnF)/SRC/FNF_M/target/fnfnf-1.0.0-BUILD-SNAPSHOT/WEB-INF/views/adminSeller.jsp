<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Fishers N Farmers</title>
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
<link id="switcher" href="css/theme.css" rel="stylesheet">
<!-- Top Slider CSS -->
<link href="css/slide.css" rel="stylesheet" media="all">

<!-- Main style sheet -->
<link href="/resources/css/style2.css" rel="stylesheet">

<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
<link href="/resources/css/sidebar.css" rel="stylesheet">
<script src="js/jquery.min.js"></script>
<script>
	var page = null;
	$(document)
			.ready(
					function() {
						$.ajax({
							url : "/admin/seller/1",
							dataType : "json",
							method : "POST",
							success : function(data) {
								display(data);
							},
							error : function(err) {
								console.log("Error 발생 : " + err);
							}
						});

						$("#result")
								.on(
										"click",
										".deleteTr .btnDelete",
										function() {
											var id = $(this).parent().parent()
													.attr("id");
											var cf = confirm("삭제하시겠습니까?")
											if (cf) {
												$
														.ajax({
															url : "/admin/seller/"
																	+ id,
															method : "PUT",
															contentType : "application/json; charset=utf-8",
															dataType : "json",
															data : JSON
																	.stringify({
																		"user_id" : id
																	}),
															success : function(
																	data) {
																if (data.code) {
																	alert("삭제되었습니다.");
																	location.href = "/admin/seller";
																}
															},
															error : function(
																	err) {
																console
																		.log("Error 발생 : "
																				+ err);
															}
														});
											}
										});

						$
								.ajax({
									url : "/admin/newseller",
									dataType : "json",
									method : "GET",
									success : function(data) {
										var str = "";
										var data = data.data;
										var count = data.length;
										if (count == 0) {
											str = "<tr>";
											str += "<td colspan='5' align='center'>";
											str += "새로운 판매회원이 없습니다.</td>";
											str += "</tr>";
										} else if (count > 0) {
											for (var i = 0; i < data.length; i++) {
												str += "<tr id=" + data[i].user_id + " class='newTr'>";
												str += "<td>"
														+ data[i].user_id
														+ "</td><td><a href='/admin/seller/1/" + data[i].user_id + "'>"
														+ data[i].user_name
														+ "<a/></td>"
														+ "<td><a href='/admin/maila/" + data[i].user_id + "'>"
														+ data[i].email
														+ "</a></td><td>"
														+ data[i].phone
														+ "</td><td>"
														+ "<button type='button'class='btnApprove btn btn-success btn-sm'>승인</button>&nbsp;"
														+ "<button type='button'class='btnReject btn btn-warning btn-sm'>거부</button>"
														+ "</td>";
												str += "</tr>";
											}
										}
										$("#newSeller").html(str);
									},
									error : function(err) {
										console.log("Error 발생 : " + err);
									}
								});

						$("#newSeller")
								.on(
										"click",
										".newTr .btnApprove",
										function() {
											var id = $(this).parent().parent()
													.attr("id");
											var cf = confirm("승인하시겠습니까?")
											if (cf) {
												$
														.ajax({
															url : "/admin/sellerappr/"
																	+ id,
															method : "PUT",
															contentType : "application/json; charset=utf-8",
															dataType : "json",
															data : JSON
																	.stringify({
																		"user_id" : id
																	}),
															success : function(
																	data) {
																if (data.code) {
																	alert("승인이 완료되었습니다.");
																	location.href = "/admin/seller";
																}
															},
															error : function(
																	err) {
																console
																		.log("Error 발생 : "
																				+ err);
															}
														});
											}
										});

						$("#newSeller")
								.on(
										"click",
										".newTr .btnReject",
										function() {
											var id = $(this).parent().parent()
													.attr("id");
											var cf = confirm("승인을 거절하시겠습니까?")
											if (cf) {
												$
														.ajax({
															url : "/admin/sellerrej/"
																	+ id,
															method : "PUT",
															contentType : "application/json; charset=utf-8",
															dataType : "json",
															data : JSON
																	.stringify({
																		"user_id" : id,
																	}),
															success : function(
																	data) {
																if (data.code) {
																	alert("승인을 거부했습니다.");
																	location.href = "/admin/mail/"
																			+ id;
																}
															},
															error : function(
																	err) {
																console
																		.log("Error 발생 : "
																				+ err);
															}
														});

											}
										});

					});

	function goPage(pge) {
		page = pge;
		$.ajax({
			url : "/admin/seller/" + pge,
			dataType : "json",
			method : "POST",
			success : function(result) {
				display(result);
			}
		});
	}

	function display(result) {
		var startPage = result.startPage;
		var endPage = result.endPage;
		var totalPage = result.totalPage;
		var pageSize = result.pageSize;
		page = result.page; //current Page
		var data = result.data;
		var count = data.length;
		var str = null;
		if (count == 0) {
			str = "<tr>";
			str += "<td colspan='6' align='center'>";
			str += "회원이 없습니다.</td>";
			str += "</tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + data[i].user_id + " class='deleteTr'>";
				str += "<td>"
						+ data[i].user_id
						+ "</td><td><a href='/admin/seller/" + page + "/" + data[i].user_id + "'>"
						+ data[i].user_name
						+ "</a>"
						+ "</td>"
						+ "<td><a href='/admin/maila/" + data[i].user_id + "'>"
						+ data[i].email
						+ "</a></td><td>"
						+ data[i].phone
						+ "</td>"
						+ "<td>"
						+ data[i].birth
						+ "</td>"
						+ "<td><button type='button' class='btnDelete btn btn-danger btn-sm'>삭제</button></td>";
				str += "</tr>";

			}
		}
		$("#result").html(str);
		$("#paging").empty();
		$("#paging").attr("style", "text-align:center");
		var pageStr = "<nav><div class='text-center'><ul class='pagination'>";


		if (page == 1) {
			pageStr += "<li><a aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;&lt;</span></a></li>";
			pageStr += "<li><a aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
		} else if (page != 1) {
			pageStr += "<li><a href='javascript:goPage(1)' aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;&lt;</span></a></li>";
			if((startPage - pageSize) <= 0){
				pageStr += "<li><a href='javascript:goPage(" + 1
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}else{
				pageStr += "<li><a href='javascript:goPage(" + (startPage - pageSize)
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}
		}


		if(endPage <=10){ // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>" + k+ "</a></li>";
			}
		}else{
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>" + k+ "</a></li>";
			}
		}

		if (page == totalPage) {
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		} else if (page != totalPage) {
			pageStr += "<li><a href='javascript:goPage(" + (startPage + pageSize)
					+ ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a href='javascript:goPage(" + totalPage
					+ ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		}

		$("#paging").html(pageStr);
	}

	function dataSearch() {
		var user_id = $("#user_id").val();
		var user_name = $("#user_name").val();
		var email = $("#email").val();
		var phone = $("#phone").val();
		if (user_id == "" && user_name == "" && email == "" && phone == "") {
			location.replace("/admin/seller");
		} else {
			$.ajax({
				url : "/admin/seller/search/1",
				dataType : "json",
				method : "POST",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify({
					"user_id" : user_id,
					"user_name" : user_name,
					"email" : email,
					"phone" : phone
				}),
				success : function(result) {
					displaySearch(result);
				},
				error : function(err) {
					console.log("err 발생 : " + err);
				}
			});
		}
	}

	function goSearchPage(pge) {
		page = pge;
		var user_id = $("#user_id").val();
		var user_name = $("#user_name").val();
		var email = $("#email").val();
		var phone = $("#phone").val();
		$.ajax({
			url : "/admin/seller/search/" + pge,
			dataType : "json",
			method : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				"user_id" : user_id,
				"user_name" : user_name,
				"email" : email,
				"phone" : phone
			}),
			success : function(result) {
				displaySearch(result);
			}
		});
	}

	function displaySearch(result) {
		var totalCount = result.totalCount;
		var startPage = result.startPage;
		var endPage = result.endPage;
		var totalPage = result.totalPage;
		var pageSize = result.pageSize;
		page = result.page;
		var result = result.data;
		var count = result.length;
		var str = null;
		if (count == 0) {
			str += "<tr><td colspan='6' align='center'>검색 결과가 없습니다.</td></tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + result[i].user_id + " class='deleteTr'>";
				str += "<td>"
						+ result[i].user_id
						+ "</td>"
						+ "<td><a href='/admin/seller/" + page + "/" + result[i].user_id + "'>"
						+ result[i].user_name
						+ "</a></td>"
						+ "<td><a href='/admin/maila/" + result[i].user_id + "'>"
						+ result[i].email
						+ "</a></td><td>"
						+ result[i].phone
						+ "</td>"
						+ "<td>"
						+ result[i].birth
						+ "</td>"
						+ "<td><button type='button' class='btnDelete btn btn-danger btn-sm'>삭제</button></td>";
				str += "</tr>";
			}
		}

		$("#result").html(str);
		$("#paging").empty();
		$("#paging").attr("style", "text-align:center");

		var pageStr = "<nav><div class='text-center'><ul class='pagination'>";


		if (page == 1) {
			pageStr += "<li><a aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;&lt;</span></a></li>";
			pageStr += "<li><a aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
		} else if (page != 1) {
			pageStr += "<li><a href='javascript:goPage(1)' aria-label='Previous'>";
			pageStr += "<span aria-hidden='true'>&lt;&lt;</span></a></li>";
			if((startPage - pageSize) <= 0){
				pageStr += "<li><a href='javascript:goPage(" + 1
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}else{
				pageStr += "<li><a href='javascript:goPage(" + (startPage - pageSize)
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}
		}


		if(endPage <=10){ // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>" + k+ "</a></li>";
			}
		}else{
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>" + k+ "</a></li>";
			}
		}

		if (page == totalPage) {
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		} else if (page != totalPage) {
			pageStr += "<li><a href='javascript:goPage(" + (startPage + pageSize)
					+ ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a href='javascript:goPage(" + totalPage
					+ ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		}

		$("#paging").html(pageStr);
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<section id="aa-popular-category">
		<!-- 본문 -->
		<div id="wrapper">
			<!-- 사이드바 -->
			<div id="sidebar-wrapper">
				<div id="aa-sidebar-widget">
					<ul class="sidebar-nav">
						<li><a href="/admin"><h2>[관리자 페이지]</h2></a></li>
						<h3>&nbsp;&nbsp;&nbsp;Member</h3>
						<li><a href="/admin/user">회원 관리</a></li>
						<li><a href="/admin/seller">판매자 관리</a></li>
						<h3>&nbsp;&nbsp;&nbsp;Product</h3>
						<li><a href="/admin/product">상품 관리</a></li>
						<li><a href="/admin/recomm">추천 상품 등록</a></li>
						<h3>&nbsp;&nbsp;&nbsp;Board</h3>
						<li><a href="/admin/board">게시판 관리</a></li>
						<li><a href="/admin/cs">공지사항</a></li>
						<li><a href="/admin/qaa">1:1문의</a></li>
						<li><a href="/admin/faq">FAQ</a></li>
					</ul>
				</div>
			</div>
			<!-- /사이드바 -->


			<div id="page-content-wrapper">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-9">
							<div class="well well-lg">
								<h3>새로운 판매회원</h3>
								<hr />
								<div>
									<table class="table" style='text-align: center'>
										<colgroup>
											<col width="15%">
											<col width="15%">
											<col width="30%">
											<col width="20%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
												<th style='text-align: center'>아이디</th>
												<th style='text-align: center'>이름</th>
												<th style='text-align: center'>이메일</th>
												<th style='text-align: center'>휴대전화</th>
												<th style='text-align: center'>승인여부</th>
											</tr>
										</thead>
										<tbody id="newSeller">
										</tbody>
									</table>
								</div>
							</div>

							<div class="form-group"></div>
							<div class="well well-lg">
								<h3>판매자 검색</h3>
								<hr />
								<div>
									<form>
										<div class="row">
											<div class="col-md-6">
												<label for="user_id">아이디</label> <input type="text"
													class="form-control" id="user_id" name="user_id"
													placeholder="아이디를 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="user_name">이름</label> <input type="email"
													class="form-control" id="user_name" name="user_name"
													placeholder="이름을 입력해주세요.">
											</div>
										</div>
										<div class="form-group"></div>
										<div class="row">
											<div class="col-md-6">
												<label for="email">이메일</label> <input type="text"
													class="form-control" id="email" name="email"
													placeholder="이메일을 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="phone">휴대전화</label> <input type="text"
													class="form-control" id="phone" name="phone"
													placeholder="전화번호를 입력해주세요.">
											</div>
										</div>
										<div class="form-group"></div>
								</div>
								<div class="form-group"></div>
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-8">
										<button type="button" onclick="dataSearch()"
											class="btn btn-primary btn-md btn-block">검색</button>
									</div>
									<div class="col-md-2"></div>
									</form>
								</div>
							</div>


							<div>
								<div class="panel-body">
									<h3>판매자 목록</h3>
									<hr />
									<div>
										<table class="table table-hover">
											<colgroup>
												<col width="15%">
												<col width="15%">
												<col width="25%">
												<col width="20%">
												<col width="15%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th>아이디</th>
													<th>이름</th>
													<th>이메일</th>
													<th>휴대전화</th>
													<th>생일</th>
													<th>관리</th>
												</tr>
											</thead>
											<tbody id="result">
											</tbody>
										</table>
										<div id="paging"></div>

									</div>
								</div>
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