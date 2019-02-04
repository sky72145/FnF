<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FnF-Sign Up</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<script src="js/jquery.min.js"></script>
<style type="text/css">

	#body{
		   padding-top: 200px;
		   padding-bottom: 40px; 
		   background-color: #fcfcfc;  /*  바탕색f5f5f5 */
	}
	
	#usersu, #sellersu{
		width : 190px; height : 49px
	}
	
	img{
		text-align:center
	}
	

</style>
</head>
<body id="body">

      <div class="container"  style="text-align: center;">
         <div class="row">
            <div class="col-md-12">
                  <div class="row">
                     <div class="col-md-offset-3 col-md-6">
                     
                           <h1 id="title"><strong>회 원 가 입</strong></h1>
                             
                           <hr width="100%" >
							<h5>회원님의 유형을 선택해 주세요.</h5>
							<br />
							
							<!-- 회원 가입 유형 버튼 -->
							 <div>
							      <button class="btn btn-success" type="submit" id="usersu" onclick="location.href='customersignup' ">일반회원가입</button>
							      <button class="btn btn-warning " type="submit" id="sellersu" onclick="location.href='sellersignup' ">판매회원가입</button>
						      </div>
						      
						      <hr width="100%" >
						      
						      <a href="index.html"><img alt="LOGO" src="img/logo.png"></a>
                     		 						      
                        </div>
                  </div>
               </div>
            </div>
         </div>     
</body>
</html>
