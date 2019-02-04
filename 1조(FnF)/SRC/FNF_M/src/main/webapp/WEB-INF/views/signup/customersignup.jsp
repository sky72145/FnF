<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FnF-Sign Up</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<script src="js/jquery.min.js"></script>
<style type="text/css">
body {
	padding-top: 80px;
	padding-bottom: 100px;
	background-color: #fcfcfc; /*  바탕색f5f5f5 */
}

#btnSignup, #btnCancle {
	width: 222px;
	height: 49px;
	text-align: center;
}

#title {
	text-align: center;
	margin: 50px 0 50px 0;
}

#signupform {
	text-align: left;
}

span {
	color: grey;
	font-size: small;
}

#repuire {
	text-align: right;
}

.control-label {
	font-size: 15px;
}

.txt_checkbox {
	font-size: 13px;
}

#confirm, #confirm1 {
	height: 33px
}

#userlogo {
	text-align: center;
}

label {
	margin-top: 7px;
}

#question {
	width: 280px;
	height: 35px;
}

#id_chk{
	margin: 10px 0 0 0;
	font-size:1em; 
	color:red;
}
.valCk{
	margin: 10px 0 0 0;
	font-size:1em; 
	color:red;
	text-align : left;
}
</style>

<script src="js/jquery.min.js"></script>


<script>

	/* 체크박스 전체 선택 */
	$(function(){
		$('#checkAll').on('click', function() {
		    var chk = $(this).is(':checked');

		    if (chk) {
		        $("#private").prop('checked', true);
		        $("#private1").prop('checked', true);
		        $("#private2").prop('checked', true);
		        $("#private3").prop('checked', true);
		    } else {
		        $("#private").prop('checked', false);
		        $("#private1").prop('checked', false);
		        $("#private2").prop('checked', false);
		        $("#private3").prop('checked', false);
		    }
		});
		/*  $("$input[name=rqchbox]").click(function(){
	            $("input[id=checkAll]").prop("checked", false);
	        }); */
	});
	


	/* 데이터 입력 */
 	$(function() {
		$("#btnSignup").bind("click", function() {	
			if ($("#private").prop("checked") == true && $("#private1").prop("checked") == true && $("#private2").prop("checked") == true && $("#answer").val().length > 0) {
			$.ajax({
				url : "customersignup/",
				method : "POST",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify({
					"user_id" : $("#user_id").val(),
					"email" : $("#email").val(),
					"password" : $("#password").val(),
					"user_name" : $("#user_name").val(),
					"phone" : $("#phone").val(),
					"birth" : $("#birth").val(),
					"question" : $("#question").val(),
					"answer" : $("#answer").val(),
					"mile_total" : 1000,
					"mile_used" : 0,
					"mile_remain" : 1000
					
				}),
				success : function(data) {
					//alert("가입해 주셔서 감사합니다. 로그인 해주세요ggggggggggggggggggggg!"); //되는데 이거 안떠.... 괜찮나.....
				},
				error : function(err) {
					console.log("error 발생 " + err);
				}
			});
			alert("가입해 주셔서 감사합니다. 즐거운 쇼핑되세요!");
			location.href="login";
			}
		});
	});
 	
	/* 유효성 검사 */
 	$(function(){
		$("#private2").bind("click", function(){
			if(!$("#idhi").val() == "true" && $("#pwhi").val()=="true" && $("#emailhi").val() == "true" && $("#namehi").val()=="true" && $("#phonehi").val() == "true" && $("#birthhi").val()=="true"){
				$("#btnSignup").attr("disabled");
			}
		});
	}); 

	function idvalChk(){
		var idreg = /^[a-z0-9_]{4,8}$/;
		
		if(idreg.test($("#user_id").val()) == true){
			$("#idhi").val("true");
			document.getElementById('id_chk').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else if(idreg.test($("#user_id").val()) == false){
			document.getElementById('id_chk').innerHTML = "영어와 숫자 4~8자까지 입력 가능합니다."
			$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	function emailChk(){
		 var emailreg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		 
		 if(emailreg.test($("#email").val()) == true){
			$("#emailhi").val("true");
			document.getElementById('emailval').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else{
			document.getElementById('emailval').innerHTML = "이메일 형식이 아닙니다."
				$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	function pwvalChk(){
		 var pwreg = /^[a-zA-Z0-9_]{8,15}$/; 
		 
		 if(pwreg.test($("#password").val()) == true){
			$("#pwhi").val("true");
			document.getElementById('pwval').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else{
			document.getElementById('pwval').innerHTML = "8~15자만 입력가능합니다."
				$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	
	/* 비밀번호 확인 */
	function passwordChk() {
		var userPassword1 = $('#password').val();
		var userPassword2 = $('#password1').val();

		if (userPassword1 != userPassword2) {
			document.getElementById('passwordch').innerHTML = "비밀번호가 일치하지 않습니다."
			$("#btnSignup").attr("disabled", "disabled");
			$("#divPassword").addClass("has-error")
			$("#divPassword").removeClass("has-success")
			$("#password1").focus();
		} else {
			document.getElementById('passwordch').innerHTML = " "
			$("#divPassword").addClass("has-success")
			$("#divPassword").removeClass("has-error")
			$("#btnSignup").removeAttr("disabled");
		}
	}
	
	function nameChk(){
		var namereg = /^[가-힣]{2,4}$/;
		if(namereg.test($("#user_name").val()) == true){
			$("#namehi").val("true");
			document.getElementById('nameval').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else{
			document.getElementById('nameval').innerHTML = "형식이 올바르지 않습니다."
				$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	function phoneChk(){
		var phonereg = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/; 
		 
		 if(phonereg.test($("#phone").val()) == true){
			$("#phonehi").val("true");
			document.getElementById('phoneval').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else{
			document.getElementById('phoneval').innerHTML = "숫자만 입력해 주세요."
				$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	function birthChk(){
		var birthreg = /^[1-2]{1}[0-9]{3}[0-1]{1}[0-9]{1}[0-3]{1}[0-9]{1}$/;		 
		 if(birthreg.test($("#birth").val()) == true){
			$("#birthhi").val("true");
			document.getElementById('birthval').innerHTML = ""
				$("#btnSignup").removeAttr("disabled");
		}else{
			document.getElementById('birthval').innerHTML = "숫자 8자리만 입력해주세요."
				$("#btnSignup").attr("disabled", "disabled");
		}
	}
	
	
	/* 필수입력 체크 */
	function requiredch() {
		if ($("#user_id").val().length < 1) {
			alert("아이디를 입력해 주세요");
			$("#user_id").focus();
		}else if ($("#email").val().length < 1) {
			alert("이메일을 입력해주세요");
			$("#email").focus();
		}else if ($("#password").val().length < 1) {
			alert("비밀번호를 입력해 주세요");
			$("#password").focus();	
		}else if ($("#password1").val().length < 1) {
			alert("비밀번호를 확인해 주세요");
			$("#password1").focus();	
		}else if ($("#user_name").val().length < 1) {
			alert("이름을 입력해주세요");
			$("#user_name").focus();
		}else if ($("#phone").val().length < 1) {
			alert("번호를 입력해주세요");
			$("#phone").focus();
		}else if ($("#birth").val().length < 1) {
			alert("생일을 입력해주세요");
			$("#birth").focus();
		}else if ($("#answer").val().length < 1) {
			alert("답변을 입력해주세요");
			$("#answer").focus();
		}else if ($(".chbox").prop("checked") == false) {
			alert("필수약관에 동의 해주세요");	
		}
	}

	/* 아이디 중복체크 */
	$(function() {
		$("#user_id").bind("change",function() {
			var query = {"user_id" : $(this).val()};
				$.ajax({
					url : "idCheck",
					type : "POST",
					dataType : "json",
					data : JSON.stringify(query),
					contentType : "application/json; charset=utf-8",
					success : function(data) {
						if (data.cnt == 0) {
							//alert("사용 가능한 아이디입니다.")
							//document.getElementById('id_chk').innerHTML = " "
							//$("#btnSignup").removeAttr("disabled");
							$("#divInputId").addClass("has-success");
							$("#divInputId").removeClass("has-error");
						} else {
							//alert("사용 불가능한 아이디 입니다.")
							document.getElementById('id_chk').innerHTML = "사용 불가능한 아이디입니다."
							//$("#btnSignup").attr("disabled", "disabled");
							$("#divInputId").addClass("has-error");
							$("#divInputId").removeClass("has-success");
							$("#user_id").focus();
						}
					},
					error : function(err) {
						console.log("error 발생 " + err);
					}
				});
		});
		
		$("#email").bind("change",function() {
			var query = {"email" : $(this).val()};
			$.ajax({
				url : "emailCheck",
				type : "POST",
				dataType : "json",
				data : JSON.stringify(query),
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					if (data.cnt == 0) {
						$("#divInputemail").addClass("has-success");
						$("#divInputemail").removeClass("has-error");
					} else {
						document.getElementById('emailval').innerHTML = "사용 불가능한 이메일입니다."
						$("#btnSignup").attr("disabled", "disabled");
						$("#divInputemail").addClass("has-error");
						$("#divInputemail").removeClass("has-success");
						$("#email").focus();
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
<body>
	<section id="aa-memberlogin">
		<div class="container" style="text-align: center;">
			<div class="row">
				<div class="col-md-12">
					<div class="aa-memberlogin-area">
						<div class="row">

							<div class="col-sm-offset-1 col-md-10">
								<div class="aa-memberlogin-login" ng-app="ngRequiredApp" ng-controller="ngRequiredCtrl">

									<a href="/"><img alt="LOGO" src="img/logo.png"></a>

									<h1 id="title">
										<strong>일반회원가입</strong>
									</h1>


									<hr width="100%">

									<form action="login" method="post">

										<div class="col-md-offset-7 col-sm-6">
											<p id="requireplz">
												<span>*표시는 필수 입력사항입니다.</span>
											</p>
										</div>
										
										<br /> <br /> 
										
										<label id="user_id_label" name="user_id_label" class="col-md-offset-1 col-sm-3 control-label">아이디*</label>
										<div class="col-sm-4" id="divInputId">
											<input type="text" class="form-control" name="user_id" id="user_id" placeholder="예) fishers" autofocus required onkeyup="idvalChk();"/>
											<input type="hidden" id="idhi" value="false" />
										</div>
										<div class=col-sm-4>
											<p id="id_chk" class="valCk"></p>
										</div>
										
										<br /> <br /> <br /> 
										
										<label id="emaillabel" name="emaillabel"
											class="col-md-offset-1 col-sm-3  control-label">E-Mail*</label>
										<div class="col-sm-4" id="divInputemail">
											<input type="email" class="form-control" name="email" id="email" placeholder="예) aaa@aaa.aaa" autofocus required  onkeyup="emailChk();"/>
											<input type="hidden" id="emailhi" value="false" />
										</div>
										<div class=col-sm-4>
											<!-- <button type="button" id="confirm" class="btn btn-success " required>인증받기</button> -->
											<p id="emailval" class="valCk"></p>
										</div>
										
										<br /> <br /> <br /> 
										
										<label id="password_label" name="password_label" class="col-md-offset-1 col-sm-3 control-label">비밀번호*</label>
										<div class="col-sm-4">
											<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해 주세요." onkeyup="pwvalChk();" required />
											<input type="hidden" id="pwhi" value="false" />
										</div>
										<div class=col-sm-4>
											<p id="pwval" class="valCk"></p>
										</div>
										
										<br /> <br /> <br /> 
										
										<label id="password1_label" name="password_label1" class="col-md-offset-1 col-sm-3 control-label">비밀번호확인*</label>
										<div class="col-sm-4" id="divPassword">
											<input type="password" class="form-control" id="password1" name="password1" placeholder="비밀번호를 다시 입력해 주세요." onkeyup="passwordChk();" required />
										</div>
										<div class=col-sm-4>
											<p id="passwordch" class="valCk"></p>
										</div>
										
										<br /> <br /> <br />
										 
										<label id="user_name_label" name="user_name_label" class="col-md-offset-1 col-sm-3 control-label">이름*</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" id="user_name" name="user_name" placeholder="예) 김농부" onkeyup="nameChk();" required />
											<input type="hidden" id="namehi" value="false" />
										</div>
										<div class=col-sm-4>
											<p id="nameval" class="valCk"></p>
										</div>
										
										<br />
										<br />
										<br /> 
										
										<label id="phone_label" name="phone_label" class="col-md-offset-1 col-sm-3 control-label">휴대 전화*</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" id="phone" name="phone" placeholder="예) 01000000000" required onkeyup="phoneChk();"/>
											<input type="hidden" id="phonehi" value="false" />
										</div>
										<div class=col-sm-4>
											<p id="phoneval" class="valCk"></p>
										</div>
										
										<br />
										<br />
										<br />
										 
										<label id="birth_label" name="birth_label" class="col-md-offset-1 col-sm-3 control-label">생년월일*</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" id="birth" name="birth" placeholder="예) 20181208" required onkeyup="birthChk();"/>
											<input type="hidden" id="birthhi" value="false" />
										</div>
										<div class=col-sm-4>
											<p id="birthval" class="valCk"></p>
										</div>
										
										<br />
										<br />
										<br /> 
										
										<label id="question_label" name="" class="col-md-offset-1 col-sm-3 control-label">본인인증질문*</label>
										<div class="col-sm-4">
											<select id="question" name="question">
												<option value="가장 기억에 남는 장소는?">가장 기억에 남는 장소는?</option>
												<option value="가장 좋아하는 음식은?">가장 좋아하는 음식은?</option>
												<option value="가장 감명깊게 읽은 책은?">가장 감명깊게 읽은 책은?</option>
												<option value="가장 좋아하는 브랜드는?">가장 좋아하는 브랜드는?</option>
											</select>
										</div>
										
										<br />
										<br />
										<br /> 
										
										<label id="answer_label" name="answer_label" class="col-md-offset-1 col-sm-3 control-label">답변*</label>
										<div class="col-sm-4">
											<input type="text" class="form-control" id="answer" name="answer" required />
										</div>
										
										<br />
										<br />


										<hr width="100%">



										<!-- 이용약관 -->
										<div class="col-sm-offset-2 col-sm-6 text-left">

											<div class="agreement">
												<div class="check">
													<label class="inp_check check_agree label_all_check">
														<input type="checkbox" name="agree_allcheck" id="checkAll"> 
														<span class="txt_checkbox">전체동의</span>
													</label>
												</div>
												<div class="check_view">
													<label class="select_check check_agree"> 
														<input type="checkbox" id="private" value="" name="rqchbox" class="chbox" required> 
														<span class="txt_checkbox">이용약관 <span class="sub">(필수)</span></span>
													</label> 
													<a href="javascript:void(window.open('terms', '','width=500, height=500'))" class="linked" id="usingterms">약관보기&gt;</a>
												</div>

												<div class="check_view">
													<label class="select_check check_agree"> 
													<input type="checkbox" id="private1" name="rqchbox" value=""class="chbox" required>
														<span class="txt_checkbox">개인정보처리방침<span class="sub">(필수)</span></span>
													</label> 
													<a href="javascript:void(window.open('terms1', '','width=500, height=500'))" class="linked" id="personalterms">약관보기&gt;</a>
												</div>

												<div class="check_view">
													<label class="select_check check_agree check_fourteen">
														<input type="checkbox" id="private2" value="n" name="rqchbox" class="chbox" required >
														<span class="txt_checkbox">본인은 만 14세 이상입니다. <span class="sub">(필수)</span></span>
													</label>
												</div>

												<div class="check_view">
													<label class="select_check check_agree "> 
													<input type="checkbox" id="private3" name="rqchbox" class="styled-checkbox-black" > 
													<span class="txt_checkbox">이벤트 및 혜택 알림 수신 <span class="sub">(선택)</span></span>
													</label>
												</div>


											</div>
										</div>

										<hr width="100%">
										<br />

										<div>
											<button type="submit" id="btnSignup" class="btn btn-success col-md-offset-2" disabled="disabled" onclick="requiredch();" >가입하기</button>
											<button type="button" id="btnCancle" class="btn btn-info col-md-offset-1" onclick="location.href='/'">취소하기</button>
										</div>
									</form>	
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>




