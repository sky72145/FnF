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
	$(document).ready(function() {
		$.ajax({
			url : "/admin/board/1",
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
			var board = $(this).parent().attr("class");
			var cf = confirm("삭제하시겠습니까?")
			if (cf) {
				if (board == 'QnA') {
					$.ajax({
						url : "/admin/qaa2/" + id,
						method : "DELETE",
						success : function(data) {
							if (data.code) {
								alert("삭제되었습니다.");
								location.href = "/admin/board";
							}
						},
						error : function(err) {
							console.log("Error 발생 : " + err);
						}
					});
				} else if (board == 'FAQ') {
					$.ajax({
						url : "/admin/faq2/" + id,
						method : "DELETE",
						success : function(data) {
							if (data.code) {
								alert("삭제되었습니다.");
								location.href = "/admin/board";
							}
						},
						error : function(err) {
							console.log("Error 발생 : " + err);
						}
					});
				} else if (board == '공지사항') {
					$.ajax({
						url : "/admin/notice/" + id,
						method : "DELETE",
						success : function(data) {
							if (data.code) {
								alert("삭제되었습니다.");
								location.href = "/admin/board";
							}
						},
						error : function(err) {
							console.log("Error 발생 : " + err);
						}
					});
				}
			}
		});

	});

	function goPage(pge) {
		page = pge;
		$.ajax({
			url : "/admin/board/" + pge,
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
			str += "<td colspan='5' align='center'>";
			str += "게시물이 없습니다.</td>";
			str += "</tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + data[i].idx + " class='deleteTr'>";

				if (data[i].board == '공지사항') {
					str += "<td><a href='/admin/cs'>" + data[i].board
							+ "</a></td>";
				} else if (data[i].board == 'FAQ') {
					str += "<td><a href='/admin/faq'>" + data[i].board
							+ "</a></td>";

				} else if (data[i].board == 'QnA') {
					str += "<td><a href='/admin/qna'>" + data[i].board
							+ "</a></td>";
				}

				if (data[i].board == '공지사항') {
					str += "<td><a href='/admin/cs/1/" + data[i].idx +"'>"
							+ data[i].title + "</a></td>";
				} else if (data[i].board == 'FAQ') {
					str += "<td><a href='/admin/faq/1/" + data[i].idx +"'>"
							+ data[i].title + "</a></td>";

				} else if (data[i].board == 'QnA') {
					str += "<td><a href='/admin/qaa/1/" + data[i].idx +"'>"
							+ data[i].title + "</a></td>";
				}

				str += "<td>"
						+ data[i].readnum
						+ "</td><td>"
						+ data[i].user_id
						+ "</td><td>"
						+ data[i].writedate
						+ "</td>"
						+ "<td class='" + data[i].board + "'><button type='button' class='btnDelete btn btn-danger btn-sm'>삭제</button></td>";
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
			if ((startPage - pageSize) <= 0) {
				pageStr += "<li><a href='javascript:goPage(" + 1
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			} else {
				pageStr += "<li><a href='javascript:goPage("
						+ (startPage - pageSize) + ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}
		}

		if (endPage <= 10) { // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>"
							+ k + "</a></li>";
			}
		} else {
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>"
							+ k + "</a></li>";
			}
		}

		if (page == totalPage) {
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		} else if (page != totalPage) {
			pageStr += "<li><a href='javascript:goPage("
					+ (startPage + pageSize) + ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a href='javascript:goPage(" + totalPage
					+ ")'aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		}

		$("#paging").html(pageStr);
	}

	function dataSearch() {
		var board = $("#board").val();
		var user_id = $("#user_id").val();
		var title = $("#title").val();
		var contents = $("#contents").val();

		if (board == "" && user_id == "" && title == "" && contents == "") {
			location.replace("/admin/board");
		} else {
			$.ajax({
				url : "/admin/board/search/1",
				dataType : "json",
				method : "POST",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify({
					"board" : board,
					"user_id" : user_id,
					"title" : title,
					"contents" : contents
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
		var board = $("#board").val();
		var user_id = $("#user_id").val();
		var title = $("#title").val();
		var contents = $("#contents").val();
		$.ajax({
			url : "/admin/board/search/" + pge,
			dateType : "json",
			method : "POST",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				"board" : board,
				"user_id" : user_id,
				"title" : title,
				"contents" : contents
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
			str += "<tr><td colspan='5' align='center'>검색 결과가 없습니다.</td></tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				str += "<tr id=" + result[i].idx + " class='deleteTr'>";
				if (result[i].board == '공지사항') {
					str += "<td><a href='/admin/cs'>" + result[i].board
							+ "</a></td>";
				} else if (result[i].board == 'FAQ') {
					str += "<td><a href='/admin/faq'>" + result[i].board
							+ "</a></td>";

				} else if (result[i].board == 'QnA') {
					str += "<td><a href='/admin/qna'>" + result[i].board
							+ "</a></td>";
				}

				if (result[i].board == '공지사항') {
					str += "<td><a href='/admin/cs/1/" + result[i].idx +"'>"
							+ result[i].title + "</a></td>";
				} else if (result[i].board == 'FAQ') {
					str += "<td><a href='/admin/faq/1/" + result[i].idx +"'>"
							+ result[i].title + "</a></td>";

				} else if (result[i].board == 'QnA') {
					str += "<td><a href='/admin/qaa/1/" + result[i].idx +"'>"
							+ result[i].title + "</a></td>";
				}

				str += "<td>"
						+ result[i].readnum
						+ "</td><td>"
						+ result[i].user_id
						+ "</td><td>"
						+ result[i].writedate
						+ "</td>"
						+ "<td class='" + result[i].board + "'><button type='button' class='btnDelete btn btn-danger btn-sm'>삭제</button></td>";
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
			if ((startPage - pageSize) <= 0) {
				pageStr += "<li><a href='javascript:goPage(" + 1
						+ ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			} else {
				pageStr += "<li><a href='javascript:goPage("
						+ (startPage - pageSize) + ")' aria-label='Previous'>";
				pageStr += "<span aria-hidden='true'>&lt;</span></a></li>";
			}
		}

		if (endPage <= 10) { // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>"
							+ k + "</a></li>";
			}
		} else {
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<li><a>" + k + "</a></li>";
				else
					pageStr += "<li><a href='javascript:goPage(" + k + ")'>"
							+ k + "</a></li>";
			}
		}

		if (page == totalPage) {
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;</span></a></li>";
			pageStr += "<li><a aria-label='Next'> ";
			pageStr += "<span aria-hidden='true'>&gt;&gt;</span></a></li></ul></div></nav>";
		} else if (page != totalPage) {
			pageStr += "<li><a href='javascript:goPage("
					+ (startPage + pageSize) + ")'aria-label='Next'> ";
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
								<h3>게시글 검색</h3>
								<hr />
								<div>
									<form>
										<div class="row">
											<div class="col-md-6">
												<label for="board">게시판</label> <input type="text"
													class="form-control" id="board" name="board"
													placeholder="게시판 종류를 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="user_id">작성자</label> <input type="text"
													class="form-control" id="user_id" name="user_id"
													placeholder="작성자 아이디를 입력해주세요.">
											</div>
										</div>
										<div class="form-group"></div>
										<div class="row">
											<div class="col-md-6">
												<label for="title">제목</label> <input type="email"
													class="form-control" id="title" name="title"
													placeholder="제목을 입력해주세요.">
											</div>
											<div class="col-md-6">
												<label for="contents">내용</label> <input type="text"
													class="form-control" id="contents" name="contents"
													placeholder="검색할 내용의 키워드를 입력해주세요.">
											</div>
										</div>
								</div>
								<div class="form-group"></div>
								<p>
								<div class="row">
									<div class="col-md-3"></div>
									<div class="col-md-6">
										<button type="button" onclick="dataSearch()"
											class="btn btn-primary btn-sm btn-block">검색</button>
									</div>
									<div class="col-md-3"></div>
									</form>
								</div>
							</div>



							<div>
								<div class="panel-body">
									<h3>게시글 목록</h3>
									<hr />
									<div>
										<table class="table table-hover">
											<colgroup>
												<col width="15%">
												<col width="30%">
												<col width="10%">
												<col width="10%">
												<col width="25%">
												<col width="10%">
											</colgroup>
											<thead>
												<tr>
													<th>게시판</th>
													<th>제목</th>
													<th>조회수</th>
													<th>작성자</th>
													<th>등록일</th>
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