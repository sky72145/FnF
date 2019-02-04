<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Controller에서 받은 data값 -->
<c:set var="product" value="${data}" /> 
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
    <script src="js/jquery.min.js"></script> 
    <style>
		.sidebar-nav li a:hover {
		    color: white;
		    background: #9DC518;
		  }
</style>
    <script>
    $(function(){
    	//수정하기 버튼 활성화
    	$("#btnUpdate").attr("disabled", false);
    	
		//목록으로 
    	$("#btnList").bind("click",function(){
			 location.href="/sellerPL"; // fnf/sellerPL
		 });
		 
		//img 파일이 아닐 때
		 $("#file1").change(function(){
			 if($("#file1").val().split(".")[1] != "jpg" && $("#file1").val().split(".")[1] != "png" &&  $("#file1").val().split(".")[1] != "PNG" &&  $("#file1").val().split(".")[1] != "JPG"){
				 alert("이미지 파일을 올려주세요.");
				 $("#file1").val("");
			 } 
		 });
		 
		 //상품종류
	    $("#category").change(function(){
	    	//alert($("#category").val());
	    	if(($("#category").val()) == "농산물"){
		    	var str ="<option>선택</option>";
		    	str += "<option value='채소'>채소</option>" +
		    				"<option value='과일'>과일</option>" +
		    				"<option value='쌀,잡곡류'>쌀,잡곡류</option>" +
		    				"<option value='견과류'>견과류</option>";
		    	$("#category2").html(str);
	    	}else if(($("#category").val()) == "수산물"){
	    		var str="<option>선택</option>";
	    		str += "<option value='생선'>생선</option>" +
   							"<option value='갑각류'>갑각류</option>" +
   							"<option value='해조류'>해조류</option>" +
   							"<option value='건어물'>건어물</option>";
	    		$("#category2").html(str);
	    	}else if(($("#category").val()) == "가공식품"){
	    		var str="<option>선택</option>";
	    		str += "<option value='즙류'>즙류</option>" +
   							"<option value='분말류'>분말류</option>" +
   							"<option value='잼류'>잼류</option>";
	    		$("#category2").html(str);
	    	}
	    });
		
// 		//취소 버튼
// 		$("#btnCancle").click(function(){
// 			history.back();
// 		});
    
		//상품종류 추가버튼
		var category = null;
		var category2 = null;
		$("#insertCategory").click(function(){
			category = $("#category").val();
			category2 = $("#category2").val();
			if($("#booked_category").val() != ""){//등록된 상품종류 값이 있을 때
				alert("상품 종류는 하나만 등록 가능합니다.");
			}else if(category == "선택" || category2 == "선택"){
				alert("상품 종류를 선택해주세요.")
			}else{
				$("#booked_category").val(category+">"+category2);	
				$("#btnUpdate").attr("disabled", false);
				alert("상품종류가 추가되었습니다.");
			}
		});
		
		//상품종류 삭제 버튼
		$("#deleteCategory").click(function(){
			$("#booked_category").val("");
			$("#btnUpdate").attr("disabled", true);
		});
	
    });//function()
    
    
   
    </script>
</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->
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

		<!-- 본문 -->

		<h1 style="padding-top: 20px;">상품관리</h1>
										<br>
			<h3>상품등록</h3>
			<hr>
			<form action="/sellerPU/${product.idx }" method="POST" enctype="multipart/form-data">
<!-- 			<form action="sellerPR" method="post" > -->
				<ul style="list-style-type: none; margin: 10px 0px">
				<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품종류</span>
					  <select class="form-control" id="category" required>
					  	  <option>선택</option>
						  <option value="농산물">농산물</option>
						  <option value="수산물">수산물</option>
						  <option value="가공식품">가공식품</option>
						</select>
						<select class="form-control" id="category2" required>
						<option>선택</option>
						</select>
						<button class="btn btn-block btn-primary" id="insertCategory" type="button">상품종류 추가</button>
					</div>
					<br>
					
<!-- 					<input type="hidden" name="sellerid"  id="sellerid" value="김민호"/> -->
					<input type="hidden" name="sellerid"  id="sellerid" value="${sessionScope.user_id}"/>
					<input type="hidden" name="filename"  id="filename" value="${product.filename}"/>
					<!-- ${sessionScope.sellerid} -->
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">등록된 상품종류</span>
					  <input type="text" class="form-control"  name="category" id="booked_category"
					  		value="${product.category}>${product.category2}"aria-describedby="sizing-addon2" readonly="readonly" required>
					  	<button class="btn btn-block btn-danger" id="deleteCategory" type="button">상품종류 삭제</button>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품코드</span>
					  <input type="text" class="form-control"  name="pcode"  id="pcode" 
					  		value="${product.pcode}"aria-describedby="sizing-addon2" readonly="readonly">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품명</span>
					  <input type="text" class="form-control"  name="pname" id="pname" 
					  				value="${product.pname}" aria-describedby="sizing-addon2" placeholder="상품명" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">원산지</span>
					  <input type="text" class="form-control"  name="origin" id="origin" 
					   value="${product.origin}" aria-describedby="sizing-addon2" placeholder="원산지" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">단위</span>
					  <input type="text" class="form-control"  name="unit" id="unit"  
					  		value="${product.unit}" aria-describedby="sizing-addon2" placeholder="단위" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">재고</span>
					  <input type="number" class="form-control"  name="stock"  id="stock" 
					  		value="${product.stock}" aria-describedby="sizing-addon2" placeholder="재고" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">판매가</span>
					  <input type="number" class="form-control"  name="price" id="price"  
					  		value="${product.price}"  aria-describedby="sizing-addon2" placeholder="판매가" required>
					</div>
					<br>
					
					<textarea class="form-control" name="pcontents" id="pcontents" 
						rows="5" placeholder="내용" required>${product.pcontents}</textarea>
					
					<br>
					<div class="form-group">
<!-- 						<div class="form-group has-error"> -->
							<label class="col-sm-2 col-xs-12 control-label" for="file_pr_image1">상품 이미지1</label>
							<div class="col-sm-4 col-xs-12">
								<input class="form-control" id="file1"  name="file1" placeholder="상품이미지1(900x1080)" type="file" accept="image/*" />
							</div>
							<label class="col-sm-2 col-xs-12 control-label">현재 상품이미지</label>
							<div class="col-sm-4 col-xs-12">
								<img	src="img/${product.filename}" width="150px" height="100px"/>
							</div>
<!-- 						</div> -->
					</div>

				</ul>
				<hr>
				<hr>
				<div style="text-align: center;">
<!-- 					<button type="button" id="btnSend" class="btn btn-primary">등록하기</button> -->
<!-- 					&nbsp;&nbsp; -->
<!-- 					<button type="button" id="btnCancle" class="btn btn-danger">취소하기</button> -->
					<input type="submit" id="btnUpdate" disabled class="btn btn-warning" value="수정하기"/>
					&nbsp;&nbsp;
					<button type="button" id="btnList" class="btn btn-info">목록으로</button>
				</div>
				<br>
			</form>

		<!-- /본문 -->
	</div>
	</section>
	
<!-- ------------------------------------------------------- -->
<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
  
  <!-- Modal -->
  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div id="checkType" class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">확인 메시지</h4>
      </div>
      <div class="modal-body" id="checkMessage"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
  <!-- /Modal -->
  
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