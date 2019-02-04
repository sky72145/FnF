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
    <link href="/resources/css/font-awesome.css" rel="stylesheet">  
    <!-- Bootstrap -->
    <link href="/resources/css/bootstrap.css" rel="stylesheet">   
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="/resources/css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="/resources/css/theme.css" rel="stylesheet">
    <!-- Top Slider CSS -->
    <link href="/resources/css/slide.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="/resources/css/style2.css" rel="stylesheet">    

  
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
	
	#paging{
		margin: 10px 0 30px 0;
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
			url : "/faq/1",
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
			url : "/faq/" + pge,
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
			var faq = data[i];
			var writedate = faq.writedate.substr(0, 10);
			/* var reimg = "";
			if(lev > 0) {
				for(var j = 0 ; j < lev ; j++){
					reimg +="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				}
				reimg += "<img src='static/images/re.png' style='width:20px;height:20px'/>";
			}else reimg = ""; */
			str += "<tr>";
			str += "<td>" + faq.idx + "</td>" + 
					"<td>&nbsp;"  + "<a href='/faq/" + page + "/" + faq.idx +
					"'>" + faq.title + "</a></td>" +
					"<td>" + faq.user_id + "</td>" +
					"<td>" + faq.readnum + "</td>"+
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
	
	//Search List
	function Search(){
		var key = $("#search_key").val();
		var data = $("#searchData").val();
		var user_id = "";
		var title = "";
		var contents = "";
		//alert($("#searchData").val());
		if(key == "제목"){
			title = data;
		}
		if(key == "내용"){
			contents = data;
		}
		if(key == "아이디"){
			user_id = data;
		}
		
		$.ajax({
			url : "faq/search/1",
			dataType : "json",
			method : "POST",
			contentType: "application/json; charset=utf-8",
			data : JSON.stringify({
				"title" : title,
				"contents" : contents,
				"user_id" : user_id
			}),
			success : function(result){
				//console.log(result);
				displaySearch(result);
			},
			error : function(err){
				console.log("err 발생 : " + err);
			}
		}); 
	}
	
	//SearchPage 이동
	function goSearchPage(pge) {
		page = pge;
		$.ajax({
			url : "faq/search/"+ page,
			dataType : "json",
			method : "POST",
			success : function(result) {
				displaySearch(result);
			}
		});
	}
	 
	 //검색data List뿌려주기
	 function displaySearch(result){
		 var totalCount = result.totalCount;
			var startPage = result.startPage;
			var endPage = result.endPage;
			var totalPage = result.totalPage;
			var pageSize = result.pageSize;
			page = result.page; //current Page
			var result = result.data;
			var count = result.length;
			var str = null;
			if (count == 0) {
				str +="<tr><td colspan='9' style='text-align:center'>검색과 일치하는 글이 없습니다.</td></tr>";
			} else if (count > 0) {
				for(var i = 0 ; i < count ; i++){
					var faq = result[i];
					var writedate = faq.writedate.substr(0, 10);
					/* var reimg = "";
					if(lev > 0) {
						for(var j = 0 ; j < lev ; j++){
							reimg +="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
						}
						reimg += "<img src='static/images/re.png' style='width:20px;height:20px'/>";
					}else reimg = ""; */
					str += "<tr>";
					str += "<td>" + faq.idx + "</td>" +
							"<td>&nbsp;"  + "<a href='/faq/" + page + "/" + faq.idx +
							"'>" + faq.title + "</a></td>" +
							"<td>" + faq.user_id + "</td>" +
							"<td>" + faq.readnum + "</td>"+
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
				pageStr = "<a href='javascript:goSearchPage(1)'><button type='button' class='btn btn-info btn-sm'>처음</button></a>&nbsp;&nbsp;&nbsp;";
				if((startPage - pageSize) <= 0){
					pageStr += "<a href='javascript:goSearchPage(" + 1 + ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
				}else{
					pageStr += "<a href='javascript:goSearchPage(" + (startPage - pageSize) 	+ ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
				}
			}
			
			// 1 2 3 4 5 6 7 8 9 10
			if(endPage <=10){ // 끝 나는 페이지가 10보다 작으면
				for (var k = 1; k <= endPage; k++) {
					if (page == k) //현재 페이지
						pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
					else  //현재페이지가 아닌
						pageStr += "<a href='javascript:goSearchPage(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
				}
			}else{
				for (var k = startPage; k <= endPage; k++) {
					if (page == k) //현재 페이지
						pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
					else  //현재페이지가 아닌
						pageStr += "<a href='javascript:goSearchPage(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
				}
			}
			
			// >  >>
			if (page == totalPage) {
				pageStr += "<button type='button' class='btn btn-default btn-sm'>다음</button>&nbsp;&nbsp;&nbsp;";
				pageStr += "<button type='button'  class='btn btn-info btn-sm'>끝</button>";
			} else if (page != totalPage) {
				pageStr += "<a href='javascript:goSearchPage(" + (startPage + pageSize) + ")'><button type='button' class='btn btn-default btn-sm'>다음</button></a>&nbsp;&nbsp;&nbsp;";
				pageStr += "<a href='javascript:goSearchPage(" + totalPage + ")'><button type='button'  class='btn btn-info btn-sm'>끝</button></a>";
			}
			$("#paging").html(pageStr);
		}
  </script>
</head>
<body>

<!-- -------------------------------Header---------------------------------- -->
 <jsp:include page="../header.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->


<section id="aa-banner">


<div class="widget_customer_page_info">
	<img src="/resources/img/step.png" usemap="#Map">
&nbsp;</div>

<div class="fixed_customer_page">

	<div class="banner">
	
		<ul>
			<li class="xans-record-"><a href="/cs" alt=" "><img class="banner_img"  src="img/notice.png"></a></li>
			<li class="xans-record-"><a href="faq" alt=" "><img class="banner_img"  src="img/faq.png"></a></li>
			<li class="xans-record-"><a href="qaa" alt=" "><img class="banner_img"  src="img/qaa.png"></a></li>
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
					                        <h2 class="text-center" style="color:#3673be;"><strong>자주 묻는 질문</strong></h2>
					                        <form action="boardarticlelist.sd" class="form-horizontal" name="frm" id="frm" method="post">
					                        	
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

										<ul class="pagination">

														<li><a aria-label="Previous" href="javascript:;" ><span aria-hidden="true">처음</span></a></li>
														<li><a aria-label="Previous" href="javascript:;" ><span aria-hidden="true">이전</span></a></li>
														
														<li class="active"><a href="javascript:;" >1</a></li>
												
														<li><a aria-label="Next" href="javascript:;" > <span aria-hidden="true">다음</span> </a></li>
														<li><a aria-label="Next" href="javascript:;" > <span aria-hidden="true">끝</span> </a></li>

										</ul>
									</nav>
								</div>
							
								
								<div id="find">
								<select id="search_key" name="search_key" >
									<option value="제목">제목</option>
									<option value="내용">내용</option>
									<option value="아이디">아이디</option>
								</select> 
								<input id="searchData" name="search"  class="inputTypeText" type="text"> 
								<button type="button" onclick="Search()" class="btn btn-primary" id="click">검색</button>
								</div>
							   	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	

<!-- -------------------------------Footer---------------------------------- -->
<jsp:include page="../footer.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->


  </body>
</html>