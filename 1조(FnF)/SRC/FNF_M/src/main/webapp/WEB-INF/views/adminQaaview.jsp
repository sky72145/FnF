<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="qaa" value="${data}" />
<c:set var="currentPage" value="${page}" />
<c:set var="currentIdx" value="${qaa.idx}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Fishers N Farmers</title>

<link href="../../../css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="../../css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="../../css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="../../css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css" href="../../css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="../../css/theme.css" rel="stylesheet">
<!-- Top Slider CSS -->
<link href="../../css/slide.css" rel="stylesheet" media="all">

<!-- Main style sheet -->
<link href="../../css/style2.css" rel="stylesheet">


<style type="text/css">
h2 {
	margin: 80px 0 50px 0;
	color: #3673be;
}

h3 {
	text-align: center;
	margin: 30px 0 30px 0;
}

#conarea {
	margin: 80px 0 80px 0;
}

#btnarea {
	text-align: center;
	margin: 30px 0 80px 0;
}

#viewform {
	background-color: #f9f9f9;
}

#file {
	text-align: center;
}
</style>

<script src="../../js/jquery.min.js"></script>
<script>
	var idx = null;
	$(document).ready(function() {
		idx = ${qaa.idx};
		$("#txtIdx").val("${qaa.idx}");
		$("#user_id").val("${qaa.user_id}");
		$("#txtReadnum").val("${qaa.readnum}");
		$("#btnCancel").bind("click", function() {
			history.back();
		});
		replyView();

		var contents = "${qaa.contents}";
		   contents = contents.replace(/\'\'/gi, "'"); 
		   contents = contents.replace(/\&lt\;/gi, "<");
		   contents = contents.replace(/\&gt\;/gi, ">");
		   contents = contents.replace(/\<br\>/gi, "\r\n");
		   $("#conarea").html(contents);

		$("#replyWrite").click(function() {
			$.ajax({
				url : "/qaa/reply",
				method : "POST",
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify({
					"parent" : "${qaa.idx}",
					"text" : $("#newReplyText").val()
				}),
				success : function(data) {
					replyView();
					$("#newReplyText").val("");
				},
				error : function(err) {
					console.log("Error 발생 : " + err);
				}
			});
		});

	});

	function replyView() {
		$.getJSON(
						"/qaa/reply/" + parseInt(idx),
						function(data) {
							var data = data.data;
							str = "";
							$(data)
									.each(
											function() {
												str += "<li id=" + this.idx + "  class='replyLi' align='left'>"
														+ "<p><span class='label label-info'>관리자</span></p>"
														+ "<p class='text'>"
														+ this.text
														+ "</p>"
														+ "<p align='right'>"
														+ "<button type='button' class='btn btn-link btn-sm btnReplyUpdate'>수정</button>"
														+ "<button type='button' class='btn btn-link btn-sm btnReplyDelete'>삭제</button>"
														+ "</p>" + "</li>";
												str += "<hr />";
											});
							$("#replyList").html(str);
						});

		$("#replyList").on("click", ".replyLi .btnReplyDelete", function() {
			var id = $(this).parent().parent().attr("id");
			$.ajax({
				url : "/qaa/reply/" + parseInt(id),
				dataType : "json",
				method : "DELETE",
				success : function(data) {
					if (data.code)
						replyView();
				}
			});
		});
		var flag = true;
		var replyLi = null;
		$("#replyList")
				.on(
						"click",
						".replyLi .btnReplyUpdate",
						function() {
							if (flag) { //label에서 textarea로
								var id = $(this).parent().parent().attr("id");
								replyLi = $(this).parent().parent();
								var text = replyLi.find(".text").first().text();
								var newTag = "<textarea rows='3' cols='50' id='replyUpdateText' required style='resize: none;' class='text form-control'>"
										+ text + "</textarea>";
								replyLi.find(".text").replaceWith(newTag);
								$(this).text("수정완료");
								flag = false;
							} else { //textarea에서 label로
								replyLi = $(this).parent().parent();
								var id = $(this).parent().parent().attr("id");
								$
										.ajax({
											url : "/qaa/reply",
											dataType : "json",
											method : "PUT",
											contentType : "application/json; charset=utf-8",
											data : JSON.stringify({
												"idx" : parseInt(id),
												"text" : replyLi.find(".text")
														.val()
											}),
											success : function(data) {
												if (data.code) {
													replyView();
													flag = false;
												}
											}
										});
							}
						});

	}
</script>
</head>
<body>
	<!-- -------------------------------Header---------------------------------- -->
	<jsp:include page="header3.jsp"></jsp:include>
	<!-- ----------------------------------------------------------------------- -->
	<div class="col-sm-12">
		<h2 class="text-center">1 : 1 문의</h2>
		<hr>
		<form>

			<div class="row">
				<div class="col-md-offset-3 col-sm-6">
					<div class="aa-blog-content"
						style="word-break: break-all; overflow: auto" id=viewform>
						<h3>
							<strong>${qaa.title}</strong>
						</h3>
						<div class="aa-boardarticle-info">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="txtIdx"><span
								class="glyphicon glyphicon-log-in" aria-hidden="true"></span>
								${qaa.idx}</span>&nbsp; <span id="user_id"><span
								class="glyphicon glyphicon-user" aria-hidden="true"></span>
								${qaa.user_id}</span>&nbsp; <span id="txtWritedate"><span
								class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								${qaa.writedate}</span>&nbsp; <span id="txtReadnum"><span
								class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
								${qaa.readnum}</span>

						</div>
						<hr>
						<p style="text-align: center;" id="conarea"></p>
						<p id="file">
							<c:if test="${qaa.filename != null}">
								<img src="../../img/${qaa.filename}" width="600px"
									height="400px">
							</c:if>
							<c:if test="${qaa.filename == null}">
								<span></span>
							</c:if>

						</p>
						<p />
						<hr />
						<p>
						<div style="text-align: center">
							<h3>답변 작성</h3>
						</div>

						<div class="col-sm-1"></div>
						<div class="col-sm-10">
							<div>
								<form>
									<div>
										<textarea id="newReplyText" name="text" required
											style="resize: none;" class="form-control" rows="7" cols="80"
											placeholder="답변 내용을 입력해주세요"></textarea>
									</div>
									<p />
									<div align="right">
										<button class="btn btn-info btn-sm" type="button"
											id="replyWrite">
											<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
											답변쓰기
										</button>
										&nbsp;&nbsp;&nbsp;
									</div>
								</form>
							</div>

							<hr />
							<div class="text-center">
								<ul id="replyList" style="list-style-type: none"></ul>
							</div>
						</div>
						<div class="col-sm-1"></div>
						</p>
						
					</div>
					
						<div class="row col-sm-offset-4 col-sm-8" id="btnarea">
							<div class="col-sm-2 aa-login-form">
								<button class="btn btn-primary" type="button" id="btnCancel">
									목록</button>
							</div>

						</div>
				
				</div>


			</div>
	</div>




	</form>
	</div>

	<!-- -------------------------------Footer---------------------------------- -->
	<jsp:include page="footer.jsp"></jsp:include>
	<!-- ----------------------------------------------------------------------- -->

</body>
</html>