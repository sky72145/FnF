IMP.init('imp74949970');
$(document).ready(function(){	
	$("#bank").show();
	$("#kpay2").hide();
	$.ajax({
		url : "/order",
		dataType : "json",
		method : "POST",
		success : function(data){
			
			var result = data.data;
			var fee = data.fee;
			var productsum = data.productSum;
			var allsum = data.allSum;
			var pcode = data.pcode;
			var mile = data.mile_remain
			var str = "";
			for(var i = 0 ; i < result.length ; i++){
				str += "<tr class='text-center'>"
				str += "<td><img class='img-rounded' style='width: 100px; height: 100px;' src='/static/img/"+ result[i].filename+"'></td>" + 
							"<td class='text-center' id='pname'>"+ result[i].pname +"</td><td class='text-center' id='price'>"+ addComma(result[i].price)+ "원"+"</td>" +
				             "<td class='text-center' id='product_count'>" + result[i].product_count + "개"+"</td><td class='text-center' id='mile_give'>" + addComma(Math.ceil((result[i].product_count * result[i].price)*0.01)) + "원"+"</td>" +
				             "<td class='text-center' id='del_price'>" + addComma(fee) + "원"+"</td>" + "<td class='text-center'>" + addComma(result[i].product_count * result[i].price) + "원"+"</td>";
				str += "</tr>";
			}
				str+=	"<tr class='bg-light'>";
				str+=	"<td colspan='8' class='text-right'>상품구매금액 : " +addComma(productsum) +"원" + "+" + "배송비 :"+addComma(fee) +"원  =  합계 :" +addComma(allsum) +"원</td></tr>"
				
			$("#records").html(str);
			$("#psum").html(addComma(productsum)+"원");
			$("#fee").html(fee);
			$("#totalprice").html(allsum);
			$("#fee2").html(addComma(fee)+"원");
			$("#totalprice2").html(addComma(allsum)+"원");
			$("#mile").html(mile);
			
			
		},
		error : function(err){
			console.log("Error 발생 : " + err);
		}
	});
	 if($.trim($("#mile_used").val())==''){
		 
	}
});
function addr() {
	window.open("/user_address", "User_addr", "width=960, height=350, left=900, top=30","scrollbars=no");
}


function addComma(num) {
	  var regexp = /\B(?=(\d{3})+(?!\d))/g;
	  return num.toString().replace(regexp, ',');
	}

function f_save(){
	var frm = document.getElementById('frm');
	
	if($("#receiver_name").val() ==""){
		alert("받는분 이름을 작성해주세요");
		$("#receiver_name").focus();
		return;
	}
	if($("#zipcode").val() ==""){
		alert("우편번호를 입력해주세요.");
		$("#zipcode").focus();
		return ;
	}
	if($("#address1").val() ==""){
		alert("기본 주소를 입력해주세요.");
		$("#address1").focus();
		return;
	}
	if($("#address2").val() ==""){
		alert("나머지 주소를 입력해주세요.");
		$("#address2").focus();
		return;
	}
	if($("#phone").val() ==""){
		alert("휴대전화번호를 입력해주세요.");
		$("#phone").focus();
		return;
	}
	if($("#email").val() ==""){
		alert("이메일을  입력해주세요.");
		$("#email").focus();
		return;
	}
	if($("input:radio[name='pay']").is(":checked") == true){
	}else{
		alert('결제수단 을 체크해주세요.');
		$('#pay').focus();
		return false;
	}
	 if($("#agree_chk").is(":checked") == false){
         alert("약관에 동의 하셔야 다음 단계로 진행 가능합니다.");
         return false;
     }
	 /* 마일리지 유효성 체크 */
	var mile = parseInt($("#mile").text())
	var total = parseInt($("#totalprice").text())
	 if($("#mile_used").val() < 1000 && $("#mile_used").val() >= 1){
		 alert("최소사용금액은 1000원 입니다.");
		 return false;
	 }
	 if($("#mile_used").val() >  mile){
		 alert("보유한 적립금보다 높은 금액입니다.");
		 $("#mile_used").focus();
		 return false;
	 }
	  if($("#mile_used").val() > total){
		alert("최종결제 금액보다 높은 마일리지 금액 입니다");
		 $("#mile_used").focus();
		return false;
	 }
	if($("input:radio[id='kpay']").is(":checked") == true){
		   IMP.request_pay({
			    pg : 'kakaopay', // version 1.1.0부터 지원.
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : $("#pname").text(),
			    amount : $("#totalprice").text()-$("#mile_used").val(),
			    buyer_email : $("#email").val(),
			    buyer_name : $("#receiver_name").val(),
			    buyer_tel : $("#phone").val(),
			    buyer_addr : $("#address1").val() + $("#address2").val(),
			    buyer_postcode : $("#zipcode").val(),
			}, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        alert("카카오페이 결제 완료");
			        
			        frm.submit();
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			        alert(msg);
			    }
			});
		   
	   }else{
		   frm.submit();
	   }
}

function contentsView(objVlaue) {
    if (objVlaue.value == '무통장') {
    	$("#bank").show();
    	$("#kpay2").hide();
    }else{
    
    	$("#kpay2").show();
    	$("#bank").hide();
    }
}

$(function(){

    $("#phone").on('keydown', function(e){
       // 숫자만 입력받기
        var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;
				
	if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
	{
  	    e.preventDefault();
	}
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;

        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = $(this).val().replace(/-/gi,'');
      
        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10) 
            {   
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                {
                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                    //trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                    $(this).val(trans_num);
                }
                else
                {
                    alert("유효하지 않은 전화번호 입니다.");
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
                alert("유효하지 않은 전화번호 입니다.");
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});

/* 다음 우편번호 */
function dzip() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddr = ''; 
            var extraAddr = '';

            if (data.userSelectedType === 'R') { 
                fullAddr = data.roadAddress;
            } else { 
                fullAddr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
               
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }
            document.getElementById('zipcode').value = data.zonecode; 
            document.getElementById('address1').value = fullAddr;

            document.getElementById('address2').focus();
        }
    }).open();
}
