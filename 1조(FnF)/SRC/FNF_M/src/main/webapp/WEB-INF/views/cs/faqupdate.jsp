<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="faq" value="${data}" />
<c:set var="currentPage" value="${page}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>Fishers N Farmers</title>
    
    <!-- Bootstrap -->
    <link href="../../../css/bootstrap.css" rel="stylesheet">   
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="../../../css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="../../../css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="../../../css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="../../../css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="../../../css/theme.css" rel="stylesheet">
    <!-- Top Slider CSS -->
    <link href="../../../css/slide.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="../../../css/style2.css" rel="stylesheet">    


  
  
  <style type="text/css">


 	.title{
		text-align:center;
		text-size:20px;
	} 

	#attached{
		margin:30px 0 30px 0; 
		border-color:#d2d2d2;
		height:120px;
	}
	
	.writer{
		margin:0 0 0 -30px; padding:0;
	}
	
	.writerbtn{
		width : 250px; 
		height : 40px;
		margin:20px 0 80px 0; 
		text-align:center;
	}
	
	#faqtitle{
		text-align:center;
		margin:80px 0 50px 0; 
	}
</style>

<script src="../../../js/jquery.min.js"></script>
  <script>
  var idx = null;
  $(document).ready(function() {
  	idx = ${faq.idx};
  	$("#txtIdx").val("${faq.idx}");
  	$("#user_id").val("${faq.user_id}");
  	$("#btnCancel").bind("click", function() {
  		history.back();
  	});
  
  
  	$("#btnUpdate").bind("click", function(){
 		var formData = new FormData($("#myform")[0]);
 		$.ajax({
			url : "/faq/update/" + idx,
			dataType : "json",
			type : "POST",
			processData : false,    //아주 중요
			contentType : false,
			data : formData,
			success : function(data) {
				if (data.code) {
					alert("수정이 완료되었습니다.");
					location.href = "/faq";
				} else {
					alert("Update Failure");
				}
			},
			error : function(err) {
				console.log("Error 발생 : " + err);
			}
		});
	});
  });
</script>
 </head>
<body>
<!-- -------------------------------Header---------------------------------- -->
 <jsp:include page="../header4.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->

<div class="container">
<div class="col-md-12">
<div class="row">
<h1 id="faqtitle" ><strong>문의하기</strong></h1>
<form name="myform" id="myform">
	<div class="col-sm-offset-1 col-md-9">
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_title">제목</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<input class="form-control " id="user_id" name="user_id" placeholder="작성자" type="text" value="${faq.user_id}" readonly>
		</div>
	</div>
	
	<br /><br />
	
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_title">제목</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<input class="form-control " id="title" name="title" type="text" value="${faq.title}" autofocus required>
		</div>
	</div>
	
	<br /><br />
	
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_content">내용</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<textarea class="form-control" id="contents" name="contents" rows="20" required style="resize: none;">${faq.contents}</textarea>
		</div>
	</div>
	 
	<div class="form-group writer">	
		<div class="col-sm-offset-2 col-md-9">
			<table border="1"  style="color: d2d2d2;" id="attached">
				<tbody class="">
					<tr>
						<th scope="row">
							<span class="attached_file">첨부파일      </span>
						</th>
						<td><input name="filename" type="file"></td>
						<td rowspan="3">
							<img src="../../../img/fileupload/${faq.filename}" width="210px" height="120px"/>
							<input type="hidden" name="file1" id="file1" value="${faq.filename}" />
						</td>
					</tr>
						<tr>
							<th scope="row">
								<span class="attached_file">비밀번호      </span>
							</th>
				            <td><input id="password" name="password" type="password"></td>
			            </tr>
		            
					<tr class="displaynone">
						<th scope="row">
							<span class="attached_file">비밀글&nbsp;&nbsp;&nbsp;</span>
						</th>
						<td><input id="visible" name="secure" value="F" type="radio" checked="checked" disabled=""><label for="secure0">공개글</label>
							<input id="nvisible" name="secure" value="T" type="radio"><label for="secure1">비밀글</label></td>
					</tr>
					
				</tbody>
			</table>
			
		</div>
	</div>

	<br /><br />
	
	<div class="col-sm-offset-3 col-md-9">
	 <button type="button" class="btn btn-success writerbtn" id ="btnUpdate">수정하기</button> &nbsp;
	 <button type="button" class="btn btn-info writerbtn" id = "btnBack" onclick="location.href='faq' ">돌아가기</button> 
	 </div> 
	 </div>
	 </form> 
</div>

</div>
</div>


	

 

<!-- -------------------------------Footer---------------------------------- -->
<jsp:include page="../footer.jsp"></jsp:include>
<!-- ----------------------------------------------------------------------- -->

  </body>
</html>