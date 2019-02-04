<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script>
    $(function(){
		//목록으로 
    	$("#btnList").bind("click",function(){
			 location.href="list"; // fnf/list
		 });
		 
		 //등록하기
		 $("#btnSend").bind("click",function(){
			 $.ajax({
				 url : "sellerPI/pi", 	 //http://localhost:8080/fnf/seller/pi
				 dataType : "json",  //받는 type
				 method : "POST",
				 contentType : "application/json; charset=UTF-8",	//보내는 Type
				 enctype : "multipart/form-data", //파일 업로드 필수
				 data : JSON.stringify({
					 "sellerid" :  $("#sellerid").val(),
					 "category" : $("#category").val(),
					 "category2" : $("#category2").val(),
					 "pcode" : $("#pcode").val(),
					 "pname" : $("#pname").val(),
					 "origin" : $("#origin").val(),
					 "unit" :  $("#unit").val(),
					 "stock" : $("#stock").val(),
					 "price" : $("#price").val(),
					 "pcontents" : $("#pcontents").val(),
					 "filename" : $("#filename").val()
				 }),
				 success : function(data){
					 alert(data.code);
					 //location.href="list"; // fnf/list
				 },
				 error : function(err){
					 console.log("err 발생 : " + err);
				 }
			 });
			 //$("#fileForm").submit();
		 })
		 
		 //상품종류
		    $("#category").change(function(){
		    	//alert($("#category").val());
		    	if(($("#category").val()) == "농산물"){
			    	var str ="<option>--선택--</option>";
			    	str += "<option value='채소'>채소</option>" +
			    				"<option value='과일'>과일</option>" +
			    				"<option value='쌀잡곡류'>쌀잡곡류</option>" +
			    				"<option value='견과류'>견과류</option>";
			    	$("#category2").html(str);
		    	}else if(($("#category").val()) == "수산물"){
		    		var str="<option>--선택--</option>";
		    		str += "<option value='생선'>생선</option>" +
    							"<option value='갑각류'>갑각류</option>" +
    							"<option value='해조류'>해조류</option>" +
    							"<option value='건어물'>건어물</option>";
		    		$("#category2").html(str);
		    	}else if(($("#category").val()) == "가공식품"){
		    		var str="<option>--선택--</option>";
		    		str += "<option value='즙류'>즙류</option>" +
    							"<option value='분말류'>분말류</option>" +
    							"<option value='잼류'>잼류</option>";
		    		$("#category2").html(str);
		    	}
		    });
		 
	 });//function()
    
    //상품코드중복검사
    function pcodeCheckFunction(){
    	var pcode = $('#pcode').val();
    	$.ajax({
    		type:'POST',
    		url: 'productInsert_pcodeCheck.jsp',
    		data : {pcode:pcode},  //반대편에선 ${param.pcode}
    		success: function(result){
    			console.log(result);
    			if(result == 1){
    				$('#checkMessage').html('사용할 수 없는 상품코드입니다.');
    				$('#checkType').attr('class','modal-content panel-success');
    			}else{
    				$('#checkMessage').html('사용 가능한 상품코드입니다.');
    				$('#checkType').attr('class','modal-content panel-warning');
    			}
    			$('#checkModal').modal("show");
    		}
    	});
    }
    
   
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
				<li><a href="#">[상품관리]</a></li>
				<li><a href="productList.jsp">상품리스트[수정:삭제]</a></li>
				<li><a href="productInsert.jsp">상품등록</a></li>
				<li><a href="#"><hr></a></li>
				<li><a href="#">[주문관리]</a></li>
				<li><a href="orderList.html">전체주문관리</a></li>
				<li><a href="#"><hr></a></li>
				<li><a href="#">[취소|교환|반품|환불]</a></li>
				<li><a href="orderCancel.html">취소내역</a></li>
				<li><a href="orderSwap.html">교환내역</a></li>
				<li><a href="orderReturn.html">반품내역</a></li>
				<li><a href="orderRefund.html">환불내역</a></li>
			</ul>
		</div>

		<!-- 본문 -->

		<h1>상품 관리</h1>
			<h3>상품등록</h3>
			<hr>
			<!-- action="/FNF/productInsert_ok.jsp" method="post" enctype="multipart/form-data" -->
			<form id="fileForm" enctype="multipart/form-data">
				<ul style="list-style-type: none; margin: 10px 0px">
				<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품종류</span>
					  <select class="form-control" name="category" id="category">
					  	  <option>--선택--</option>
						  <option value="농산물">농산물</option>
						  <option value="수산물">수산물</option>
						  <option value="가공식품">가공식품</option>
						</select>
						<select class="form-control" name="category2" id="category2">
						<option>--선택--</option>
						</select>
					</div>
					<br>
					
					<input type="hidden" name="sellerid"  id="sellerid" value="${sessionScope.sellerid}"/>
					<!-- ${sessionScope.sellerid} -->
					
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품코드</span>
					  <input type="text" class="form-control"  name="pcode"  id="pcode" aria-describedby="sizing-addon2" placeholder="상품코드">
					  <button class="btn btn-block btn-info" type="button" onclick="pcodeCheckFunction()">코드중복확인</button>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품명</span>
					  <input type="text" class="form-control"  name="pname" id="pname" aria-describedby="sizing-addon2" placeholder="상품명">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">원산지</span>
					  <input type="text" class="form-control"  name="origin" id="origin"  aria-describedby="sizing-addon2" placeholder="원산지">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">단위</span>
					  <input type="text" class="form-control"  name="unit" id="unit"  aria-describedby="sizing-addon2" placeholder="단위">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">재고</span>
					  <input type="number" class="form-control"  name="stock"  id="stock" aria-describedby="sizing-addon2" placeholder="재고">
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">판매가</span>
					  <input type="number" class="form-control"  name="price" id="price"  aria-describedby="sizing-addon2" placeholder="판매가">
					</div>
					<br>
					
					<textarea class="form-control" name="pcontents" id="pcontents" rows="5" placeholder="내용"></textarea>
					
					<div class="form-group">
						    <label for="exampleFormControlFile1">상품 이미지1</label>
						    <input type="file" class="form-control-file" name="filename" id="filename" >
					</div>
					
				</ul>
				<hr>
				<div style="text-align: center;">
					<button type="button" id="btnSend" class="btn btn-primary">등록하기</button>
					&nbsp;&nbsp;
					<button type="reset" class="btn btn-danger">취소하기</button>
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