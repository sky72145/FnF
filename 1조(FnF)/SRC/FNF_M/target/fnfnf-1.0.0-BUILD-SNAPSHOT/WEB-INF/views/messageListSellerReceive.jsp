<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%
//   /** 로그인.jsp에서 처리할 session값 저장**/ 
//   HttpSession Session = request.getSession(true);
//    String user_id="4444"; // == String sellerid = request.getParameter("id");  // jsp에서 넘어오는 input name="id" value="값"
//    Session.setAttribute("user_id", user_id);//sellerid라는 세션에 minho저장
//    /** 로그인.jsp에서 처리할 session값 저장**/
//    //다른 jsp파일 html body태그 안에서 sellerid세션 값을 사용하고 싶을 때 ${sessionScope.sellerid}
   
//    String id = (String)Session.getAttribute("user_id");//sellerid세션의 값을 변수 "id"에 저장
//  //html body태그 안에서 sellerid세션 값을 사용하고 싶을 때 <％=id％>
  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피셔스 앤 파머스</title>
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
<link id="switcher" href="css/theme-color/default-theme.css" rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="css/sequence-theme.modern-slide-in.css" rel="stylesheet" media="all">
<!-- Main style sheet -->
<link href="css/style1.css" rel="stylesheet">    
<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
<link href="css/sidebar.css" rel="stylesheet">
<link href="css/style2.css" rel="stylesheet"> 
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<style>
	th,td{
		text-align :center;
	}
	thead th {
	text-align: center;
}
	.sidebar-nav li a:hover {
		    color: white;
		    background: #9DC518;
		  }
</style>
<script src="js/jquery.min.js"></script> 
<script>
var page = null;
$(function(){
	
	//main체크박스 클릭시
	$('#ck_main').click(function(){
		var chk = $(this).is(":checked"); //mian chk
			if(chk){//선택
				$("input[name=ck_sub]").prop("checked", true);
			}else{//해제
				$("input[name=ck_sub]").prop("checked", false);
			}
	});
	
	$.ajax({
		url :  "/sellerRMSG/1", //controller --> /sellerRMSG/{page}
		dataType : "json",
		method : "POST",
		success : function(result){
			display(result);
		},
		error : function(err){
			console.log("err : " +err);
		}
	});//ajax
	
});//function()

//page 이동
function goPage(pge) {
	$("input[name=ck_main]").prop("checked", false);
	page = pge;
	$.ajax({
		url : "/sellerRMSG/"+ page,
		dataType : "json",
		method : "POST",
		success : function(result) {
			display(result);
		}
	});
}

// <th>읽은상태</th>
// <th>받는사람</th>
// <th>제목</th>
// <th>보낸날짜</th>
// <th>관리</th>
//MSG 리스트 뿌려줄 함수
function display(result) {
	var totalCount = result.totalCount;
	var startPage = result.startPage;
	var endPage = result.endPage;
	var totalPage = result.totalPage;
	var pageSize = result.pageSize;
	page = result.page; //current Page
	var result = result.data;
	var count = result.length;
	$("#Pcount").text(totalCount);
	var str = null;
	if (count == 0) {
		str +="<tr><td colspan='6' style='text-align:center'>메시지가 없습니다.</td></tr>";
	} else if (count > 0) {
		for (var i = 0; i < count; i++) {
			var writedate = result[i].writedate.substr(0, 10);
			str +="<tr>";
			str += "<td>";
            str +="<input name='ck_sub' type='checkbox' value="+result[i].idx+">";
            str +="</td>";
            if(result[i].status=="읽음"){// str +="<td>"+result[i].status+"</td>";
            	str +="<td><span class='far fa-envelope-open'></span></td>";
            }else{
            	str +="<td><span class='fas fa-envelope'></span></td>";
            }
            str +="<td>"+result[i].send_id+"</td>";
            str +="<td>"+result[i].title+"</td>";
            str +="<td>"+writedate+"</td>";
            str +="<td>";			//    /viewRMSG/{idx}
            str +="    <a href='/viewRMSG/"+result[i].idx+"'><button class='btn btn-info btn-xs'  type='button' title='보기'><span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span></button></a>";
            str +="    <button class='btn btn-danger btn-xs'  onclick='msgDel("+result[i].idx+")' type='button' title='삭제' ><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></button>";
            str +="</td>";
			str +="</tr>";
			//<a href='detail/"+result[i].idx+"'> == localhost:8080detail/4
		}
	}
	$("#ListAll").html(str);
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
}//display()


//단일 메시지 삭제 
function msgDel(idx){
	if(confirm('삭제 처리를 진행하시겠습니까?')){
		$.ajax({
			url : "/viewRMSG/"+parseInt(idx),
			//dataType: "json", RequestBody로 받을거 아니면 안적어두 된다.
			method : "PUT",
			success : function(data){
				alert("메시지가 삭제되었습니다.");
				location.href="/sellerRMSG";
			},
			error : function(err){
				console.log("err 발생 : " + err);
			}
		});
	}else{
		return;
	}
}

//체크 되어 있는 값 추출
//List 선택 메시지 삭제
function dataListDelUp(){
	var $chk_sub = $('input[name="ck_sub"]:checked');
	if( 1 > $chk_sub.length ){//체크가 없다면 length는 0
		alert('선택 된 메시지가 없습니다.');
		return;
 	}else{//체크가 있다면
		if( confirm( '삭제 처리를 진행하시겠습니까?' ) ){
	 		$chk_sub.each(function() {//반복문 돌려서 선택된 상품의 val()값 == 메시지idx값을 PUT로 보낸다.
	 			var test = $(this).val();
	 			$.ajax({
	 				url : "/viewRMSG/"+parseInt(test),
	 				method : "PUT",
	 				success : function(data){
	 					console.log("삭제 완료.");
	 				},
	 				error : function(err){
	 					console.log("err 발생 : " + err);
	 				}
	 			});
	 		});//each반복문
	 		alert("선택한 메시지가 삭제되었습니다.");
			location.href="/sellerRMSG";
		}else{
			return;
		}
 	}
 }//dataListDelUp();
 
 //등록버튼 누르면 페이지 이동
function dataAdd(){
	location.href="/message";
}
 
 //검색버튼 눌렀을 때
function dataSearch(){
	 //input tag들 value="" 초기값 
	var send_id = $("#send_id").val();
	var title = $("#title").val();
	var writedate = $("#writedate").val();

	if(send_id == "" && title == "" && writedate == ""){
		alert("검색할 내용을 입력해주세요.");
		return;
	}else{
		$.ajax({
			 url : "/sellerRMSG/dataSearch/1", //--> /sellerRMSG/dataSearch/{page}
			 dataType : "json",  //받는 type
			 method : "POST",
			 contentType : "application/json; charset=UTF-8",	//보내는 Type
			 data : JSON.stringify({
				 "send_id" :  send_id,
				 "title" : title,
				 "writedate" : writedate
			 }),
			 success : function(result){
				 displySearch(result);
			 },
			 error : function(err){
				 console.log("err 발생 : " + err);
			 }
		 });
	}
}
 
//SearchPage 이동
function goSearch(pge) {
	var send_id = $("#send_id").val();
	var title = $("#title").val();
	var writedate = $("#writedate").val();
	$("input[name=ck_main]").prop("checked", false);
	page = pge;
	//alert("sas");
	$.ajax({
		 url : "/sellerRMSG/dataSearch/" + page, //--> /sellerRMSG/dataSearch/{page}
		 dataType : "json",  //받는 type
		 method : "POST",
		 contentType : "application/json; charset=UTF-8",	//보내는 Type
		 data : JSON.stringify({
			 "send_id" :  send_id,
			 "title" : title,
			 "writedate" : writedate
		 }),
		 success : function(result){
			 displySearch(result);
		 },
		 error : function(err){
			 console.log("err 발생 : " + err);
		 }
	 });
}
 
 //검색data List뿌려주기
 function displySearch(result){
		var totalCount = result.totalCount;
		var startPage = result.startPage;
		var endPage = result.endPage;
		var totalPage = result.totalPage;
		var pageSize = result.pageSize;
		page = result.page; //current Page
		var result = result.data;
		var count = result.length;
		$("#Pcount").text(totalCount);
		var str = null;
		if (count == 0) {
			str +="<tr><td colspan='6' style='text-align:center'>메시지가 없습니다.</td></tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				var writedate = result[i].writedate.substr(0, 10);
				str +="<tr>";
				str += "<td>";
	            str +="<input name='ck_sub' type='checkbox' value="+result[i].idx+">";
	            str +="</td>";
	            if(result[i].status=="읽음"){// str +="<td>"+result[i].status+"</td>";
	            	str +="<td><span class='far fa-envelope-open'></span></td>";
	            }else{
	            	str +="<td><span class='fas fa-envelope'></span></td>";
	            }
	            str +="<td>"+result[i].send_id+"</td>";
	            str +="<td>"+result[i].title+"</td>";
	            str +="<td>"+writedate+"</td>";
	            str +="<td>";			//    /viewRMSG/{idx}
	            str +="    <a href='/viewRMSG/"+result[i].idx+"'><button class='btn btn-info btn-xs'  type='button' title='보기'><span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span></button></a>";
	            str +="    <button class='btn btn-danger btn-xs'  onclick='msgDel("+result[i].idx+")' type='button' title='삭제' ><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></button>";
	            str +="</td>";
				str +="</tr>";
				//<a href='detail/"+result[i].idx+"'> == localhost:8080detail/4
			}
		}
		$("#ListAll").html(str);
		$("#paging").empty();
		$("#paging").attr("style", "text-align:center");

		var pageStr = null;
		// <<  <
		if (page == 1) { //현재페이지가 1일 때
			pageStr = "<button type='button' class='btn btn-info btn-sm'>처음</button>&nbsp;&nbsp;&nbsp;";
			pageStr += "<button type='button' class='btn btn-default btn-sm'>이전</button>&nbsp;&nbsp;";
		} else if (page != 1) { // 현재페이지가 1이 아닐 때
			pageStr = "<a href='javascript:goSearch(1)'><button type='button' class='btn btn-info btn-sm'>처음</button></a>&nbsp;&nbsp;&nbsp;";
			if((startPage - pageSize) <= 0){
				pageStr += "<a href='javascript:goSearch(" + 1 + ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
			}else{
				pageStr += "<a href='javascript:goSearch(" + (startPage - pageSize) 	+ ")'><button type='button' class='btn btn-default btn-sm'>이전</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}
		
		// 1 2 3 4 5 6 7 8 9 10
		if(endPage <=10){ // 끝 나는 페이지가 10보다 작으면
			for (var k = 1; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
				else  //현재페이지가 아닌
					pageStr += "<a href='javascript:goSearch(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}else{
			for (var k = startPage; k <= endPage; k++) {
				if (page == k) //현재 페이지
					pageStr += "<button class='btn btn-default btn-sm active' type='button'>"+k+"</button>&nbsp;&nbsp;&nbsp;";
				else  //현재페이지가 아닌
					pageStr += "<a href='javascript:goSearch(" + k + ")'><button class='btn btn-default btn-sm' type='button'>" + k + "</button></a>&nbsp;&nbsp;&nbsp;";
			}
		}
		
		// >  >>
		if (page == totalPage) {
			pageStr += "<button type='button' class='btn btn-default btn-sm'>다음</button>&nbsp;&nbsp;&nbsp;";
			pageStr += "<button type='button'  class='btn btn-info btn-sm'>끝</button>";
		} else if (page != totalPage) {
			pageStr += "<a href='javascript:goSearch(" + (startPage + pageSize) + ")'><button type='button' class='btn btn-default btn-sm'>다음</button></a>&nbsp;&nbsp;&nbsp;";
			pageStr += "<a href='javascript:goSearch(" + totalPage + ")'><button type='button'  class='btn btn-info btn-sm'>끝</button></a>";
		}
		$("#paging").html(pageStr);
	}//displySearch()
 
	 //전체목록 버튼
	 function returnList(){
		$("#send_id").val("");
		$("#title").val("");
		$("#writedate").val("");//input값 초기화
		$.ajax({
			url :  "/sellerRMSG/1", //controller --> /sellerRMSG/{page}
			dataType : "json",
			method : "POST",
			success : function(result){
				display(result);
			},
			error : function(err){
				console.log("err : " +err);
			}
		});//ajax
	 }//returnList()
	 
</script>
</head>
<body>
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->

<section id="aa-popular-category" style="
    padding-top: 0px;
    padding-bottom: 0px;
">
	<div id="wrapper" style="padding-left: 300px; padding-right: 300px;">
		<!-- 사이드바 -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li><img src="img/user.png" id="us"
					class="img-reponsive img-circle" width="100px" height="100px">
				</li>
				<li><hr></li>
				<li>[상품관리]</li>
				<li><a href="/sellerPL">상품리스트</a></li>
				<li><a href="/sellerPR">상품등록</a></li>
				<li><hr></li>
				<li>[주문관리]</li>
				<li><a href="/sellerOL">전체주문관리</a></li>
				<li><hr></li>
				<li>[메시지]</li>
				<li><a href="/sellerRMSG">받은메시지</a></li>
				<li><a href="/sellerSMSG">보낸메시지</a></li>
			</ul>
		</div>
		<!-- /사이드바 -->
<!-- ---------------------상품테이블------------------------------- -->
					<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12" style="padding-left: 30px;">
								<div class="x_panel">
									<div class="x_title">
										<h1 style="padding-top: 20px;">받은 메시지</h1>
										<hr>
										<br>
               						 <h3>메시지 검색</h3>
									</div>
									<hr>
									<div class="x_content">
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_code" style=" text-align: right;">보낸 사람</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="send_id" name="send_id" placeholder="보낸 사람" type="text" value="" />
											</div>
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_name" style=" text-align: right;">제목</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="title" name="title" placeholder="제목" type="text" value="" />
											</div>											
										</div>
										<br><br>
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="pr_writedate" style=" text-align: right;">등록일</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="writedate" name="writedate" placeholder="yyyy-mm-dd" type="text" value="" />
											</div>	
<!-- 											<label class="col-sm-2 col-xs-12 control-label" for="pr_writedate" style=" text-align: right;">등록일</label> -->
<!-- 											<div class="col-sm-4 col-xs-12"> -->
<!-- 												<input class="form-control" id="writedate" name="writedate" placeholder="yyyy-mm-dd" type="text" value="" /> -->
<!-- 											</div>	 -->
										</div>
										<br><br>
										
										<div class="form-group">
											<div class="col-xs-12"  style="padding-bottom: 10px;">
												<button class="btn btn-info btn-lg btn-block" onclick="dataSearch()" type="button" title="검색">검색</button>
											</div>
											<div class="col-xs-12">
												<button class="btn btn-basic btn-lg btn-block" onclick="returnList()" type="button" title="전체목록">전체목록</button>
											</div>
										</div>
									
									</div>
								</div>
							</div>
						</div>
						<hr>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-left: 30px;">
        <div class="x_panel">
            <div class="x_title">
                <h3>메시지 리스트</h3>
                <hr>
                <ul class="nav navbar-right panel_toolbox">
                    <li>[ Total  <span id="Pcount"></span> Rows ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
                </ul>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">

                <div class="table-responsive">
                    <table class="table table-hover table1">
                        <thead>
                            <tr>
                                <th>
                                    <input id="ck_main" name="ck_main" type="checkbox" />
                                </th>
                                <th>상태</th>
                                <th>보낸사람</th>
                                <th>제목</th>
                                <th>받은날짜</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody id="ListAll"></tbody>
                        </table>
                    </div>
<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
<!-- ------------------------------번호판 넣을 자리-------------------------------------- -->
						<div id="paging"></div>
						<hr>
						</div>
                    <div class="col-md-8 col-sm-12">
                    <button class="btn btn-info btn-sm" onclick="dataAdd()" type="button" title="메시지쓰기">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>쓰기</button>
 					<button class="btn btn-danger btn-sm" onclick="dataListDelUp()" type="button" title="선택삭제">
						<span class="glyphicon glyphicon-check" aria-hidden="true"></span>삭제</button>
                    </div>
                    </div>
                    </div>
               </div>
                <hr><br><br>
<!-- ------------------------------------------------------ -->
</div>
</section>



<!-- ------------------------------------------------------- -->
<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
  
  
  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="js/sequence.js"></script>
  <script src="js/sequence-theme.modern-slide-in.js"></script>  
  <!-- Product view slider -->
  <script type="text/javascript" src="js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="js/custom.js"></script> 
</body>
</html>

