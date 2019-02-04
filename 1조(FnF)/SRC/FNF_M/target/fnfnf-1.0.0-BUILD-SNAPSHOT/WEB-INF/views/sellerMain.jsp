<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Controller에서 받은 data값 -->
<!-- 상품별 판매수 정보 -->
<c:set var="chart" value="${data}" />
<!-- 상품별 판매액 정보 -->
<c:set var="pprice" value="${pdata}" />
<!-- 무통장 결제 건 수 -->
<c:set var="mu" value="${mcount}" />
<!-- 카카오페이 결제 건 수 -->
<c:set var="ka" value="${kcount}" />
<!-- 월별 매출액 -->
<c:set var="msale" value="${month}" />

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
    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <script>
    $(function(){
    	//console.log(${mu});
    	//console.log(${ka});
    	//${order[0].mile_give}
//     	console.log("${msale[0].totalprice}");
//     	console.log("${msale[1].totalprice}");
//     	console.log("${msale[2].totalprice}");
    	/**=======================================================**/
    	var dps = [[]];
    	for(var i = 0 ; i < ${chart.size()} ; i++){
    		dps[0].push({
    			label : $("#pname"+i+"").val(),
    			y : parseInt($("#sell_num"+i+"").val())
    		});		
    	}
    	//console.log(dps);
    		var chart = new CanvasJS.Chart("chartContainer", {
    		animationEnabled: true,
    		exportEnabled: true,
    		theme: "light1", // "light1", "light2", "dark1", "dark2"
    		title:{
    			text: "상품별 판매수"
    		},
    		data: [{
    			type: "column", //change type to bar, line, area, pie, etc
    			//indexLabel: "{y}", //Shows y value on all Data Points
    			indexLabelFontColor: "#5A5757",
    			indexLabelFontSize: 16,
    			indexLabelPlacement: "outside",
    			dataPoints: dps[0]
    		}]
    	});
    	chart.render();
    	/**=======================================================**/
    	/**=======================================================**/
    	/**=======================================================**/
    	/**=======================================================**/
    	var Piechart = new CanvasJS.Chart("Piechart", {
    		theme: "light2", // "light1", "light2", "dark1", "dark2"
    		exportEnabled: true,
    		animationEnabled: true,
    		title: {
    			text: "주문결제수단"
    		},
    		data: [{
    			type: "pie",
    			startAngle: 25,
    			toolTipContent: "<b>{label}</b>: {y}건",
    			showInLegend: "true",
    			legendText: "{label}",
    			indexLabelFontSize: 16,
    			indexLabel: "{label} - {y}건",
    			dataPoints: [
    				{ y: ${mu}, label: "무통장입금" },
    				{ y: ${ka}, label: "카카오페이" }
    			]
    		}]
    	});
    	Piechart.render();
    	/**=======================================================**/
    	/**=======================================================**/
    	/**=======================================================**/
    	/**=======================================================**/
    	var pps = [[]];
    	var j = parseInt(parseInt(${pprice.size()})-1);
    	var titlePirce = addComma(parseInt($("#totalprice"+j+"").val()));
    	
    	for(var i = 0 ; i < ${pprice.size()}-1 ; i++){
    		pps[0].push({
    			name : $("#ppname"+i+"").val(),
    			y : parseInt($("#totalprice"+i+"").val()),
    			exploded: true
    		});		
    	}
    	//console.log(dps);
    	var PriceChart = new CanvasJS.Chart("PriceChart", {
    		exportEnabled: true,
    		animationEnabled: true,
    		title:{
    			text: "상품별 매출액"
    		},
    		legend:{
    			cursor: "pointer",
    			itemclick: explodePie
    		},
    		data: [{
    			type: "pie",
    			showInLegend: true,
    			toolTipContent: "{name}: <strong>{y}원</strong>",
    			indexLabel: "{name} - {y}원",
    			dataPoints: pps[0]
    		}]
    	});
    	PriceChart.render();
    	/**=======================================================**/
    	/**=======================================================**/
    	//월별 매출액
    	//${NaN} $("#undefined").val();
    	//parseInt();
    	var arr = [
    		"${msale[0].totalprice}", 
    		"${msale[1].totalprice}", 
    		"${msale[2].totalprice}", 
    		"${msale[3].totalprice}", 
    		"${msale[4].totalprice}", 
    		"${msale[5].totalprice}", 
    		"${msale[6].totalprice}", 
    		"${msale[7].totalprice}", 
    		"${msale[8].totalprice}", 
    		"${msale[9].totalprice}", 
    		"${msale[10].totalprice}",
    		"${msale[11].totalprice}" 
    		];
    	for(var m = 0 ; m <12 ; m++){
    		if(arr[m] == ""){
				arr[m] = "0";
        	}
    		arr[m] = parseInt(arr[m]);
    	}
    	

    	var MonthPriceChart = new CanvasJS.Chart("MonthPriceChart", {
    		animationEnabled: true,
    		theme: "light2",
    		title:{
    			text: "월 매출액"
    		},
    		subtitles: [{
    			text: "년 매출액 : "+titlePirce+"원",
    			fontSize: 16
    		}],
    		axisX:{
    			valueFormatString: "YYYY-MM",
    			crosshair: {
    				enabled: true,
    				snapToDataPoint: true
    			}
    		},
    		axisY: {
    			title: "원(￦)",
    			crosshair: {
    				enabled: true
    			}
    		},
    		toolTip:{
    			shared:true
    		},  
    		legend:{
    			cursor:"pointer",
    			verticalAlign: "bottom",
    			horizontalAlign: "left",
    			dockInsidePlotArea: true,
    			itemclick: toogleDataSeries
    		},
    		data: [{
    			type: "line",
    			showInLegend: true,
    			name: "매출 액",
    			markerType: "square",
    			xValueFormatString: "YYYY년MM월",
    			color: "#F08080",
    			dataPoints: [
    				{ x: new Date(2019,0), y: arr[0] },
    				{ x: new Date(2019,1), y: arr[1] },
    				{ x: new Date(2019,2), y: arr[2]},
    				{ x: new Date(2019,3), y: arr[3]},
    				{ x: new Date(2019,4), y: arr[4]},
    				{ x: new Date(2019,5), y: arr[5]},
    				{ x: new Date(2019,6), y: arr[6]},
    				{ x: new Date(2019,7), y: arr[7]},
    				{ x: new Date(2019,8), y: arr[8]},
    				{ x: new Date(2019,9), y: arr[9]},
    				{ x: new Date(2019,10), y:arr[10] },
    	          	{ x: new Date(2019,11), y:arr[11] }
    			]
    		}]
    	});
    	MonthPriceChart.render();

    	function toogleDataSeries(e){
    		if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
    			e.dataSeries.visible = false;
    		} else{
    			e.dataSeries.visible = true;
    		}
    		MonthPriceChart.render();
    	}
    	/**=======================================================**/
    	/**=======================================================**/
    	//날씨API
    	var city = [ 'Seoul', 'Gyeonggi-do','Jeonju', 'Naju','Kang-neung','Wonju','Cheongju','Kongju','Daegu','Busan','Jeju,kr'];
    	var count = 11;//도시수 와 일치
    	var str = null;
    	for (var i = 0; i < count; i++) {
	    	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city[i]+"&appid="+"4d8935d879472191b62536867dcb8567";
		        $.ajax({
		            url: apiURI,
		            dataType: "json",
		            type: "GET",
		            async: "false",
		            success: function(resp) {
		            	var name;
		            	name = (resp.name =="Seoul")? "서울": 
		            		            (resp.name =="Gyeonggi-do")?"경기도":
		            		            	(resp.name =="Jeonju")?"전주":
		            		            		(resp.name =="Naju")?"나주":
		            		            			(resp.name =="Kang-neung")?"강릉":
		            		            				(resp.name =="Wonju")?"원주":
		            		            					(resp.name =="Cheongju")?"청주":
		            		            						(resp.name =="Kongju")?"공주":
		            		            							(resp.name =="Daegu")?"대구":
		            		            								(resp.name =="Busan")?"부산":"제주";
		            		str +="<tr>";
		    				str += "<td>";
		    	            str +="<img src=http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png>";
		    	            str +="</td>";
		    	            str +="<td>"+parseFloat((resp.main.temp- 273.15)).toFixed(2)+"</td>";
		    	            str +="<td>"+resp.main.humidity+"</td>";
		    	            str +="<td>"+resp.weather[0].main+"</td>";
		    	            str +="<td>"+resp.weather[0].description+"</td>";
		    	            str +="<td>"+resp.wind.speed +"m/s</td>";
		    	            str +="<td>"+name+"</td>";
		    	            str +="<td>"+(resp.clouds.all)+"%</td>";
		    	            str +="</tr>";
	           			$("#ListAll").html(str);
		            }
		        })
    		}
    	

    	
    });//function()
    
  //가격 세자리마다 , 찍기
    function addComma(num) {
      var regexp = /\B(?=(\d{3})+(?!\d))/g;
      return num.toString().replace(regexp, ',');
    }

	function explodePie (e) {
		if(typeof (e.dataSeries.dataPoints[e.dataPointIndex].exploded) === "undefined" || !e.dataSeries.dataPoints[e.dataPointIndex].exploded) {
			e.dataSeries.dataPoints[e.dataPointIndex].exploded = true;
		} else {
			e.dataSeries.dataPoints[e.dataPointIndex].exploded = false;
		}
		e.PriceChart.render();

	}
    </script>
</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
	<c:forEach var="row" items="${chart}" varStatus="status">
		<input type="hidden" id="pname${status.index}" value="${row.pname}"/>
		<input type="hidden" id="sell_num${status.index}" value="${row.sell_num}"/>
	</c:forEach>
	
	<c:forEach var="row" items="${pprice}" varStatus="status">
		<input type="hidden" id="ppname${status.index}" value="${row.pname}"/>
		<input type="hidden" id="totalprice${status.index}" value="${row.totalprice}"/>
	</c:forEach>

<section id="aa-popular-category" style="
    padding-top: 0px;
    padding-bottom: 0px;
">
	<div id="wrapper" style="padding-left: 300px; padding-right: 150px;">
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
			<br><br><hr>
			<div id="MonthPriceChart" style="height: 330px;width: 70%;margin-left: 190px;"></div>
			<br><br><hr>
			<div id="chartContainer" style="height: 330px; width: 100%;"></div>
			<br><br><hr>
			<div id="PriceChart" style="height: 330px; width: 100%;"></div>
			<br><br><hr>
			<div id="Piechart" style="height: 330px; width: 100%;"></div>
			<br><br><hr>
		<!-- /본문 -->
		<br>
		<div class="x_title">
                <h3 style="text-align:center; font-weight: 900;">기상정보</h3>
                <div class="clearfix"></div>
            </div>
		       <div class="x_content">
                <div class="table-responsive">
                    <table class="table table-hover table1">
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th>현재온도</th>
                                <th>현재습도</th>
                                <th>날씨</th>
                                <th>상세날씨</th>
                                <th>바람</th>
                                <th>지역</th>
                                <th>구름</th>
                            </tr>
                        </thead>
                        <tbody id="ListAll"></tbody>
                        </table>
                    </div>
				<hr>
			</div>
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