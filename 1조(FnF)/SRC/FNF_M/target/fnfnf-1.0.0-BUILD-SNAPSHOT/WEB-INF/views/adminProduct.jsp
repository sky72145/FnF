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

<style>
th, td {
	text-align: center;
}
</style>
<script>
	var page = null;
	$(document).ready(function() {
		$.ajax({
			url : "/admin/product/1",
			dataType : "json",
			method : "POST",
			success : function(data) {
				display(data);
			},
			error : function(err) {
				console.log("Error 발생 : " + err);
			}
		});

		$("#result").on("click", ".deleteTr .btnDelete", function() {
			var id = $(this).parent().parent().attr("id");
			var cf = confirm("해당 상품을 삭제하시겠습니까?");
			if (cf) {
				$.ajax({
					url : "/admin/product/" + id,
					method : "DELETE",
					success : function(data) {
						if (data.code) {
							alert("삭제되었습니다.");
							location.href = "/admin/product";
						}
					},
					error : function(err) {
						console.log("Error 발생 : " + err);
					}
				});
			}

		});

	});

	function goPage(pge) {
		page = pge;
		$.ajax({
			url : "/admin/product/" + pge,
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
			str += "<td colspan='8' align='center'>";
			str += "등록된 상품이 없습니다.</td>";
			str += "</tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + data[i].pcode + " class='deleteTr'>";
				str += "<td><a href='/PD/" + data[i].idx + "'>"
						+ data[i].pcode
						+ "</a></td><td>"
						+ data[i].pname
						 + "</td><td><a href='/admin/seller/" + page + "/" + data[i].sellerid + "'>"
						+ data[i].sellerid
						+ "</a></td><td>" 
						+ data[i].price
						+ "</td><td>"
						+ data[i].stock
						+ "</td><td>"
						+ data[i].sell_num
						+ "</td><td>"
						+ data[i].origin
						+ "</td>"
						+ "<td>"
						+ data[i].category
						+ "</td><td>"
						+ data[i].category2
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
		var sellerid = $("#sellerid").val();
		var pcode = $("#pcode").val();
		var pname = $("#pname").val();
		var origin = $("#origin").val();
		var category = $("#category").val();
		var category2 = $("#category2").val();
		if (sellerid == "" && pcode == "" && pname == "" && origin == ""
				&& category == "" && category2 == "") {
			location.replace("/admin/product");
		} else {
			$.ajax({
				url : "/admin/product/search/1",
				dataType : "json",
				method : "POST",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify({
					"sellerid" : sellerid,
					"pcode" : pcode,
					"pname" : pname,
					"origin" : origin,
					"category" : category,
					"category2" : category2
				}),
				success : function(result) {
					displaySearch(result);
				},
				error : function(err) {
					console.log("err 발생 : " + err);
				}
			})
		}
	}

	function goSearchPage(pge) {
		page = pge;
		var sellerid = $("#sellerid").val();
		var pcode = $("#pcode").val();
		var pname = $("#pname").val();
		var origin = $("#origin").val();
		var category = $("#category").val();
		var category2 = $("#category2").val();
		$.ajax({
			url : "/admin/product/search/" + page,
			dataType : "json",
			method : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				"sellerid" : sellerid,
				"pcode" : pcode,
				"pname" : pname,
				"origin" : origin,
				"category" : category,
				"category2" : category2
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
			str += "<tr><td colspan='8' align='center'>검색 결과가 없습니다.</td></tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + result[i].idx + " class='deleteTr'>";
				str += "<td>"
						+ result[i].pcode
						+ "</td><td>"
						+ result[i].pname
						+ "</td><td><a href='/admin/seller/" + page + "/" + result[i].sellerid + "'>"
						+ result[i].sellerid
						+ "</a></td><td>" 
						+ result[i].price
						+ "</td><td>"
						+ result[i].stock
						+ "</td><td>"
						+ result[i].sell_num
						+ "</td><td>"
						+ result[i].origin
						+ "</td>"
						+ "<td>"
						+ result[i].category
						+ "</td><td>"
						+ result[i].category2
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
								<h3>상품 검색</h3>
								<hr />
								<div>
									<form>
										<div class="row">
											<div class="col-md-6">
												<label for="category">카테고리1</label> <input type="text"
													class="form-control" id="category" name="category"
													placeholder="카테고리를 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="category2">카테고리2</label> <input type="text"
													class="form-control" id="category2" name="category2"
													placeholder="카테고리를 입력해주세요.">
											</div>
										</div>

										<div class="form-group"></div>

										<div class="row">
											<div class="col-md-6">
												<label for="pname">상품명</label> <input type="text"
													class="form-control" id="pname" name="pname"
													placeholder="상품명을 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="pcode">상품코드</label> <input type="text"
													class="form-control" id="pcode" name="pcode"
													placeholder="상품코드를 입력해주세요.">
											</div>
										</div>

										<div class="form-group"></div>

										<div class="row">
											<div class="col-md-6">
												<label for="sellerid">판매자</label> <input type="text"
													class="form-control" id="sellerid" name="sellerid"
													placeholder="판매자 아이디를 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="origin">원산지</label> <input type="text"
													class="form-control" id="origin" name="origin"
													placeholder="원산지를 입력해주세요.">
											</div>
										</div>
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
									<h3>상품 관리</h3>
									<hr />

									<div>
										<table class="table table-hover">
											<colgroup>
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th>상품코드</th>
													<th>상품명</th>
													<th>판매자</th>
													<th>판매가</th>
													<th>재고</th>
													<th>판매수</th>
													<th>원산지</th>
													<th>Category1</th>
													<th>Category2</th>
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