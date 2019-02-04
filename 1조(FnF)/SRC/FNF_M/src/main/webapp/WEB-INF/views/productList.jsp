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
HttpSession Session = request.getSession();
String u = (String)Session.getAttribute("user_id");//자신
String r = null;//받은 세션아이디
for(int i = 1; i < 100000 ; i ++){
	if(u.equals((String)application.getAttribute("receive_id"+i+""))){//자신과 받은 appScope가 같으면
		r = (String)application.getAttribute("receive_id"+i+"");//r에 appScope 값을 저장//다른페이지
// 		application.removeAttribute("receive_id"+i+"");//그 어플값은 지운다. //받은 메시지페이지
	}
}
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
	//New Message
	var re = "<%=r%>";
	if(re == "${sessionScope.user_id}"){
		var str = "&nbsp;&nbsp;<img src='img/new-icon.png' width='25px' height='15px'>";
		$("#newMSG").html(str);
	}
	
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
		url :  "/sellerPL/1", //controller --> /sellerPL/{page}
		dataType : "json",
		method : "POST",
		success : function(result){
			display(result);
		},
		error : function(err){
			console.log("err : " +err);
		}
	});//ajax
	
	 //상품종류 선택할 때
    $("#category").change(function(){
    	//alert($("#category").val());
    	if(($("#category").val()) == "농산물"){
	    	var str ="<option value=''>선택</option>";
	    	str += "<option value='채소'>채소</option>" +
	    				"<option value='과일'>과일</option>" +
	    				"<option value='쌀,잡곡류'>쌀,잡곡류</option>" +
	    				"<option value='견과류'>견과류</option>";
	    	$("#category2").html(str);
    	}else if(($("#category").val()) == "수산물"){
    		var str="<option value=''>선택</option>";
    		str += "<option value='생선'>생선</option>" +
							"<option value='갑각류'>갑각류</option>" +
							"<option value='해조류'>해조류</option>" +
							"<option value='건어물'>건어물</option>";
    		$("#category2").html(str);
    	}else if(($("#category").val()) == "가공식품"){
    		var str="<option value=''>선택</option>";
    		str += "<option value='즙류'>즙류</option>" +
							"<option value='분말류'>분말류</option>" +
							"<option value='잼류'>잼류</option>";
    		$("#category2").html(str);
    	}else if(($("#category").val()) == ""){
    		var str="<option value=''>선택</option>";
    		$("#category2").html(str);
    	}
    });
	
});//function()

//page 이동
function goPage(pge) {
	$("input[name=ck_main]").prop("checked", false);
	page = pge;
	$.ajax({
		url : "/sellerPL/"+ page,
		dataType : "json",
		method : "POST",
		success : function(result) {
			display(result);
		}
	});
}

//상품 리스트 뿌려줄 함수
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
	$("#count").text(count);
	var str = null;
	if (count == 0) {
		str +="<tr><td colspan='9' style='text-align:center'>등록된 상품이 없습니다.</td></tr>";
	} else if (count > 0) {
		for (var i = 0; i < count; i++) {
			var writedate = result[i].writedate.substr(0, 10);
			str +="<tr>";
			str += "<td>";
            str +="<input name='ck_sub' type='checkbox' value="+result[i].idx+">";
            str +="</td>";
            str +="<td>"+result[i].pcode+"</td>";
            str +="<td>"+result[i].pname+"</td>";
            str +="<td>";
            str +="    <img src='img/"+result[i].filename+"' width='45' height='55'/>";
            str +="</td>";
            str +="<td>"+result[i].category+"&nbsp;&gt;&nbsp;"+result[i].category2+"</td>";
            str +="<td class='text-right'>";
            str +=""+addComma(result[i].price)+"원";
            str +="</td>";
            str +="<td>"+result[i].sell_num+"</td>";
            str +="<td>"+writedate+"</td>";
            str +="<td>";			//    /PD/{idx}
            str +="    <a href='/PD/"+result[i].idx+"'><button class='btn btn-info btn-xs'  type='button' title='보기'><span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span></button></a>";
            str +="    <button class='btn btn-warning btn-xs'onclick='productUp("+result[i].idx+")' type='button' title='수정' ><span class='glyphicon glyphicon-cog' aria-hidden='true'></span></button>";
            str +="    <button class='btn btn-danger btn-xs'  onclick='productDel("+result[i].idx+")' type='button' title='삭제' ><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></button>";
            str +="</td>";
			str +="</tr>";
			//<a href='detail/"+result[i].idx+"'> == localhost:8080 detail/4
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

//가격 세자리마다 , 찍기
function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}

//상품 수정 sellerPU/idx
function productUp(idx){
	location.href="/sellerPU/"+idx;
}

//단일 상품 삭제 sellerPL/idx
function productDel(idx){
	//alert(idx);
	if(confirm('삭제 처리를 진행하시겠습니까?')){
		$.ajax({
			url : "/sellerPL/"+parseInt(idx),
			//dataType: "json", RequestBody로 받을거 아니면 안적어두 된다.
			method : "DELETE",
			success : function(data){
				alert("상품이 삭제되었습니다.");
				location.href="/sellerPL";
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
//List 선택 상품 삭제
function dataListDelUp(){
	var $chk_sub = $('input[name="ck_sub"]:checked');
	if( 1 > $chk_sub.length ){//체크가 없다면 length는 0
		alert('선택 된 상품이 없습니다.');
		return;
 	}else{//체크가 있다면
		if( confirm( '삭제 처리를 진행하시겠습니까?' ) ){
	 		$chk_sub.each(function() {//반복문 돌려서 선택된 상품의 val()값 == 상품idx값을 DELETE로 보낸다.
	 			var test = $(this).val();
	 			$.ajax({
	 				url : "/sellerPL/"+parseInt(test),
	 				method : "DELETE",
	 				success : function(data){
	 					console.log("삭제완료");
	 				},
	 				error : function(err){
	 					console.log("err 발생 : " + err);
	 				}
	 			});
	 		});//each반복문
	 		alert("상품이 삭제되었습니다.");
			location.href="/sellerPL";
		}else{
			return;
		}
 	}
 }//dataListDelUp();
 
 //등록버튼 누르면 페이지 이동
function dataAdd(){
	location.href="/sellerPR";
}
 
 //상품검색버튼 눌렀을 때
 //category, category2 , pcode, pname, origin, writedate
function dataSearch(){
	 //input tag들 value="" 초기값 
	var category = $("#category").val();
	var category2 = $("#category2").val();
	var pcode = $("#pcode").val();
	var pname = $("#pname").val();
	var origin = $("#origin").val();
	var writedate = $("#writedate").val();
	if(category == "" && category2 == "" && pcode == "" && pname == "" && origin == "" && writedate == ""){
		alert("검색할 내용을 입력해주세요.");
		return;
	}else{
		$.ajax({
			 url : "/sellerPL/dataSearch/1", //--> /sellerPL/dataSearch/{page}
			 dataType : "json",  //받는 type
			 method : "POST",
			 contentType : "application/json; charset=UTF-8",	//보내는 Type
			 data : JSON.stringify({
				 "category" :  category,
				 "category2" : category2,
				 "pcode" : pcode,
				 "pname" : pname,
				 "origin" : origin,
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
function goSearchPage(pge) {
	var category = $("#category").val();
	var category2 = $("#category2").val();
	var pcode = $("#pcode").val();
	var pname = $("#pname").val();
	var origin = $("#origin").val();
	var writedate = $("#writedate").val();
	$("input[name=ck_main]").prop("checked", false);
	page = pge;
	$.ajax({
		 url : "/sellerPL/dataSearch/"+page, //--> /sellerPL/dataSearch/{page}
		 dataType : "json",  //받는 type
		 method : "POST",
		 contentType : "application/json; charset=UTF-8",	//보내는 Type
		 data : JSON.stringify({
			 "category" :  category,
			 "category2" : category2,
			 "pcode" : pcode,
			 "pname" : pname,
			 "origin" : origin,
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
		$("#count").text(count);
		var str = null;
		if (count == 0) {
			str +="<tr><td colspan='9' style='text-align:center'>등록된 상품이 없습니다.</td></tr>";
		} else if (count > 0) {
			for (var i = 0; i < count; i++) {
				var writedate = result[i].writedate.substr(0, 10);
				str +="<tr>";
				str += "<td>";
	            str +="<input name='ck_sub' type='checkbox' value="+result[i].idx+">";
	            str +="</td>";
	            str +="<td>"+result[i].pcode+"</td>";
	            str +="<td>"+result[i].pname+"</td>";
	            str +="<td>";
	            str +="    <img src='img/"+result[i].filename+"' width='45' height='55'/>";
	            str +="</td>";
	            str +="<td>"+result[i].category+"&nbsp;&gt;&nbsp;"+result[i].category2+"</td>";
	            str +="<td class='text-right'>";
	            str +=""+addComma(result[i].price)+"원";
	            str +="</td>";
	            str +="<td>"+result[i].sell_num+"</td>";
	            str +="<td>"+writedate+"</td>";
	            str +="<td>";			//    /PD/{idx}
	            str +="    <a href='/PD/"+result[i].idx+"'><button class='btn btn-info btn-xs'  type='button' title='보기'><span class='glyphicon glyphicon-eye-open' aria-hidden='true'></span></button></a>";
	            str +="    <button class='btn btn-warning btn-xs'onclick='productUp("+result[i].idx+")' type='button' title='수정' ><span class='glyphicon glyphicon-cog' aria-hidden='true'></span></button>";
	            str +="    <button class='btn btn-danger btn-xs'  onclick='productDel("+result[i].idx+")' type='button' title='삭제' ><span class='glyphicon glyphicon-trash' aria-hidden='true'></span></button>";
	            str +="</td>";
				str +="</tr>";
				//<a href='detail/"+result[i].idx+"'> == localhost:8080 detail/4
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
		$("#category").val("");
		$("#category2").val("");
		$("#pcode").val("");
		$("#pname").val("");
		$("#origin").val("");
		$("#writedate").val("");//input값 초기화
		 $.ajax({
				url :  "/sellerPL/1", //controller --> /sellerPL/{page}
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
				<h1>&nbsp;&nbsp;&nbsp;Category</h1>
				<li></li>
				<li><strong class="text-success" style="font-size:20px">[상품관리]</strong></li>
				<li><a href="/sellerPL">상품리스트</a></li>
				<li><a href="/sellerPR">상품등록</a></li>
				<li><h1></h1></li>
				<li><strong class="text-success" style="font-size:20px">[주문관리]</strong></li>
				<li><a href="/sellerOL">전체주문관리</a></li>
				<li><h1></h1></li>
				<li><strong class="text-success" style="font-size:20px">[메시지]</strong></li>
				<li><a href="/sellerRMSG">받은메시지<span id="newMSG"></span></a></li>
				<li><a href="/sellerSMSG">보낸메시지</a></li>
			</ul>
		</div>
		<!-- /사이드바 -->
<!-- ---------------------상품테이블------------------------------- -->
					<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12" style="padding-left: 30px;">
								<div class="x_panel">
									<div class="x_title">
										<h1 style="padding-top: 20px;">상품관리</h1>
										<hr>
										<br>
               						 <h3>상품 검색</h3>
									</div>
									<hr>
									<div class="x_content">
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="pr_prcseq" style=" text-align: right;">상품카테고리</label>
											<div class="col-sm-10 col-xs-12">
												<div class="row">
													<div class="col-sm-3 col-xs-12">
														<select class="form-control" id="category" name="category">
															<option value="">선택</option>
																<option value="농산물">농산물</option>
																<option value="수산물">수산물</option>
																<option value="가공식품" >가공식품</option>
														</select>
													</div>
													<div class="col-sm-3 col-xs-12">
														<select class="form-control" id="category2" name="category2">
															<option value="">선택</option>
														</select>
													</div>
												</div>
											</div>
										</div>
										<br><br>
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_code" style=" text-align: right;">상품코드</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="pcode" name="pcode" placeholder="상품코드" type="text" value="" />
											</div>
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_name" style=" text-align: right;">상품명</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="pname" name="pname" placeholder="상품명" type="text" value="" />
											</div>											
										</div>
										<br><br>
										<div class="form-group">
											<label class="col-sm-2 col-xs-12 control-label" for="s_like_pr_origin" style=" text-align: right;">원산지</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="origin" name="origin" placeholder="원산지" type="text" value="" />
											</div>
											<label class="col-sm-2 col-xs-12 control-label" for="pr_writedate" style=" text-align: right;">등록일</label>
											<div class="col-sm-4 col-xs-12">
												<input class="form-control" id="writedate" name="writedate" placeholder="yyyy-mm-dd" type="text" value="" />
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
                <h3>상품 리스트</h3>
                <hr>
                <ul class="nav navbar-right panel_toolbox">
                    <li>[ Total  <span id="Pcount"></span> Rows ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
                    <li>[ 게시글 수  <span id="count"></span> ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
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
                                <th>상품코드</th>
                                <th>상품명</th>
                                <th>상품이미지</th>
                                <th>카테고리</th>
                                <th>판매가</th>
                                <th>판매수</th>
                                <th>등록일</th>
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
                    <button class="btn btn-info btn-sm" onclick="dataAdd()" type="button" title="상품등록">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>등록</button>
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

