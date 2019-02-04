<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최근배송지</title>
<link href="/resources/css/bootstrap.css" rel="stylesheet">   
<link href="css/custom.css" rel="stylesheet" type="text/css">
<script src="js/jquery.min.js"></script>
<script>

function addrset(el) {
	$(opener.document).find("#receiver_name").val( $(el).closest('tr').find('input[name="receiver_name"]').val() );
	 $(opener.document).find("#zipcode").val( $(el).closest('tr').find('input[name="zipcode"]').val() );
	 $(opener.document).find("#address1").val( $(el).closest('tr').find('input[name="address1"]').val() );
	 $(opener.document).find("#address2").val( $(el).closest('tr').find('input[name="address2"]').val() );
	 $(opener.document).find("#phone").val( $(el).closest('tr').find('input[name="phone"]').val() );
	 $(opener.document).find("#email").val( $(el).closest('tr').find('input[name="email"]').val() );
	 window.close();
	}

</script>
</head>
<body>
<h3>최근배송지</h3>
<table class="table table-bordered">
		<thead class="table-bordered th">
			<tr class="active">
				
				<th class="text-center">받는분</th>
				<th class="text-center">우편번호</th>
				<th class="text-center">기본주소</th>
				<th class="text-center">상세주소</th>
				<th class="text-center">전화번호</th>
				<th class="text-center">이메일</th>
				<th class="text-center"> </th>
				
			</tr>
		</thead>
		<tbody>
		<c:choose>
				<c:when test="${addr == '[]'}">
				<td colspan="7" class="text-center h4">최근 배송지가 없습니다.</td>
				</c:when>
				<c:otherwise>
	<c:forEach items="${addr}" var="addr">
		<tr class="text-center">
			<td id="receiver_name">${addr.receiver_name}</td>
			<td id="zipcode">${addr.zipcode}</td>
			<td id="address1">${addr.address1}</td>
			<td id="address2">${addr.address2}</td>
			<td id="phone">${addr.phone }</td>
			<td id="email">${addr.email }</td>
			<input type="hidden" name="receiver_name" value="${addr.receiver_name}">
			<input type="hidden" name="zipcode" value="${addr.zipcode}">
			<input type="hidden" name="address1" value="${addr.address1}">
			<input type="hidden" name="address2" value="${addr.address2}">
			<input type="hidden" name="phone" value="${addr.phone}">
			<input type="hidden" name="email" value="${addr.email}">
			<td><button type="button" class="btn btn-success" onclick="addrset(this)">선택</button>
		</tr>
	
	</c:forEach>
	<td colspan="7" class="text-right text-danger h5"><img src="img/ico_required.gif"> 최근배송한 3곳의 배송지를 출력합니다.</td>
	</c:otherwise>
	</c:choose>
	</table>
	</tbody>

</body>
</html>