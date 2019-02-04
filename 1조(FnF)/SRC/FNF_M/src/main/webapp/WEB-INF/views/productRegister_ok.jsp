<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	if((${status}) == 1){
		alert("상품이 등록 되었습니다.");
		location.href="/sellerPL";
	}else if((${status}) == 2){
		alert("상품이 수정 되었습니다.");
		location.href="/sellerPL";
	}else if((${status}) == 3){
		alert("상품수정을 실패했습니다.");
		location.href="/sellerPL";
	}
	else{
		alert("상품등록을 실패했습니다.");
		location.href="/sellerPR";
	}
</script>