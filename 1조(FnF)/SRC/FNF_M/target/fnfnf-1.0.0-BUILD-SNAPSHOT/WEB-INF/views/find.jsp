<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<Html>
<head>
<meta charset='utf-8'>
<title>FnF - Find My Id / Password</title>
<link href="css/bootstrap.css" rel="stylesheet">
<style type="text/css">
    
     body {
		  /*  padding-top: 100px; */
		   padding-bottom: 40px; 
		   background-color: #f5f5f5;  /*  바탕색f5f5f5 */
	}
		
    .tab-content{
    	margin: 50px 0 30px 0;
    }
    
    .nav-tabs{
    	margin: 30px 0 30px 0;
    }
    
    h2{
    	text-align:center;	
    }
    
    #findlogo{
    	 margin: 100px 0 0 150px; 
     }
     
     label{
     	margin: 8px 0 0 20px;
     }
     
     #btnIdSearch, #findpwbtn{
     	width : 190px; height : 40px;
     	margin: 40px 0 0 180px;
     }
    
  	#question, #question1{
		width: 280px;
		height : 35px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script>
        $(document).ready(function() {
            $('a[data-toggle="tab"]').on('hidden.bs.tab', function(e){
                alert("이벤트 실행됨");
            });
        });
        
        $(function(){
        	/* 아이디 찾기 */
        	$("#btnIdSearch").bind("click", function(){
        		
        		$.ajax({
        			url : "idsearchok",
        			type : "POST",
        			data : {user_name : $("#user_name").val(), 
        					email : $("#email").val(),
        				    birth :  $("#birth").val()
        					},
        			dataType : "json",
        			success : function(data){
        				if(data.loginVO == null){
        					alert("입력하신 정보가 일치하지 않습니다.");
        					
        				}else{
        					alert("회원님의 아이디는 " + data.loginVO.user_id + "입니다.");
        				}
        			},
        			error : function(e, b, c){
        				console.log(e + ":" + b + ":" +  c)
        				alert("오류");
        			}
        		})
        	
        	});
        	
        	// 비밀번호 찾기
			$("#findpwbtn").bind("click", function(){
        		$.ajax({
        			url : "pwsearchok",
        			type : "POST",
        			data : JSON.stringify({user_id : $("#user_id").val(), 
        					email : $("#email1").val(),
        				    question :  $("#question").val(),
        				    answer : $("#answer").val()
        					}),
        			dataType : "json",
        			contentType : "application/json; charset=utf-8",
        			success : function(data){
        				if(data.loginVO == null){
        					alert("입력하신 정보가 일치하지 않습니다.");
        					
        				}else{
        					alert("회원님의 임시 비밀번호는 " + data.loginVO + "입니다." + "\n" + "로그인 후 비밀번호를 변경해 주세요.");
        					location.href="/login";
        				}
        			},
        			error : function(e, b, c){
        				console.log(e + ":" + b + ":" +  c)
        				alert("오류");
        			}
        		})
        	
        	});
        });
        
        
</script>
</head>
<body>
<div class="container">
<div class="col-sm-offset-3 col-sm-6">

	<div class="col-sm-offset-2" id="findlogo">
		<a href="index.html"><img alt="LOGO" src="img/logo.png"></a>
	</div>

   <h2><strong>아이디 / 비밀번호 찾기</strong></h2>
   <ul id="myTab" class="nav nav-tabs" role="tablist">
     <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">아이디 찾기</a></li>
     <li role="presentation" class=""><a data-target="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">비밀번호 찾기</a></li>
   </ul>
   
   <div id="myTabContent" class="tab-content">
   
   <!-- 아이디 찾기 -->
     <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
     	<label id="findname" name="findname" class=" col-offset-2 col-sm-3 control-label">이름</label>
			<div class="col-sm-7">
			     <input type="text" class="form-control" name="user_name" id="user_name"  placeholder="예) 김농부"  autofocus required/> 
   			</div>
   			
   			<br /><br /><br />
   			
   		<label id="findname" name="findname" class=" col-offset-2 col-sm-3 control-label">이메일</label>
			<div class="col-sm-7">
			     <input type="text" class="form-control" name="email" id="email"  placeholder="가입시 사용하신 이메일을 입력해 주세요."  autofocus required/> 
   			</div>
   			
   			<br /><br /><br />
   			
     	<label id="findbirth" name="findbirth" class=" col-offset-2 col-sm-3 control-label">생년월일</label>
			<div class="col-sm-7">
			     <input type="text" class="form-control" name="birth" id="birth"  placeholder="예) 20181204"  autofocus required/> 
   			</div>
   			
   			<br /><br /><br />

   			<button class="btn btn-success" type="button" id="btnIdSearch">아이디 찾기</button>
   			
     </div>
     
     
     
     <!-- 비밀번호 찾기 -->
     
     <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
     
          	<label id="findname1" name="findname1" class=" col-offset-2 col-sm-3 control-label">아이디</label>
			<div class="col-sm-7">
			     <input type="text" class="form-control" name="user_id" id="user_id"  placeholder="예) fishers"  autofocus required/> 
   			</div>
   			
   			<br /><br /><br />
     
	 <label id="findemail" name="findemail" class=" col-offset-2 col-sm-3 control-label">이메일</label>
			<div class="col-sm-7">
			     <input type="text" class="form-control" name="email" id="email1"  placeholder="예) aaa@aaa.aaa"  autofocus required/> 
   			</div>
   			
   			<br /><br /><br />
   			
   			<label id="findqes1" name="findqes" class="col-offset-2 col-sm-3 control-label">본인인증질문</label> 
               <div class="col-sm-7">
               	<select id="question" name="question">
					<option value="findplace">가장 기억에 남는 장소는?</option>
					<option value="findfood">가장 좋아하는 음식은?</option>
					<option value="findbook">가장 감명깊게 읽은 책은?</option>
					<option value="findbrand">가장 좋아하는 브랜드는?</option>
				</select>
               </div>		
		     <br /><br /><br />
		                       
               <label id="signupnum" name="signupnum" class="col-offset-2 col-sm-3 control-label">답변</label> 
               <div class="col-sm-7">
               <input  type="text"  class="form-control"  id="answer" name="answer" required/>
               </div>	
               <br /><br /><br />
               
   			<button class="btn btn-success" type="button" id="findpwbtn">비밀번호 찾기</button>
   			
	</div>

    </div>
   </div>
</div>
</body>
</html>