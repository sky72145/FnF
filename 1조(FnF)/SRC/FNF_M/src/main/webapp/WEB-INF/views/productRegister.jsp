<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    HttpSession Session = request.getSession();
    String u = (String)Session.getAttribute("user_id");//자신
    String r = null;//받은 세션아이디
    for(int i = 1; i < 100000 ; i ++){
    	if(u.equals((String)application.getAttribute("receive_id"+i+""))){//자신과 받은 appScope가 같으면
    		r = (String)application.getAttribute("receive_id"+i+"");//r에 appScope 값을 저장//다른페이지
//     		application.removeAttribute("receive_id"+i+"");//그 어플값은 지운다. //받은 메시지페이지
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
		.sidebar-nav li a:hover {
		    color: white;
		    background: #9DC518;
		  }
</style>
    <script src="js/jquery.min.js"></script> 
    <script>
    $(function(){
    	//New Message
    	var re = "<%=r%>";
    	if(re == "${sessionScope.user_id}"){
    		var str = "&nbsp;&nbsp;<img src='img/new-icon.png' width='25px' height='15px'>";
    		$("#newMSG").html(str);
    	}
    	
		//목록으로 
    	$("#btnList").bind("click",function(){
			 location.href="/sellerPL"; // fnf/sellerPL
		 });
		 
		//img 파일이 아닐 때
		 $("#filename").change(function(){
			 if($("#filename").val().split(".")[1] != "jpg" && $("#filename").val().split(".")[1] != "png" &&  $("#filename").val().split(".")[1] != "PNG" &&  $("#filename").val().split(".")[1] != "JPG"){
				 alert("이미지 파일을 올려주세요.");
				 $("#filename").val("");
			 } 
		 });
		 
		 //상품종류 선택할 때
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
		 
		 //글자를 바이트길이로 .val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length
		 
		 //btnSend 눌렀을 때
		 $("#btnSend").click(function(){
			 var category = $("#category").val();
			 var category2 = $("#category2").val();
			 if(category == "선택" || category2== "선택" ){
				 alert("상품종류를 선택해 주세요.");
				 return false;
			 }else if(20 < $("#pcode").val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length){
				 $("#pcode").focus();
				alert("상품코드의 글자 수를 줄여주세요.");
				return false;
			 }else if(30 < $("#pname").val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length){
				 $("#pname").focus();
				 alert("상품명의 글자 수를 줄여주세요.");
				 return false;
			 }else if(50 < $("#origin").val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length){
				 $("#origin").focus();
				 alert("원산지의 글자 수를 줄여주세요.");
				 return false;
			 }else if(10 < $("#unit").val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length){
				 $("#unit").focus();
				 alert("단위의 글자 수를 줄여주세요.");
				 return false;
			 }else if(2000 < $("#pcontents").val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length){
				 $("#pcontents").focus();
				 alert("내용의 글자 수를 줄여주세요.");
				 return false;
			 }else{
				 $('#frm').attr("onsubmit","true");
			 }
		 });
		 
	    //상품코드중복검사
	    $("#pcode").change(function() {
	        var pcode =  $("#pcode").val();
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : pcode,
	            url : "/pcodecheck",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	console.log(data);
	                if (data.cnt > 0) {
	                    alert("상품코드가 존재합니다. 다른 상품코드를 입력해주세요.");
	                    $("#btnSend").prop('disabled', true);
	                }else if(data.cnt == -1){
	                	alert("상품코드를 입력해주세요.");
	                	$("#btnSend").prop('disabled', true);
	                }else {
	                    alert("사용가능한 상품코드입니다.");
	                    $("#btnSend").prop('disabled', false);
	                }
	            },
	            error : function(error) {
	                console.log("error : " + error);
	            }
	        });
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

		<!-- 본문 -->

		<h1 style="padding-top: 20px;">상품관리</h1>
										<br>
			<h3>상품등록</h3>
			<hr>
			<form id="frm" action="/sellerPR" method="post" enctype="multipart/form-data" onsubmit="return false;">
<!-- 			<form action="sellerPR" method="post" > -->
				<ul style="list-style-type: none; margin: 10px 0px">
				<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품종류</span>
					  <select class="form-control" name="category" id="category" required>
					  	  <option>선택</option>
						  <option value="농산물">농산물</option>
						  <option value="수산물">수산물</option>
						  <option value="가공식품">가공식품</option>
						</select>
						<select class="form-control" name="category2" id="category2" required>
						<option>선택</option>
						</select>
					</div>
					<br>
					
<!-- 					<input type="hidden" name="sellerid"  id="sellerid" value="김민호"/> -->
					<input type="hidden" name="sellerid"  id="sellerid" value="${sessionScope.user_id}"/>
					<!-- ${sessionScope.sellerid} -->
					
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품코드</span>
					  <input type="text" class="form-control"  name="pcode"  id="pcode" aria-describedby="sizing-addon2" placeholder="상품코드" required>
			<!-- 	 <button class="btn btn-block btn-info" type="button" id="pcodeCheck">코드중복확인</button> -->
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">상품명</span>
					  <input type="text" class="form-control"  name="pname" id="pname" aria-describedby="sizing-addon2" placeholder="상품명" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">원산지</span>
					  <input type="text" class="form-control"  name="origin" id="origin"  aria-describedby="sizing-addon2" placeholder="원산지" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">단위</span>
					  <input type="text" class="form-control"  name="unit" id="unit"  aria-describedby="sizing-addon2" placeholder="단위" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">재고</span>
					  <input type="number" class="form-control"  name="stock"  id="stock" aria-describedby="sizing-addon2" placeholder="재고" min="1" max="99999" required>
					</div>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon2">판매가</span>
					  <input type="number" class="form-control"  name="price" id="price"  aria-describedby="sizing-addon2" placeholder="판매가" min="1" max="9999999" required>
					</div>
					<br>
					
					<textarea class="form-control" name="pcontents" id="pcontents" rows="5" placeholder="내용" required></textarea>
					
					<div class="form-group">
						    <label for="exampleFormControlFile1">상품 이미지1</label>
						    <input type="file" class="form-control-file" name="filename" id="filename" accept="image/*" required>
					</div>
					
				</ul>
				<hr>
				<div style="text-align: center;">
<!-- 					<button type="button" id="btnSend" class="btn btn-primary">등록하기</button> -->
<!-- 					&nbsp;&nbsp; -->
<!-- 					<button type="reset" class="btn btn-danger">취소하기</button> -->
					<input type="submit" id="btnSend" disabled="disabled"  class="btn btn-success" value="등록하기"/>
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