<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<!--script  -->
<script src="js/jquery.min.js"></script>

<script>
function f_order(){
	var frm = document.getElementById('form');
	 if($(".chk").is(":checked") == false){
			alert("상품이 선택되지 않았습니다.");
			return false;
			}else{
			frm.action = '/selectdel/';
			frm.submit();
		}	
}
$(function(){
	$("#btnAllDelete").bind("click", function(){
		location.href = "del/${user_id}";
	});
	
	 $("#btnOrder").on("click", function(){
		
		 location.href = "/order"; 
	}); 
	 $("#chkall").click(function(){
	        //클릭되었으면
	        if($("#chkall").prop("checked")){
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[class=chk]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[class=chk]").prop("checked",false);
	        }
	    })
});
</script>
<meta charset="UTF-8">
<title>장바구니</title>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="header.jsp"></jsp:include>
<%-- <input type="hidden" name="user_id" value="${cart.user_id}" /> --%>
<div class="container">
	<div calss="pt-2">&nbsp;</div>
	<h3 class="text-center">
		<strong>장바구니</strong>
	</h3>

	<!--주문명세테이블  -->
	<table class="table border">
		<thead class="table-bordered th">
			<tr class="active">
				<th class="text-center"><input type="checkbox" id="chkall"></th>
				<th class="text-center">이미지</th>
				<th class="text-center">상품정보</th>
				<th class="text-center">판매가</th>
				<th class="text-center">수량</th>
				<th class="text-center">적립금</th>
				<th class="text-center">배송비</th>
				<th class="text-center">합계</th>
				<th class="text-center"></th>
			</tr>
		</thead>
		<tbody>
			<!-- 장바구니 리스트  비었는지 있는지 확인 -->

			<c:choose>
				<c:when test="${map.count == 0}">
					<td colspan="8" class="text-center h2"><strong>장바구니가
							비어있습니다.</strong></td>
					<tfoot>
						<tr class="bg-light">
							<td colspan="8" class="text-right">상품구매금액 <span> 0원</span> + 배송비 <span> 0원</span> = 합계 : <span>
									0원</span></td>
					</tfoot>
					<table class="table text-center ">
						<tr class="active">
							<td>총 상품금액</td>
							<td>총 배송비</td>
							<td>결제예정금액</td>
						</tr>
						<tr class="h4">
							<td>0원</td>
							<td>0원</td>
							<td class="text-primary"><strong>0원</strong></td>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<!-- 여기까지 장바구니 비었을때 출력 -->
					<!--장바구니 리스트 반복출력  -->
					<c:forEach items="${cartList}" var="cart">
						<c:set var="product_sum" value="${cart.product_count * cart.price }" />
						<!-- 천단위 구분 -->
						<fmt:formatNumber var="productSum" value="${map.productSum}" pattern="#,###.##" />
						<fmt:formatNumber var="total" value="${map.allSum}" pattern="#,###.##" />
						<fmt:formatNumber var="product_mil" value="${product_sum * 0.01}" pattern="#" />
						<fmt:formatNumber var="fee" value="${map.fee}" pattern="#,###.##" />
						<form name="form" id="form" method="get">
							<tr class="text-center">
								<td><input type="checkbox" class="chk" name="cart_idx" value="${cart.cart_idx}"></td>
								<input type="hidden" name="pcode" value="${cart.pcode}" />
								<td><img class="img-rounded" style="width: 100px; height: 100px;" src="img/${cart.filename}"></td>
								<td>${cart.pname}</td>
								<td><fmt:formatNumber value="${cart.price}" pattern="#,###.##" />원</td>
								<td><input type="number" class="text-right" name="product_count" id="product_count"size="2" min="1" max="99999" value="${cart.product_count}"></td>
								<td>${product_mil}원</td>
								<td>${fee}원</td>
								<td><fmt:formatNumber value="${product_sum}" pattern="#,###.##" />원</td>
								
							</tr>
							<c:set var="sum" value="${sum + product_sum}" />
					</c:forEach>
		</tbody>
		<tfoot>
			<tr class="bg-light">
				<td colspan="8" class="text-right">상품구매금액 <span> ${productSum}원 </span> + 배송비 <span> ${fee}원</span> = 합계 : <span> ${total} 원</span></td>
		</tfoot>
	</table>
	<!--  하단 버튼 -->
	<table class="table">
		<td>선택상품을 &nbsp;
			 <input type="submit" class="btn btn-outline-success btn-sm" id="selectdel" onclick="f_order()" value="삭제하기"/></td>
			 <td class="text-right">
			 <input type="submit" class="btn btn-outline-secondary btn-sm" id="modify" onclick="javascript: form.action='/modify/';" value="수정하기">
				</form>
			 <button type="button" id="btnAllDelete" class="btn btn-outline-success btn-sm text-right">장바구니 비우기</button>
		</td>
	</table>
	<!-- 총액 -->
	<table class="table text-center">
		<thead class="table-bordered th">
		<tr class="active">
			<th class="text-center">총 상품금액</th>
			<th class="text-center">총 배송비</th>
			<th class="text-center">결제예정금액</th>
		</tr>
		</thead>
		<tr class="h3">
			<td><c:out value="${productSum}" />원</td>
			<td>+ ${fee}원</td>
			<td class="text-primary"><strong>= ${total}원</strong></td>
		</tr>
	</table>
	</c:otherwise>
	</c:choose>
	<div class="text-center">
				<c:choose>
    					<c:when test="${map.count == 0}">
  							  </c:when>
   									 <c:otherwise>
      									<input type="button" class="btn btn-lg" id="btnOrder" value="주문" />&nbsp;&nbsp;&nbsp;
    								</c:otherwise>
						</c:choose>
		
		&nbsp;<input type="button" class="btn btn-lg" value="돌아가기"onclick="history.back()" />


		<div calss="pt-2">&nbsp;</div>
	</div>

</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>