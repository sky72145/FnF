<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="myheader.jsp"%>
<section id="sd-ss">
	<!-- 본문 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<h3>&nbsp;&nbsp;&nbsp;Category</h3>
				<li><a href='/myorder?user_id=<c:out value="${user_id}"/>'>주문 배송</a></li>
				<li><a href="mymessage.html">메세지</a></li>
				<li><a href="myrecentpage.html">최근 본 상품</a></li>
				<li><a href='/modifys?user_id=<c:out value="${user_id}"/>'>회원 정보 수정</a></li>
				<li><a href='/remove?user_id=<c:out value="${user_id}"/>'>회원 탈퇴</a></li>
			</ul>
		</div>
		<div class="col-md-12">
			<div class="aa-memberlogin-area">
				<div class="wrapper">
					<div class="col-md-10">
						<div class="aa-memberlogin-login">
							<h1 id="title">
								<strong>개인정보</strong>
							</h1>
							<hr width="100%">
							<form action="/signup" id="signupform" name="signupform"
								method="post">

								<label id="signid" name="signeid"
									class="col-md-offset-1 col-sm-3  control-label">ID</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" name='user_id'
										id='user_id' value='<c:out value="${member.user_id }"/>'
										readonly="readonly">
								</div>
								<br /> <br /> <br /> <label id="signupemail"
									name="signupemail"
									class="col-md-offset-1 col-sm-3 control-label">Email</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="email" name="email"
										value='<c:out value="${member.email }"/>' />
								</div>
								<br /> <br /> <br /> <label id="signuppswd" name="signuppswd"
									class="col-md-offset-1 col-sm-3 control-label">비밀번호</label>
								<div class="col-sm-5">
									<input type="password" class="form-control" id="signuppswd"
										name="signuppswd" value='<c:out value="${member.password }"/>' />
								</div>
								<br /> <br /> <br /> <label id="signupname" name="signupname"
									class="col-md-offset-1 col-sm-3 control-label">이름</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="signupname"
										name="signupname"
										value='<c:out value="${member.user_name }"/>'
										readonly="readonly" />
								</div>
								<br /> <br /> <br /> <label id="signupnum" name="signupnum"
									class="col-md-offset-1 col-sm-3 control-label">휴대 전화</label>
								<div class="col-sm-5">
									<input type="phone number" class="form-control" id="signupnum"
										name="signupnum" value='<c:out value="${member.phone }"/>' />
								</div>
								<div class=col-sm-3>
									<button type="button" id="confirm1" class="btn btn-success "
										required>인증받기</button>
								</div>
								<br /> <br /> <br /> <label id="signupname" name="signupname"
									class="col-md-offset-1 col-sm-3 control-label">생일</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="signupname"
										name="signupname" value='<c:out value="${member.birth }"/>'
										readonly="readonly" />
								</div>
								<br /> <br /> <br /> <label id="signupname" name="signupname"
									class="col-md-offset-1 col-sm-3 control-label">비밀번호 찾기
									질문</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="signupname"
										name="signupname" value='<c:out value="${member.question }"/>' />
								</div>
								<br /> <br /> <br /> <label id="signupname" name="signupname"
									class="col-md-offset-1 col-sm-3 control-label">답변</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="signupname"
										name="signupname" value='<c:out value="${member.answer }"/>' />
								</div>
								<br /> <br />
								<hr width="100%">
								<br />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<%@include file="myfooter.jsp"%>