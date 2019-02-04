<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <%
//   /** 로그인.jsp에서 처리할 session값 저장**/ 
//   HttpSession Session = request.getSession(true);
//    String user_id="minho";// == String sellerid = request.getParameter("id");  // jsp에서 넘어오는 input name="id" value="값"
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

<style>
th, td {
	text-align: center;
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
		url :  "/sellerOL/1", //controller --> /sellerOL/{page}
		dataType : "json",
		method : "POST",
		success : function(result){
			//console.log(result);
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
		url : "/sellerOL/"+ page,
		dataType : "json",
		method : "POST",
		success : function(result) {
			display(result);
		}
	});
}

//주문 리스트 뿌려줄 함수
function display(result) {
	var totalCount = result.totalCount;
	var startPage = result.startPage;
	var endPage = result.endPage;
	var totalPage = result.totalPage;
	var pageSize = result.pageSize;
	page = result.page; //current Page
	var result = result.data;
	console.log(result);
	var count = result.length;
	$("#Pcount").text(totalCount);
	$("#count").text(count);
	var str = null;
	if (count == 0) {
		str +="<tr><td colspan='14' style='text-align:center'>등록된 주문이 없습니다.</td></tr>";
	} else if (count > 0) {
		var cnt = 0;
		var j = 1;
		for (var i=0 ; i < count; i++) {
			var writedate = result[i].pay_date.substr(0, 10);
			var del_name = result[i].del_name;
			var del_code = result[i].del_code;
			if(del_name == null){ del_name = "";}
			if(del_code == null){ del_code = "";}

			if(count >1 && result[i].idx == result[j].idx && i != j){
				cnt++;
			}else{
				str +="<tr>";
				str += "<td>";
	            str +="<input name='ck_sub' type='checkbox' value="+result[i].order_idx+">";
	            str +="</td>";
	            str +="<td>"+result[i].idx+"</td>";
	            if(cnt > 0){str +="<td>"+result[i].pname+" 외 "+cnt+"개</td>";}
	            else{str +="<td>"+result[i].pname+"</td>";}
	            str +="<td>"+result[i].user_name+"("+result[i].user_id+")</td>";
	            str +="<td class='text-right'>";
	            str +=""+addComma(result[i].del_price)+"원";
	            str +="</td>";
	            str +="<td class='text-right'>";
	            str +=""+addComma(result[i].totalprice)+"원";
	            str +="</td>";
	            str +="<td>"+result[i].receiver_name+"</td>";
	            str +="<td>"+del_name+"</td>";
	            str +="<td>"+del_code+"</td>";
	            str +="<td>"+result[i].pay+"</td>";
	            str +="<td>"+result[i].status+"</td>";
	            str +="<td>"+writedate+"</td>";
	            str +="<td></td>";
	            str +="<td>";		
	            str +="    <button class='btn btn-warning btn-xs'onclick='orderUp("+result[i].idx+")' type='button' title='보기' ><span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span></button>";
	            str +="</td>";
				str +="</tr>";
				cnt = 0;//카운트 초기화
			}
			if(j<count-1){j++;}
		}//for문
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

//가격 세자리마다 , 찍기
function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}

//주문 수정 sellerPU/idx
function orderUp(idx){
	//console.log(typeof idx);
	var n = idx.toString();
	location.href="/sellerOD/"+n+"";
}

 
 
 //상품검색버튼 눌렀을 때
function dataSearch(){
	 //input tag들 value="" 초기값 
	var pay = $("#pay").val();
	var status = $("#status").val();
	var idx = $("#idx").val();
	var pname = $("#pname").val();
	var user_name = $("#user_name").val();
	var receiver_name = $("#receiver_name").val();
	if(pay == "" && status == "" && idx == "" && pname == "" && user_name == "" && receiver_name == ""){
		alert("검색할 내용을 입력해주세요.");
		return;
	}else{
		$.ajax({
			 url : "/sellerOL/dataSearch/1", //--> /sellerOL/dataSearch/{page}
			 dataType : "json",  //받는 type
			 method : "POST",
			 contentType : "application/json; charset=UTF-8",	//보내는 Type
			 data : JSON.stringify({
				 "pay" :  pay,
				 "status" : status,
				 "idx" : idx,
				 "pname" : pname,
				 "user_name" : user_name,
				 "receiver_name" : receiver_name
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
function goSearchPage(pge) {
	var pay = $("#pay").val();
	var status = $("#status").val();
	var idx = $("#idx").val();
	var pname = $("#pname").val();
	var user_name = $("#user_name").val();
	var receiver_name = $("#receiver_name").val();
	$("input[name=ck_main]").prop("checked", false);
	page = pge;
	$.ajax({
		 url : "/sellerOL/dataSearch/" + page, //--> /sellerOL/dataSearch/{page}
		 dataType : "json",  //받는 type
		 method : "POST",
		 contentType : "application/json; charset=UTF-8",	//보내는 Type
		 data : JSON.stringify({
			 "pay" :  pay,
			 "status" : status,
			 "idx" : idx,
			 "pname" : pname,
			 "user_name" : user_name,
			 "receiver_name" : receiver_name
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
		$("#count").text(count);
		var str = null;
		if (count == 0) {
			str +="<tr><td colspan='14' style='text-align:center'>등록된 주문이 없습니다.</td></tr>";
		} else if (count > 0) {
			var cnt = 0;
			var j = 1;
			for (var i=0 ; i < count; i++) {
				var writedate = result[i].pay_date.substr(0, 10);
				var del_name = result[i].del_name;
				var del_code = result[i].del_code;
				if(del_name == null){ del_name = "";}
				if(del_code == null){ del_code = "";}
				if(count >1 && result[i].idx == result[j].idx && i != j){
						cnt++;
				}else{
					str +="<tr>";
					str += "<td>";
		            str +="<input name='ck_sub' type='checkbox' value="+result[i].order_idx+">";
		            str +="</td>";
		            str +="<td>"+result[i].idx+"</td>";
		            if(cnt > 0){str +="<td>"+result[i].pname+" 외 "+cnt+"개</td>";}
		            else{str +="<td>"+result[i].pname+"</td>";}
		            str +="<td>"+result[i].user_name+"("+result[i].user_id+")</td>";
		            str +="<td class='text-right'>";
		            str +=""+addComma(result[i].del_price)+"원";
		            str +="</td>";
		            str +="<td class='text-right'>";
		            str +=""+addComma(result[i].totalprice)+"원";
		            str +="</td>";
		            str +="<td>"+result[i].receiver_name+"</td>";
		            str +="<td>"+del_name+"</td>";
		            str +="<td>"+del_code+"</td>";
		            str +="<td>"+result[i].pay+"</td>";
		            str +="<td>"+result[i].status+"</td>";
		            str +="<td>"+writedate+"</td>";
		            str +="<td></td>";
		            str +="<td>";		
		            str +="    <button class='btn btn-warning btn-xs'onclick='orderUp("+result[i].idx+")' type='button' title='보기' ><span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span></button>";
		            str +="</td>";
					str +="</tr>";
					cnt = 0;//카운트 초기화
				}
				if(j<count-1){j++;}
			}//for문
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
	}//displySearch()
 
	 //전체목록 버튼
	 function returnList(){
		 $("#pay").val("");
		$("#status").val("");
		$("#idx").val("");
		$("#pname").val("");
		$("#user_name").val("");
		$("#receiver_name").val("");//input값 초기화
		 $.ajax({
				url :  "/sellerOL/1", //controller --> /sellerOL/{page}
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
										<h1 style="padding-top: 20px;">주문 관리</h1>
										<hr>
										<br>
               						 <h3>주문 검색</h3>
									</div>
									<hr>
									<div class="x_content">
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="pr_prcseq" style=" text-align: right;">결제타입</label>
													<div class="col-sm-4 col-xs-12">
														<select class="form-control" id="pay" name="pay">
															<option value="">선택</option>
																<option value="무통장">무통장</option>
																<option value="카카오페이">카카오페이</option>
														</select>
													</div>
													<label class="col-sm-2 col-xs-12 control-label" for="pr_prcseq" style=" text-align: right;">주문상태</label>
													<div class="col-sm-4 col-xs-12">
														<select class="form-control" id="status" name="status">
															<option value="">선택</option>
															<option value="입금대기">입금대기</option>
															<option value="결제완료">결제완료</option>
															<option value="구매확정">구매확정</option>
														</select>
													</div>
										</div>
										<br><br>
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_code" style=" text-align: right;">주문번호</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="idx" name="idx" placeholder="주문번호" type="text" value="" />
											</div>
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_name" style=" text-align: right;">상품명</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="pname" name="pname" placeholder="상품명" type="text" value="" />
											</div>											
										</div>
										<br><br>
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_origin" style=" text-align: right;">회원명</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="user_name" name="user_name" placeholder="회원명" type="text" value="" />
											</div>
											<label class="col-sm-2 col-xs-12 control-label" for="pr_writedate" style=" text-align: right;">받으시는 분</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="receiver_name" name="receiver_name" placeholder="받으시는 분" type="text" value="" />
											</div>	
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
                <h3>주문 리스트</h3>
                <hr>
                <ul class="nav navbar-right panel_toolbox">
                    <li>[ Total  <span id="Pcount"></span> Rows ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
<!--                     <li>[ 게시글 수  <span id="count"></span> ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li> -->
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
                                <th>주문번호</th>
                                <th>주문상품</th>
                                <th>회원명</th>
                                <th>배송비</th>
                                <th>결제금액</th>
                                <th>받으시는분</th>
                                <th>배송업체</th>
                                <th>송장번호</th>
                                <th>결제타입</th>
                                <th>상태값</th>
                                <th>주문일</th>
                                <th>주문처리</th>
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

