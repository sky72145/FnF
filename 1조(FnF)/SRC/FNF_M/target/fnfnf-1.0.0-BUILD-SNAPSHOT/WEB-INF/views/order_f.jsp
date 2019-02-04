<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="map" value="${map}" />
<c:set var="vo" value="${vo}" />
<%
String user_id = request.getParameter("user_id");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매완료</title>
<script src="js/jquery.min.js"></script>
<script>
function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}
</script>

<jsp:include page="header.jsp"></jsp:include>
	<!-- order_f  -->
		<div calss="pt-2">&nbsp; </div>
		<div class="h3 text-center font-weight-bold">주문 완료</div>
	<div class="container" >
		<table class="table table-sm text-center border bg-light">
			<tr>
				<td>
				<span><strong>고객님의 주문이 완료 되었습니다.</strong></span><br />
				<span>주문내역 및 배송에 관한 안내는 <a href="/myorder?user_id=${user_id}">주문조회</a>
             를 통하여 확인 가능합니다.</span><br />
             	<br />
             	<div>주문번호 : <strong>${vo.idx }</strong></div>
             	<div>주문일자 : <span>${vo.pay_date }</span></div>
				</td>
			</tr>
		</table>

		
    		<div class="col align-self-start">
     			<p class="text-primary h4">결제 정보</p>
    		</div>
    		<table class="table  table-sm table-bordered td">
    			<tr>
    				<td class="align-middle active">최종결제금액</td><td><div><fmt:formatNumber value="${vo.totalprice}" pattern="#,###.##" />원</div></td>
    			</tr>
    			<tr>
    				<td class="align-middle active">결제수단</td><td><div>${vo.pay }</div><br />
    					<div>
    					<c:choose>
    						<c:when test="${vo.pay eq '무통장'}">
        							무통장 입금 요망
        							신한은행 : 110-000-00000 FNF
  							  </c:when>
   									 <c:otherwise>
      								  카카오 페이 결제가 완료 되었습니다.
    								</c:otherwise>
						</c:choose>
    			</tr>
    		</table>

    		
    		<div class="col align-self-start">
     			<p class="text-primary h4">주문 상품 정보</p>
    		</div>
    		<table class="table border table-sm">
			<thead class="table-bordered th">
				<tr class="active">
					<th class="text-center">이미지</th>
					<th class="text-center">상품정보</th>
					<th class="text-center">판매가</th>
					<th class="text-center">수량</th>
					<th class="text-center">적립금</th>
					<th class="text-center">배송비</th>
					<th class="text-center">합계</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${cartList}" var="cart">
						<c:set var="product_sum" value="${cart.product_count * cart.price }" />
						<fmt:formatNumber var="productSum" value="${map.productSum}" pattern="#,###.##" />
						<fmt:formatNumber var="total" value="${map.allSum}" pattern="#,###.##" />
						<fmt:formatNumber var="product_mil" value="${product_sum * 0.01}" pattern="#" />
						<fmt:formatNumber var="fee" value="${map.fee}" pattern="#,###.##" />
						<form name="updateform" method="get" action="/main/modify">
							<input type="hidden" name="user_id" id="user_id" value="${cart.user_id}" />
							 <input type="hidden" name="pcode" value="${cart.pcode}" />
							<tr class="text-center">
								<td><img class="img-rounded" style="width: 100px; height: 100px;" src="img/${cart.filename}"></td>
								<td>${cart.pname}</td>
								<td><fmt:formatNumber value="${cart.price}" pattern="#,###.##" />원</td>
								<td>${cart.product_count}</td>
								<td>${product_mil}원</td>
								<td>${map.fee}원</td>
								<td><fmt:formatNumber value="${product_sum}" pattern="#,###.##" />원</td>
							</tr>
							<c:set var="sum" value="${sum + product_sum}" />
					</c:forEach>
			</tbody>
			<tfoot>
				
				<tr class="bg-light active">
					<td colspan="8" class="text-right">상품구매금액 <span> <c:out value="${productSum}" />원
				</span> + 배송비 <span> ${map.fee}원</span> = 합계 : <span> ${total} 원</span></td>
			</tfoot>
		</table>
    		
		<table class="table text-center h4">
			 	<tr class="active">
			 		<td>총 상품금액</td><td>배송비</td><td>적립금 사용금액</td><td >총 결제금액</td>
			 	</tr>
			 	<tr class="h4">
			 		<td>${productSum}</td><td>+<fmt:formatNumber value="${vo.del_price}" pattern="#,###.##" /></td><td>-${vo.mile_used}</td><td class="text-primary"><strong><fmt:formatNumber value="${vo.totalprice}" pattern="#,###.##" />원</strong></td>
			 	</tr>
			 </table>

			 <div class="col align-self-start">
     			<p class="text-primary h4">배송지정보</p>
    		 </div>
			 <table class="table table-sm border-left border-right border-bottom">
    		<tr>
    			<td class="p-2 pl-3 active">받는분 : </td><td class="border-right">${vo.receiver_name }</td>
    		</tr>
    		<tr>
    			<td class="p-2 pl-3 active">우편번호 : </td><td class="border-right">${vo.zipcode }</td>
    		</tr>
    		<tr>
    			<td class="p-2 pl-3 active align-middle" rowspan="2 ">주소 : </td><td colspan="2"> ${vo.address1 }</td>
    		</tr>
    		<tr>
    			<td colspan="2">  ${vo.address2 }</td>
    		</tr>
    		<tr>
    			<td class="p-2 pl-3 active">휴대전화 : </td><td colspan="2"> ${vo.phone }</td>
    		</tr>
    		<tr>
    			<td class="p-2 pl-3 active">이메일 : </td><td colspan="2"> ${vo.email }</td>
    		</tr>
    		<tr>
    			<td class="p-2 pl-3 active">배송 메세지 : </td><td colspan="2">${vo.del_message}</td>
    		</tr>
    			
	</table>

		<div  class="text-center">
			<input type="button" class="btn btn-dark" value="주문확인하기 " onclick="location.href='mypage'">&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-light" value="쇼핑계속하기" onclick="location.href='/'">
		</div>
		<div calss="pt-2">&nbsp;</div>
	</div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
  <!-- / footer -->
</body>
</html>