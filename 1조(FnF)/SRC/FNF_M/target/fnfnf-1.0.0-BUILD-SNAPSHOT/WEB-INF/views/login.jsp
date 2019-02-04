<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>FnF - Login</title>

    <link href="css/bootstrap.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
    <style type="text/css">
		
 		body {
		   padding-top: 100px;
		   padding-bottom: 40px; 
		   background-color: #fcfcfc;  /*  바탕색f5f5f5 */
		}
		
	 	.form-signin {
		  width: 100%;
		  max-width: 420px;
		  padding: 15px;  
		  margin: auto; /* 폼 가운데 정렬 */
		} 
		
		.form-label-group { /* 텍스트 박스 */
		 position: relative;  /* placehoder 글씨가 사라져..! */
		  margin-bottom: 1rem; /* 텍스트 박스 간격 */ 
		}  
		
	.form-label-group > label {  /* 라벨이 제 위치에 들어가도록함 */
		  position: absolute;
		  top: 0;
		  left: 0;
		  display: block;
		  width: 100%;
		  margin-bottom: 0; /* Override default `<label>` margin */
		  line-height: 1.5;
		  color: #495057;
		  cursor: text; /* Match the input under the label */
		  border: 1px solid transparent;
		  border-radius: .25rem;
		  transition: all .1s ease-in-out;
		}  
		
		#naver, #kakao {  /* 버튼 크기 */
			width : 190px; height : 40px;
		}
		
		#find {   /* 위치 오른쪽 */
			text-align:right; 
		}
		
		img {
			width:240px;
			height:100px;
		}
		
		#btnlogin, #btnsignup{
			height : 40px;
		}
		
		#findmyid{
			margin-left: 240px;
		}
    	
    </style>
    
  <script>
	/* $(function(){
		$("#btnlogin").bind("click", function(){
			if(error != null) {
				alert((${error});
			}
			
			if(logout != null) {
				alert(${logout});
			}
		});
	}); */
  </script>

  </head>

  <!-- <body onload='document.loginForm.user_id.focus();'> -->
  	
  	<%-- <h2><c:out value="${error}" /></h2>
  	<h2><c:out value="${logout}" /></h2> --%>
    
    <form class="form-signin" name="loginForm" action="/login" method="post">
      <div class="text-center mb-4">
      <c:if test="${!empty error}">
      	<script>
      		alert("<c:out value='${error}' />");
      	</script>
      </c:if>
      
  	  <h3><c:out value="${logout}" /></h3>
      
           	<a href="index"><img alt="LOGO" src="img/logo.png"></a>
        <h1 ><strong>로그인</strong></h1>
        
      </div>
      <hr>

      <div class="form-label-group">
        <input type="text" id="loginid" class="form-control" placeholder="ID를 입력해주세요." required autofocus name="user_id">
      </div>

      <div class="form-label-group">
        <input type="password" id="loginpswd" class="form-control" placeholder="Password를 입력해 주세요." required name="password" >
      </div>

      <button class="btn btn-lg btn-danger btn-block" type="submit" id="btnlogin">LOGIN</button>
      <br/>
      
   	  <div>
	      <button class="btn btn-success" type="submit" id="naver">네이버로 로그인</button>
	      <button class="btn btn-warning " type="submit" id="kakao">카카오로 로그인</button>
      </div> 
      <br/>

      <button class="btn btn-lg btn-outline-dark btn-block" type="button" onclick="location.href='signupmain' " id="btnsignup">SIGNUP</button>
      <hr>

      <p id="findmyid">
      	<a href="find"  id="find" >아이디/비밀번호 찾기</a> 
      </p>
     
     	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    

  </body>
</html>
