<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
     HttpSession Session = request.getSession();
	/* String user_id = "test";//String sellerid = request.getParameter("id");// id=넘어오는 name값
   Session.setAttribute("user_id", user_id); //test를 user_id세션에 저장
   //${sessionScope.user_id} */

   String inquiry_user_id = (String)Session.getAttribute("user_id");//user_id 세션의 값 ="writer"  
   String user_id = request.getParameter("user_id");
  %>
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
<link href="css/sellerModal.css" rel="stylesheet">
<style>
.nav .navbar-nav{
		z-index: 0;
	}
	
	#exampleModal{
		  z-index:9999999;
	}
	#layerpop{
		  z-index:9999999;
	}
</style>
<script src="js/jquery.min.js"></script> 
<script>
//alert("${product.sellerid}");

//가격 세자리마다 , 찍기
function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}

 function f_order(){
	var stock = parseInt("${product.stock}");
	var frm = document.getElementById('frm');
		if("${user_id}" == ""){
			alert("로그인 후 이용 가능합니다.");
			location.href = "/login";
			return false;
			}
		if($("#product_count").val() > stock){
			alert("현재 재고수량보다 많습니다. \n재고량: ${product.stock}"); 
			
		}
		else{
			frm.action = '/cart_order';
			frm.submit();
		}	
}
 function f_cart(){
	 var stock = parseInt("${product.stock}");
		var frm = document.getElementById('frm');
		
			if("${user_id}" == ""){
				alert("로그인 후 이용 가능합니다.");
				location.href = "/login";
				return false;
				}
			if($("#product_count").val() > stock){
				 alert("현재 재고수량보다 많습니다. \n재고량: ${product.stock}");
				
			}
			else{
				document.frm.target="ifrm";
				frm.action = '/update';
				frm.submit();
				$("#layerpop").modal();
			}	
	}

//메시지 보내기 버튼 누르면
 function MSGSend(){
	if($("#MSGreceive_id").val() == $("#MSGsend_id").val()){
		alert("자신에게 보낼 수 없습니다.");
		$(".modal").modal("hide");
	}
	else if($("#MSGreceive_id").val() =="") alert("받는 사람을 적어주세요.");
 	else if($("#MSGTitle").val() =="") alert("제목을 적어주세요.");
 	else if($("#MSGContents").val() =="") alert("내용을 적어주세요.");
 	else{//다 체워 졌을 때
 		$.ajax({
 			 url : "/sendMSG",  //--> controller   /sendMSG
 			 dataType : "json",  //받는 type
 			 method : "POST",  //controller  RequestMethod.POST
 			 contentType : "application/json; charset=UTF-8",	//보내는 Type
 			 data : JSON.stringify({
 				 "send_id" :  $("#MSGsend_id").val(),
 				 "receive_id" : $("#MSGreceive_id").val(),
 				 "title" : $("#MSGTitle").val(),
 				 "contents" : $("#MSGContents").val()
 			 }),
 			 success : function(data){
 				 if(data.code){
 					alert("메시지를 보냈습니다.");
 					$(".modal").modal("hide");
 				 }
 			 },
 			 error : function(err){
 				 alert("메시지 전송을 실패했습니다.");
 				 console.log("err 발생 : " + err);
 			 }
 		 });
 	}
 }
$(document).ready(function() {
	var realPrice = $("#hiddenPrice").val();
	$("#pprice").text(addComma(parseInt(realPrice)));

	
	   if($("#stockCheck1").val()=="true"){//상품 있다
		      $("#p_order").prop("disabled",false);
		      $("#p_cart").prop("disabled",false);
		   }else if ($("#stockCheck2").val()=="false"){//상품 없다
		      $("#p_order").prop("disabled",true);
		      $("#p_cart").prop("disabled",true);
		   }
	//메시지 등록버튼 누르면
	 $("#dataAdd").on("click",function(){
		 if("${sessionScope.user_id}" == ""){
			 alert("로그인 후 이용해주세요.");
			 return;
		 }else if("${sessionScope.user_id}" == "${product.sellerid}"){
			 alert("자신에게는 보낼 수 없습니다.");
			 return;
		 }else{
			 $("#MSGsend_id").val("${sessionScope.user_id}");
			 $("#MSGreceive_id").val("${product.sellerid}");
			 $("#MSGTitle").val("");
			 $("#MSGContents").val("");
		 	$("#exampleModal").modal("show");
		 }
	 });
	
	inquiryView();// 문의 뿌리기
	
	$("#InquiryWrite").click(function(){ //문의 확인 버튼 클릭시
		var $in_contents = $('#in_contents');
		if( '' == $in_contents.val() ){
			alert('내용을 입력해주십시오.');
			return;
		}
		if( 400 < $in_contents.val().length ){
			alert('400자 이하로 작성해주십시오.');
			return;
		}
		
		//문의 달기${inquiry_user_id}
		if("${sessionScope.user_id}" == ""){
	         alert("로그인 후 이용해주세요.");
	      }//${product.sellerid}
	     //문의 달기
	      else if('' != $in_contents.val() && 400 > $in_contents.val().length){
			$.ajax({
				url : "/inquiry",
				method : "POST",
				dataType :"json" ,
				contentType : "application/json; charset=utf-8",  //json방식 POST 하려면 필요.
				data : JSON.stringify({
					"pcode" :  "${product.pcode}",
					"in_contents" :  $("#in_contents").val()
				}),
				success : function(data){
					inquiryView();
					$("#in_contents").val("");//댓글이 성공적으로 insert되면 내용 초기화
				},
				error : function(err){
					console.log("err : "+err);
				}
			})
		}
	});
	
	var contents = "${product.pcontents}";
	contents = contents.replace(/\'\'/gi, "'"); 
	contents = contents.replace(/\&lt\;/gi, "<");
	contents = contents.replace(/\&gt\;/gi, ">");
	contents = contents.replace(/\<br\>/gi, "\r\n");
	$("#pcontents").html(contents);
});//function()
	
function inquiryView(){ //댓글 모두 보기
								// url , data , function()
		$.getJSON("/inquiry/all/"+"${product.pcode}",function(data){
		//console.log(data);
		var data = data.data;
		var cnt = data.length;
		$("#inquiry_cnt").text(cnt);
			str = "";
			$(data).each(function(){
				var writedate = this.in_writedate.substr(0, 16);//년월일시분
				str +="<li id='"+this.idx+"' class='inquiryLi'>"+
					"<div class='media'>" +
					"	<div class='media-body'>" +
					"		<strong id='inquiry_user_id' style='margin-right:10px;'>"+this.user_id+"</strong>|" +
					"		<span style='margin:0 10px 0 10px'>"+writedate+"</span>|" +
					"		<button type='button' class='btn btn-danger btn-xs btnInquiryDelete'>삭제</button>" +
					"		<p style='margin-top:10px;word-break:break-all;'>"+this.in_contents+"</p>" +
					"	</div>" +
					"</div>";
				str +="</li>";
			});
		$("#inquiryList").html(str);
		});//getJSON
		
	//문의 삭제
	$("#inquiryList").on("click",".inquiryLi .media .media-body button", function(){
		//alert($(this).prev().prev().text()); //문의 작성자text추출
		if($(this).prev().prev().text() == "<%=inquiry_user_id%>" || "${sessionScope.user_id}" == "${product.sellerid}"){
			var idx = $(this).parent().parent().parent().attr("id");//a  부모 = div , 부모 = div , 부모 = li 의 속성id값
			//console.log(id);
			$.ajax({
				url : " /inquiry/"+parseInt(idx),
				dataType: "json", 	//오는 data
				method : "DELETE",
				success : function(data){
					inquiryView();
				}
			});
		}else{
			alert("삭제할 수 없는 글입니다.");
			return;
 		}
	});
	
}//inquiryView

</script>
</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->





<!-- ------------------------------------------------------------------------------- -->
<!-- catg header banner section -->
	
		<section id="aa-catg-head-banner">
			<img src="img/de8eb79d9eee487bb5117bbd9c98c898.jpg" alt="상품상세 배경이미지">
			<div class="aa-catg-head-banner-area">
				<div class="container">
					<div class="aa-catg-head-banner-content">
						<h2>상품상세</h2>
						<ol class="breadcrumb" style="background-color:transparent;">
							<li><a href="/">Home</a></li>
		                     <li><a href="/products?category=${product.category}">${product.category}</a></li>
		                     <li><a href="/products2?category2=${product.category2}">${product.category2}</a></li>
						</ol>
					</div>
				</div>
			</div>
		</section>
	
	<!-- / catg header banner section -->

<!-- ------------------------------------------------------------------- -->
	<!-- product category -->
	<section id="aa-product-details">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
				
					<form class="form-horizontal" id="frm" name="frm" method="post">
						
						<div class="aa-product-details-area">
							<div class="aa-product-details-content">
								<div class="row">
									<!-- Modal view slider -->
									<div class="col-md-5 col-sm-5 col-xs-12">
										<div class="aa-product-view-slider">
											<div id="demo-1" class="simpleLens-gallery-container">
												<div class="simpleLens-container">
													<div class="simpleLens-big-image-container">
														<a data-lens-image="img/${product.filename}" class="simpleLens-lens-image">
															<img src="img/${product.filename}" class="simpleLens-big-image">
														</a>
													</div>
												</div>
												<div class="simpleLens-thumbnails-container">
													<!-- <a data-big-image="img/1.jpg" data-lens-image="img/1.jpg" class="simpleLens-thumbnail-wrapper" href="#"> 
														<img src="img/1.jpg" alt="고구마">
													</a> -->
												</div>
											</div>
										</div>
									</div>
									
									<!-- Modal view content -->
									<div class="col-md-7 col-sm-7 col-xs-12">
<!-- 										<div class="table-responsive"> -->
											<table class="table table-pr" style="margin-bottom:5px;">
												<colgroup>
													<col width="30%">
													<col width="70%">
												</colgroup>
												<tr>
													<th class="active text-success">상품명</th>
													<td>${product.pname}</td>
												</tr>
													<tr>
														<th class="active text-success">상품코드</th>
														<td>${product.pcode}</td>
														<input type="hidden" value="${product.pcode}" name="pcode"/>
													</tr>
												<tr>
													<th class="active text-success">카테고리</th>
													<td>${product.category} > ${product.category2}</td>
												</tr>
													<tr>
														<th class="active text-success">원산지</th>
														<td>${product.origin}</td>
													</tr>
													<tr>
														<th class="active text-success">단위</th>
														<td>${product.unit}</td>
													</tr>
					                                <tr>
														<th class="active text-success">판매가</th>
														<td><span id="pprice"></span>원</td>
														<input type="hidden" id="hiddenPrice"value="${product.price}">
													</tr>
											<c:if test="${product.stock > 0}">
												<!-- 재고가 있을 때 -->
												<tr>
													<th class="active text-success">수량</th>
													<td class="form-inline has-success"><input
														class="form-control" name="product_count"
														id="product_count" type="number" value="1" min="1"
														max="${product.stock}" /> <input type="hidden"
														id="stockCheck1" value="true"></td>
												</tr>
											</c:if>
											<c:if test="${product.stock <= 0}">
												<!-- 재고가 다 떨어졌을 때 -->
												<tr>
													<th class="active text-success">수량</th>
													<td class="form-inline has-success"><input
														class="form-control" name="product_count"
														readonly="readonly" id="product_count" type="number"
														value="0" min="0" max="${product.stock}" /> <strong
														class='text-danger'>&nbsp;&nbsp;해당 상품은 재고가 없습니다.</strong>
														<input type="hidden" id="stockCheck2" value="false">
													</td>
												</tr>
											</c:if>
										</table>
<!-- 	</div> -->
										
										<div class="row">
											<div class="col-sm-12 col-xs-12">
											<iframe name="ifrm" width="0" height="0" frameborder="0"></iframe> 
			                                	<input type="button" class="btn btn-default" style="padding:10px 20px" id="p_order" onclick="f_order()" value="바로구매">
			                                	<input type="button" class="btn btn-default" style="padding:10px 20px" id="p_cart" onclick="f_cart()" value="장바구니">
												<a class="aa-add-to-cart-btn" href="javascript:void(0)" id="dataAdd" title="판매자에게">메시지보내기</a>
			                                </div>
			                                <div class="col-sm-12 col-xs-12">
			                                </div>
										</div>
									</div>
								</div>
							</div>
							<div class="aa-product-details-bottom">
								<ul class="nav nav-tabs" >
									<li><a href="#description" data-toggle="tab">상품정보</a></li>
									<li><a href="#review" data-toggle="tab">상품문의</a></li>
								</ul>
	
								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="description" style="word-break:break-all;overflow: auto">
										<pre id="pcontents"></pre>
									</div>
									<div class="tab-pane fade" id="review">
										<div class="aa-product-review-area">
											<h5><span id="inquiry_cnt"></span>개의 문의가 있습니다.</h5>
											
											<!-- review form -->
											<ul  id="inquiryList" class="aa-review-nav"></ul>
											<!-- review form -->
											
											<div class="aa-review-form">
												<div class="">
													<label for="in_contents">상품문의 등록</label>
													<textarea class="form-control" rows="4" id="in_contents" name="in_contents" placeholder="400자까지 등록가능합니다."></textarea>
												</div>
												<button type="button" class="btn btn-default aa-review-submit" id = "InquiryWrite"  style="margin-top:5px">확인</button>
											</div>
											
										</div>
									</div>									
								</div>
							</div>
							
							
												
							<!-- Related product -->
			
														
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- / product category -->

  



<!-- ------------------------------------------------------- -->
<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
 
  <!-- ------------------------------------------------------- -->
    <!-- 메시지창 -->
  
  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="exampleModalLabel">메시지 쓰기</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
        <div class="form-group">
            <label for="send-name" class="col-form-label" id="sendLabel">보내는 사람</label>
            <input type="text" class="form-control" id="MSGsend_id" readonly="readonly">
          </div>
          	<div class="form-group">
            <label for="recipient-name" class="col-form-label" id="receiveLabel">받는 사람</label>
            <input type="text" class="form-control" id="MSGreceive_id" readonly="readonly">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">제목</label>
            <input type="text" class="form-control" id="MSGTitle" placeholder="Title">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" rows="5" id="MSGContents"  placeholder="Contents"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btnSendReMSG" onclick="MSGSend()">보내기</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

  <!-- ===== -->
  <div class="modal fade" id="layerpop" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header2">
        <!-- 닫기(x) 버튼 -->
         <button type="button" class="close" data-dismiss="modal">×</button>
        <!-- header title -->
      <h5>장바구니에 담기</h5>
      </div>
      <!-- body -->
      <div class="modal-body text-center">
      <img src="/static/img/123.gif"  height="150" width="150"><br />
             ${product.pname} <br/> 상품이 장바구니에 담겼습니다.<br/>
           <strong> 지금 확인하시겠습니까? </strong>
           
      </div>
      <!-- Footer -->
      <div class="modal-footer2 text-right">
        <button type="button" class="btn btn-default" onclick="location.href='/cart'">예</button>
           <button type="button" class="btn btn-default" data-dismiss="modal">계속쇼핑하기</button>
        
      </div>
    </div>
  </div>
</div>

 
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