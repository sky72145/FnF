<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>Fishers N Farmers</title>
     
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
    <link href="css/style2.css" rel="stylesheet">    

  
  <style type="text/css">

	.widget_customer_page_info { margin-top:0px; background:#ededed; text-align:center;}


	/*  버튼 */
/* 	#container #contents { width:100% !important; } */
	.fixed_customer_page { width:650px; margin:0 auto; }
	.banner { overflow:hidden; margin:80px 0 0px 0; } 
	.banner ul { margin:0 0 0 -8px; padding:0; } 
	.banner ul li { float:left; margin:0 0 9px 15px; }
	.banner ul li a:hover img { opacity:0.6; }
	
	ul{
     	list-style:none;
    }
		
	#subtitle{
		color:355b8f;
	}
	/* 검색  */
	#search, #click, #search_key{
		height:30px
	}
	
	#click{
		margin:0px 0 5px 0;
	}  
	
	#find{
		text-align:right;
	}
	
	h2{
		margin:0px 0 30px 0;
	}
	
	/* #paging{
		margin:0px 0 40px 0;
	} */
</style>

<script src="js/jquery.min.js"></script> 
  <script>
  var page = null;
	$(document).ready(function(){
		$.ajax({
			url : "/cs/1",
			dataType : "json",
			method : "POST",
			success : function(data){
				display(data);
			},
			error : function(err){
				console.log("Error 발생 : " + err);
			}
		});
	});
	
	function goPage(pge){ //page 이동
		page = pge;
		$.ajax({
			url : "/cs/" + pge,
			dataType : "json",
			method : "POST",
			success : function(result){
				display(result);
			}
		});
	}
	function display(result){
		var startPage = result.startPage;
		var endPage = result.endPage;
		var totalPage = result.totalPage;
		var pageSize = result.pageSize;
		page = result.page;  //current Page
		var data = result.data;
		var count = data.length;
		var str = null;
		if(count == 0) {
			str = "<tr>";
			str += "<td colspan='5' align='center'>";
			str += "글이 없습니다.</td>";
			str += "</tr>";
		}else if(count > 0){
		for(var i = 0 ; i < count ; i++){
			var notice = data[i];
			var writedate = notice.writedate.substr(0, 10);
			/* var reimg = "";
			if(lev > 0) {
				for(var j = 0 ; j < lev ; j++){
					reimg +="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				reimg += "<img src='static/images/re.png' style='width:20px;height:20px'/>";
			}else reimg = ""; */
			str += "<tr>";
			str += "<td>" + notice.idx + "</td>" + 
					"<td>&nbsp;"  + "<a href='/cs/" + page + "/" + notice.idx +
					"'>" + notice.title + "</a></td>" +
					"<td>" + notice.user_id + "</td>" +
					"<td>" + notice.readnum + "</td>"+
			"<td>" + writedate + "</td>";
			str += "</tr>";	
			}
		}
		$("#records").html(str);
		$("#paging").empty();
		$("#paging").attr("style", "text-align:center");
		var pageStr = null;
		// <<  <
		if (page == 1) { //현재페이지가 1일 때
			pageStr = "<button type='button' class='btn btn-info btn-sm'>처음</button>&nbsp;&nbsp;&nbsp;";
			pageStr += "<button type='button' class='btn btn-default btn-sm'>이전</button>&nbsp;&nbsp;";
		} else if (page != 1) { // 현재페이지가 1이 아닐 때
			pageStr = "<a href='javascript:goPage(1)'><button type='button' class='btn btn-info btn-sm'>처음</button></a>&nbsp;&nbsp;&nbsp;";
			if((startPage - pageSize) <= 0){
				pageStr += "<a href='javascript:goPage(" + 1 + ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
			}else{
				pageStr += "<a href='javascript:goPage(" + (startPage - pageSize) 	+ ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}
		
		// 1 2 3 4 5 6 7 8 9 10
		if(endPage <=10){ // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
				else  //현재페이지가 아닌
					pageStr += "<a href='javascript:goPage(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}else{
			for (var k = startPage; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
				else  //현재페이지가 아닌
					pageStr += "<a href='javascript:goPage(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}
		
		// >  >>
		if (page == totalPage) {
			pageStr += "<button type='button' class='btn btn-default btn-sm'>다음</button>&nbsp;&nbsp;&nbsp;";
			pageStr += "<button type='button'  class='btn btn-info btn-sm'>끝</button>";
		} else if (page != totalPage) {
			pageStr += "<a href='javascript:goPage(" + (startPage + pageSize) + ")'><button type='button' class='btn btn-default btn-sm'>다음</button></a>&nbsp;&nbsp;&nbsp;";
			pageStr += "<a href='javascript:goPage(" + totalPage + ")'><button type='button'  class='btn btn-info btn-sm'>끝</button></a>";
		}
		
		$("#paging").html(pageStr);
	}
  </script>
</head>
<body>
<!-- -------------------------------Header---------------------------------- -->
 <jsp:include page="header2.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->

<section id="aa-banner">


<div class="widget_customer_page_info">
	<img src="img/step.png" usemap="#Map">
&nbsp;</div>

<div class="fixed_customer_page">

	<div class="banner">
	
		<ul>
			<li class="xans-record-"><a href="/" alt=" "><img class="banner_img"  src="img/notice.png"></a></li>
			<li class="xans-record-"><a href="/faq" alt=" "><img class="banner_img"  src="img/question.png"></a></li>
			<li class="xans-record-"><a href="/qaa" alt=" "><img class="banner_img"  src="img/qaa.png"></a></li>
		</ul>
	</div>
</div>
</section>


<section id="aa-blog-archive">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-blog-archive-area">
						<div class="row">

							<div class="col-md-offset-1 col-md-10">
								<div class="aa-blog-content">
									<div class="row">
									
										<div class="col-sm-12">
					                        <h2 class="text-center" style="color:#3673be;"><strong>공지사항</strong></h2>
					                        
					                        <form>
					                        	
					                        	<input id="s_pagenum" name="s_pagenum" type="hidden" value="1" />
												<input id="s_pagesize" name="s_pagesize" type="hidden" value="10" />
												<input id="s_rowsize" name="s_rowsize" type="hidden" value="10" />
					                        	
					                        	<input name="bda_bdid" id="bda_bdid" type="hidden" value="oneone" />
					                        
						                        <div class="table-responsive">
						                            <table class="table table-hover table1">
						                            
						                            	<colgroup>
						                            		<col width="10%">
						                            		<col width="50%">
						                            		<col width="15%">
						                            		<col width="10%">
						                            		<col width="20%">
						                            	</colgroup>
						                            	
														<thead>
															<tr id="headtitle">
																<th class="hidden-xs">#</th>
																<th>제목</th>
																<th>작성자</th>
																<th class="hidden-sm hidden-xs">조회</th>
																<th class="hidden-xs">등록일</th>
															</tr>
														</thead>
														
														<tbody id="records">

														</tbody>
														
													</table>
						                        </div>
					                        </form>
										</div>
									</div>
								</div>
								
								
								<div class="aa-blog-archive-pagination">
									<nav id="paging">

									</nav>
								</div>
								
 								<div class="sd-blog-content" >
									<div class="col-sm-12 aa-login-form">
										<button class="aa-browse-btn" type="button" onclick="location.href='cs/noticewrite'"> 글쓰기</button>
									</div>
								</div>
								
								<div id="find">
								<select id="search_key" name="search_key" >
									<option value="subject">제목</option>
									<option value="content">내용</option>
									<option value="writer_name">글쓴이</option>
								</select> 
								<input id="search" name="search"  class="inputTypeText" type="text"> 
								<a href="#none" onclick="" class="btn btn-primary" id="click">검색</a></p>
								</div>
							   	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

 
<!-- -------------------------------Footer---------------------------------- -->
<jsp:include page="footer.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->

  </body>
</html>