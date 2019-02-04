<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Controller에서 받은 data값 -->
<c:set var="order" value="${data}" /> 
<%
HttpSession Session = request.getSession();
String u = (String)Session.getAttribute("user_id");//자신
String r = null;//applicationSession
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
<script src="js/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
.sidebar-nav li a:hover {
    color: white;
    background: #9DC518;
  }
</style>
 
<script>
$(function(){
	//New Message
	var re = "<%=r%>";
	if(re == "${sessionScope.user_id}"){
		var str = "&nbsp;&nbsp;<img src='img/new-icon.png' width='25px' height='15px'>";
		$("#newMSG").html(str);
	}
	//alert("${order[0].email}");
// 	console.log("${order.size()}");
// 	console.log("${order}");
	
	//foreach에 있는 값들 for 돌려서 뿌리기
	for(var i = 0 ; i < ${order.size()} ; i++){
	 	var pc = parseInt($("#p_count"+i+"").text());
	 	var SumPrice = addComma(parseInt($("#p_price"+i+"").text())*pc);
	 	$("#SumPrice"+i+"").text(SumPrice+"원");
		var p_price = addComma(parseInt($("#p_price"+i+"").text()));//text-->int-->comma
	 	$("#p_price"+i+"").text(p_price+"원");
	}
	
	//가격 뿌리기
 	$("#del_price").text(addComma(${order[0].del_price}));
 	$("#mile_used").text(addComma(${order[0].mile_used}));
 	$("#mile_give").text(addComma(${order[0].mile_give}));
 	$("#totalprice").text(addComma(${order[0].totalprice}));
 	
 	//배송업체명
 	var del_name = "${order[0].del_name}";
 	if(del_name == ""){
	 	$('select[name="del_name"]').val(""); 		
 	}else{
 		$('select[name="del_name"]').val(del_name);
 	}
 	
 	//리스트버튼
 	$("#dataList").on("click",function(){
 		history.back();
 	});
 	
 	//업데이트 버튼
	$("#dataUp").on("click",function(){
		//alert($("#o_idx").val());
		var idx = $("#o_idx").val();
		if($("#OrderStatus").text() == "입금대기"){
			alert("[주문상태 : 입금대기]는 수정할 수 없습니다.");
		}
		else if($("#receiver_name").val()=="" || $("#receiver_name").val()==" "){
			alert("받으시는 분을 입력해주세요.");
			$("#receiver_name").focus();
		}else if($("#phone").val()=="" || $("#phone").val()==" "){
			alert("휴대전화를 입력해주세요.");
			$("#phone").focus();
		}else if($("#address2").val()=="" || $("#address2").val()==" "){
			alert("상세주소를 입력해주세요.");
			$("#address2").focus();
		}else if($("#del_name").val()=="" || $("#del_name").val()==" "){
			alert("배송업체를 선택해주세요.");
		}else if($("#del_code").val()=="" || $("#del_code").val()==" "){
			alert("송장번호를 입력해주세요.");
			$("#del_code").focus();
		}else if(11 < $("#phone").val().length){
			alert("휴대전화 자릿수를 맞춰주세요.");
			$("#phone").focus();
		}else if(confirm('수정 처리를 진행하시겠습니까?')){
			$.ajax({
				url : "/sellerOU/"+idx,
				dataType : "json",  // Controller - RequestBody 가 받는 type
				method : "PUT",
				contentType : "application/json; charset=UTF-8",	//보내는 Type
				data : JSON.stringify({
					 "receiver_name" : $("#receiver_name").val(),
					 "phone" : $("#phone").val(),
					 "zipcode" : $("#zipcode").val(),
					 "address1" : $("#address1").val(),
					 "address2" : $("#address2").val(),
					 "del_name" : $("#del_name").val(),
					 "del_code" : $("#del_code").val(),
					 "del_message" : $("#del_message").val()
				 }),
				success : function(data){
					alert("${order[0].receiver_name}님의 주문이 수정되었습니다.");
					location.href="/sellerOL";
				},
				error : function(err){
					console.log("err 발생 : " + err);
				}
			});
		}else{
			return;
		}//else
	});
	
 	//배송메시지 출력
	var contents = "${order[0].del_message}";
	contents = contents.replace(/\'\'/gi, "'"); 
	contents = contents.replace(/\&lt\;/gi, "<");
	contents = contents.replace(/\&gt\;/gi, ">");
	contents = contents.replace(/\<br\>/gi, "\r\n");
	$("#del_message").val(contents);
	
	//송장번호중복체크
	$("#del_code").change(function(){
		var del_code = $("#del_code").val();
		 $.ajax({
	            async: true,
	            type : 'POST',
	            data : del_code,
	            url : "/del_code_check",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	//console.log(data);
	                if (data.cnt > 0) {
	                    alert("송장번호가 존재합니다. 다른 송장번호를 입력해주세요.");
	                    $("#dataUp").prop('disabled', true);
	                }else if(data.cnt == -1){
	                	alert("송장번호를 입력해주세요.");
	                	$("#dataUp").prop('disabled', true);
	                }else {
	                    alert("사용가능한 송장번호입니다.");
	                    $("#dataUp").prop('disabled', false);
	                }
	            },
	            error : function(error) {
	                console.log("error : " + error);
	            }
	        });
	});

	//배송찾기에 마우스 올리면
	$("#del_url_link").mouseover(function(){
		var del_name =$("#del_name").val(); 
		if(del_name == ""){
			return;
		}else{
			$.ajax({
	            async: true,
	            type : 'POST',
	            data : del_name,
	            url : "/del_name",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	var URL = data.data[0].del_url+""+$("#del_code").val();
	            	$("#del_url_link").attr("href", URL);
	            	//alert(data.data[0].del_url);
	            },
	            error : function(error) {
	                console.log("error : " + error);
	            }
	        });
		}
	});
	
});//function()
//가격 세자리마다 , 찍기
function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}

//zipcode
function getZipcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                //document.getElementById("sample6_extraAddress").value = extraAddr;
                addr+=" "+extraAddr;
            
            } else {
                //document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("address1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("address2").focus();
            
        }
    }).open();
}
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
										<h1 style="padding-top: 20px;">주문 관리</h1>
										<h3>주문보기</h3>
										<hr>
                <div class="clearfix"></div>
            </div>
            <div class="x_content">
		
                <form >
                <input type="hidden" id="o_idx" value="${order[0].idx}"/>
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <h4><b>주문상품정보</b></h4>
                            <div class="table-responsive">
                                <table class="table table-bordered" >
                                    <thead>
                                        <tr style="background-color: #f1f1f1" >
                                            <th style="text-align: center;">상품이미지</th>
                                            <th style="text-align: center;">상품명</th>
                                            <th style="text-align: center;">상품코드</th>
                                            <th style="text-align: center;">판매가</th>
                                            <th style="text-align: center;">주문수량</th>
                                            <th style="text-align: center;">판매가합</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="row" items="${order}" varStatus="status">
                                            <tr>
                                                <td style="text-align: center;vertical-align: middle;">
                                                    <img src="img/${row.filename}"  width="55px" height="65px">
                                                </td>
                                                <td style="text-align: center;vertical-align: middle;">
                                                    ${row.pname}
                                                </td>
                                                <td style="text-align: center;vertical-align: middle;">${row.pcode}</td>
                                                <td style="text-align: center;vertical-align: middle;">
                                                    <p id="p_price${status.index}">${row.price}</p>
                                                </td>
                                                <td style="text-align: center;vertical-align: middle;">
                                                    <p id="p_count${status.index}">${row.product_count}</p>
                                                </td>
                                                <td style="text-align: center;vertical-align: middle;">
                                                    <p id="SumPrice${status.index}"></p>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <h4><b>결제정보</b></h4>
                            <div class="table-responsive">
                                <table class="table table-bordered" >
                                    <colgroup>
                                        <col style="background-color: #f1f1f1;text-align: center" width="20%">
                                        <col width="80%">
                                    </colgroup>
                                    <tr>
                                        <th style="text-align: center;">주문번호</th>
                                        <td>${order[0].idx}</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">결제타입</th>
                                        <td>${order[0].pay}</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">배송비</th>
                                        <td><span id="del_price"></span>원</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">사용 적립금</th>
                                        <td><span id="mile_used"></span>원</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">지급(예정) 적립금</th>
                                        <td><span id="mile_give"></span>원</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">결제금액</th>
                                        <td><span id="totalprice"></span>원</td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;">주문상태</th>
                                        <td id="OrderStatus">${order[0].status}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
<!-- 										<div class="row form-inline"> -->
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <h4><b>배송정보</b></h4>
                            <div class="table-responsive">
                                <table class="table table-bordered" >
                                    <colgroup>
                                        <col style="background-color: #f1f1f1;" width="20%">
                                        <col width="80%">
                                    </colgroup>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">받으시는 분</th>
                                        <td>
                                            <input class="form-control" id="receiver_name" name="receiver_name" type="text" value="${order[0].receiver_name}" />															
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">휴대전화</th>
                                        <td>
                                            <input class="form-control" id="phone" placeholder="ex) 01012345678" name="phone" type="text" value="${order[0].phone}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">배송지</th>
                                        <td>
                                            <input type="button" class="form-control btn btn-info" onclick="getZipcode();" value="우편번호 검색"><br/>
                                            <input type="text" class="form-control" placeholder="우편번호" name="zipcode" id="zipcode" value="${order[0].zipcode}" readonly="readonly" >
                                            <input type="text" class="form-control" placeholder="기본주소" name="address1" id="address1" value="${order[0].address1}" readonly="readonly" style="margin-top: 5px;">
                                            <input type="text" class="form-control" placeholder="상세주소" name="address2" id="address2"value="${order[0].address2}" style="margin-top: 5px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">배송업체</th>
                                        <td>
                                            <select class="form-control" id="del_name" name="del_name" >
                                                <option value="">선택</option>
                                                    <option value="우체국">우체국</option>
                                                    <option value="CJ대한통운">CJ대한통운</option>
                                                    <option value="한진택배">한진택배</option>
                                                    <option value="로젠택배">로젠택배</option>
                                                    <option value="KGB택배">KGB택배</option>
                                                    <option value="KG옐로우캡택배">KG옐로우캡택배</option>
                                                    <option value="우체국EMS">우체국EMS</option>
                                                    <option value="디에이치엘">디에이치엘</option>
                                                    <option value="페덱스">페덱스</option>
                                                    <option value="유피에스">유피에스</option>
                                                    <option value="하나로택배">하나로택배</option>
                                                    <option value="대신택배">대신택배</option>
                                                    <option value="일양로지스택배">일양로지스택배</option>
                                                    <option value="포스트박스">포스트박스</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">송장번호</th>
                                        <td class="form-inline">
                                            <input class="form-control" id="del_code" name="del_code" type="text" value="${order[0].del_code}" />
                                                <a id="del_url_link" target="_blank">배송추적</a>
                                                <!-- href="http://service.epost.go.kr/trace.RetrieveRegiPrclDeliv.postal?sid1=${order[0].del_code}"  -->
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <h4><b>주문메모</b></h4>
                            <div class="table-responsive">
                                <table class="table table-bordered" >
                                    <colgroup>
                                        <col style="background-color: #f1f1f1;" width="20%">
                                        <col width="80%">
                                    </colgroup>
                                    <tr>
                                        <th style="text-align: center;vertical-align: middle;">주문메모</th>
                                        <td>
                                            <textarea class="form-control" id="del_message" name="del_message" rows="5" style="width: 100%;"></textarea>															
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-7 col-sm-12 text-right">
                            <button type="button" class="btn btn-success" id="dataUp" >
                            <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>저장</button>&nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary" id="dataList">
                            <span class="glyphicon glyphicon-list" aria-hidden="true"></span>리스트</button>
                            <br><br>
                        </div>
                        <div class="col-md-5 col-sm-12 text-right">
                        </div>
                    </div>
                </form>
						</div>
                <c:if test="${order[0].del_name != null}">
                						<br>
                						<hr>
                    <form action="/DeliveryService" method="post">
                    <!-- 받는 사람 이메일 -->																					<!--주문페이지에서 넣었던 Email ${order[0].email} -->
                      <input type="hidden" name="tomail"  class="form-control" value="${order[0].email}">
                    <!-- 제목 -->
                      <input type="hidden" name="title"  class="form-control" value="FnF쇼핑몰에서 주문하신 상품이 배송 중입니다." >
                      <!-- 내용 -->
                      <textarea name="content" style="display:none;">
                      	--------------------------------------------------------------------------------------------------
                      	※상품 정보※
                      	<c:forEach var="row" items="${order}" varStatus="status">
                      	주문 상품${status.index+1} : ${row.pname}
                      	</c:forEach>
                      	--------------------------------------------------------------------------------------------------
                      	※배송 정보※
                      	배송지 : ${order[0].zipcode} ${order[0].address1} ${order[0].address2}
                      	받는분 : ${order[0].receiver_name}
                      	배송업체 : ${order[0].del_name}
                      	송장번호 : ${order[0].del_code}
                      	--------------------------------------------------------------------------------------------------
                      	
                      	저희 FnF쇼핑몰을 이용해 주셔서 감사합니다.
                      	
                      	FnF쇼핑몰 : http://www.fnfm.store
                      </textarea>
	                    <div class="col-md-8 col-sm-12">
	                    <input type="submit" value="배송 메일 보내기" class="btn btn-warning">
	                    </div>
                    </form>
                    <br><br>
                </c:if>
            </div>
        </div>
    </div>
</div>
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

