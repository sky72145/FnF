<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최근배송지</title>
</head>
<body>
<h3>최근배송지 목록</h3>
<table class="table table-bordered">
		<thead class="table-bordered th">
			<tr class="active">
				
				<th class="text-center">받는분</th>
				<th class="text-center">우편번호</th>
				<th class="text-center">기본주소</th>
				<th class="text-center">상세주소</th>
				<th class="text-center">전화번호</th>
				<th class="text-center">이메일</th>
				
			</tr>
		</thead>
		<tbody>
	<c:forEach items="${addr}" var="addr">
		<tr class="text-center">
			<td>${addr.receiver_name}</td>
			<td>${addr.zipcode}</td>
			<td>${addr.address1}</td>
			<td>${addr.address2}</td>
			<td>${addr.phone }</td>
			<td>${addr.email }</td>
		</tr>
	
	</c:forEach>
	</tbody>
</form>
</body>
</html>