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
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
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
  	// naver
	function naverLogin(){
		self.location = '${url}';
	}
    
    // kakao
    Kakao.init('ee9540c7b281317671ca1f94bc5b5d47');
    function loginWithKakao() {
    	//location.href = "/kakaosignup";
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
            // var user_id = authObj.id;
            
            Kakao.Auth.setAccessToken(authObj.access_token);
            
			Kakao.Auth.getStatus(function(statusObj) {
            	console.log(statusObj);
            	
            	if (statusObj.status === "connected") {
	            	
            		$.ajax({
		            	url : "/kakaoLoginCheck/" + statusObj.user.id,
						type : "POST",
						dataType : "json",
						data : JSON.stringify(authObj),
						contentType : "application/json; charset=utf-8",
						success : function(data) {
							if (data.cnt == 0) {
								var form = "<form action='/kakaosignup' method='get' id='kakaoForm'>";
								
								form += "<input type='hidden' name='kakaoid' value='" + statusObj.user.id + "'>";
								form += "</from>";
								
								$("body").append(form);
								
								$("#kakaoForm").submit();
							} else {
								location.href = "/";
							}
						},
						error : function(err) {
							console.log("error 발생 " + err);
						}
	            	});
            	}	
            })
            
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };

	/* 엔터로 로그인 버튼 활성화 */
    $(function(){
    	$("#frm").bind("keydown", function(evt){
    		if(evt.keyCode == 13){
		    	 $.ajax({
		    		url : "/loginCheck",
					method : "POST",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify({
						"user_id" : $("#user_id").val()
					}),
					success : function(data) {
						if(data.cnt == 0){
							console.log("탈퇴회원인가 비교해 보자");
							$("#frm").submit();
						}else{
							alert("탈퇴한 회원입니다. 다른 아이디로 로그인 해주세요.");
						}
					},
					error : function(err) {
						console.log("error 발생 " + err);
					}
		    	});   //ajax end
	    	}  //if end
    	});
    	
    	/* 클릭으로 로그인 버튼 활성화 */
	    $("#btnlogin").on("click", function(){
	    	 $.ajax({
	    		url : "/loginCheck",
				method : "POST",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify({
					"user_id" : $("#user_id").val()
				}),
				success : function(data) {
					if(data.cnt == 0){
						console.log("탈퇴회원인가 비교해 보자");
						$("#frm").submit();
					}else{
						alert("탈퇴한 회원입니다. 다른 아이디로 로그인 해주세요.");
					}
				},
				error : function(err) {
					console.log("error 발생 " + err);
				}
	    	});
	    });
    });
    

  </script>

  </head>
    
    <form id="frm" class="form-signin" name="loginForm" action="/login" method="post" >
      <div class="text-center mb-4">
      
      <c:if test="${!empty error}">
      	<script>
      		alert("<c:out value='${error}' />");
      	</script>
      </c:if>
      
      <c:if test="${!empty logout}">
      	<script>
      		alert("<c:out value='${logout}' />");
      	</script>
      </c:if>

        <a href="/"><img alt="LOGO" src="img/logo2.png"></a>
        <h1 ><strong>로그인</strong></h1>
        
      </div>
      <hr>

      <div class="form-label-group">
        <input type="text" id="user_id" name="user_id" class="form-control" placeholder="ID를 입력해주세요." required autofocus>
      </div>

      <div class="form-label-group">
        <input type="password" id="password" name="password"class="form-control" placeholder="Password를 입력해 주세요." required >
      </div>

      <button class="btn btn-lg btn-danger btn-block" type="button" id="btnlogin" name="btnlogin" >LOGIN</button>
      <br/>
      
   	  <div>
	      <button class="btn btn-success" type="button" id="naver" onclick="naverLogin()">네이버로 로그인</button>
	      <button class="btn btn-warning " type="button" id="kakao" onclick="loginWithKakao()">카카오로 로그인</button>
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
