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