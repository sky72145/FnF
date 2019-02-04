<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="qaa" value="${data}" />
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

	#attached, #image{
		margin:30px 0 30px 0x; 
		border-color:#d2d2d2;
		height:120px;
	}
	
	.writer{
		margin:0 0 0 -30px; padding:0;
	}
	
	.writerbtn{
		width : 250px; 
		height : 40px;
		margin:30px 0 80px 0; 
		text-align:center;
	}
	
	#qaatitle{
		text-align:center;
		margin:80px 0 50px 0; 
	}
</style>

<script src="../../../js/jquery.min.js"></script>
  <script>
  var idx = null;
  $(document).ready(function() {
 	idx = ${qaa.idx};
 	$("#txtIdx").val("${qaa.idx}");
 	$("#user_id").val("${qaa.user_id}");
 	$("#btnCancel").bind("click", function() {
 		history.back();
 	});
 	$("#btnUpdate").bind("click", function(){
 		var formData = new FormData($("#myform")[0]);
 		$.ajax({
			url : "/qaa/update/" + idx,
			dataType : "json",
			type : "POST",
			processData : false,    //아주 중요
			contentType : false,
			data : formData,
			success : function(data) {
				if (data.code) {
					alert("수정이 완료되었습니다.");
					location.href = "/qaa";
				} else {
					alert("수정에 실패하였습니다. 다시 수정해 주세요.");
				}
			},
			error : function(err) {
				console.log("Error 발생 : " + err);
			}
		});
 	});
 	//alert("${qaa.status}");
	  var dbstatus = parseInt(${qaa.status});
	  
	  if(dbstatus == 0){
		  $("#visible").attr("checked",true);
	  }else{
		  $("#unvisible").attr("checked",true);
	  }
 	
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
<h1 id="qaatitle" ><strong>문의하기</strong></h1>
<form name="myform" id="myform">

	<div class="col-sm-offset-1 col-md-9">
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_title">제목</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<input class="form-control " id="user_id" name="user_id" placeholder="작성자" type="text" value="${qaa.user_id}" readonly>
		</div>
	</div>
	
	<br /><br />
	
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_title">제목</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<input class="form-control " id="txtTitle" name="title" type="text" value="${qaa.title}" autofocus required>
		</div>
	</div>
	
	<br /><br />
	
	<div class="form-group writer">
		<!-- <label class="control-label col-sm-offset-1 col-sm-1 title" for="bda_content">내용</label> -->
		<div class="col-md-offset-2 col-sm-10">
			<textarea class="form-control" id="txtContents" name="contents" rows="20" required style="resize: none;">${qaa.contents}</textarea>
		</div>
	</div>
	 
	 <br /> <br /><br />
	<div class="form-group writer">	
		<div class="col-sm-offset-2 col-md-9">
			<table border="1"  style="color: d2d2d2;" id="attached">
				<tbody class="">
					<tr>
						<th scope="row">
							<span class="attached_file">첨부파일      </span>
						</th>
						<td><input name="file1" id="file1" type="file" value=""></td><!-- 수정 -->
						<input type="hidden" name="filename" value="${qaa.filename}"><!-- 원본 -->
						<td rowspan="3">
							<c:if test="${qaa.filename != null}" >
								<img src="../../../img/${qaa.filename}" width="210px" height="120px"/>
								<input type="hidden" name="file1" id="file1" value="${qaa.filename}" />
							</c:if>
						</td>
					</tr>
						<tr>
							<th scope="row">
								<span class="attached_file">비밀번호      </span>
							</th>
				            <td><input id="password" name="password" type="password" value="${qaa.password}"></td>
			            </tr>
		            
					<tr class="displaynone">
                  		<th scope="row">
                    		<span class="attached_file">비밀글설정 &nbsp;&nbsp;&nbsp;</span>
                 		</th>
                  		<td>
	                  			<input id="visible" name="status" value="0" type="radio" ><label for="secure0" >공개글</label>
	                       		<input id="unvisible" name="status" value="1" type="radio" ><label for="secure1" >비밀글</label>
                       		
                       	</td>
              		</tr>
				</tbody>
					
					
			</table>
			</div>
		</div>
	</div>

	<br /><br />
	
	<div class="col-sm-offset-3 col-md-9">
	  <button type="button" class="btn btn-success writerbtn" id ="btnUpdate">수정하기</button> &nbsp;
	  <button type="button" class="btn btn-info writerbtn" id = "btnBack" onclick="location.href='/qaa'">돌아가기</button> 
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