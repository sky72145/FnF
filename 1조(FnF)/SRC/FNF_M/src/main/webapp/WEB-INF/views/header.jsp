<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>

<script src="js/jquery.min.js"></script>
<script>
		$(function(){
			/* $("#btnLogin").bind("click", function(){
				location.href = "login.jsp";
			}); */
			
			$("#btnSearch").bind("click", function() {
				if($("#searchAll").val() == "") {
					return false;
				}
				else location.href = "/searchAll";
			})
		});
</script>
<meta charset="UTF-8">
<title>Fishers N Farmers</title>

<!-- Font awesome -->
    <link href="/resources/css/font-awesome.css" rel="stylesheet">  
    <!-- Bootstrap -->
    <link href="/resources/css/bootstrap.css" rel="stylesheet">   
    <!-- SmartMenus jQuery Bootstrap Addon CSS -->
    <link href="/resources/css/jquery.smartmenus.bootstrap.css" rel="stylesheet">
    <!-- Product view slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/jquery.simpleLens.css">    
    <!-- slick slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/slick.css">
    <!-- price picker slider -->
    <link rel="stylesheet" type="text/css" href="/resources/css/nouislider.css">
    <!-- Theme color -->
    <link id="switcher" href="/resources/css/theme.css" rel="stylesheet">
    <!-- Top Slider CSS -->
    <link href="/resources/css/slide.css" rel="stylesheet" media="all">

    <!-- Main style sheet -->
    <link href="/resources/css/style2.css" rel="stylesheet">    
    <link href="css/custom.css" rel="stylesheet" type="text/css">

    <!-- Google Font -->
    <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'> 
  

</head>
<body>

<header id="aa-header">
    <!-- start header top  -->
    <div class="aa-header-top">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="aa-header-top-area">
              <!-- start header top left -->
              <div class="aa-header-top-left">
              </div>

              <!-- 상단바  -->
              <div class="aa-header-top-right">
                <ul class="aa-head-top-nav-right">
                <sec:authorize access="isAuthenticated()">
                <li><a href="/logout">로그아웃</a></li>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                 <li><a href='/admin'>관리자
											페이지</a></li>
				</sec:authorize>
				 <sec:authorize access="hasRole('ROLE_SELLER')">
                 <li><a href='/sellerMain'>판매자페이지</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_USER')">
                 <li><a href='/myorder?user_id=<sec:authentication property="principal.username"/>'>마이
											페이지</a></li>
				 <li><a href="/cart">장바구니</a></li>
				</sec:authorize>
                </sec:authorize>
                  <sec:authorize access="isAnonymous()">
                  <li><a href="/login">로그인</a></li>
                   <li class="hidden-xs"><a href="/signupmain">회원가입</a></li>
                  </sec:authorize>  
                  <li class="hidden-xs"><a href="/cs">고객센터</a></li>
                  <!-- <li><a href="#" data-toggle="modal" data-target="#login-modal">마이페이지</a></li>
                  <li><a href="#" data-toggle="modal" data-target="#login-modal">장바구니</a></li> -->
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 로그인 확인창 -->  
<!--   <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">                      
        <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4>로그인이 필요한 서비스입니다.<br/>로그인 하시겠습니까?</h4>
          <button class="aa-browse-btn" type="submit"  id="btnLogin">로그인</button>
          <button class="aa-browse-btn" type="button" data-dismiss="modal" aria-hidden="true">취소</button>
          <form class="aa-login-form" action="">
            <div class="aa-register-now">
              <a href="signup1.jsp">회원가입 하러가기</a>
            </div>
          </form>
        </div>                        
      </div>
    </div>
  </div>   -->


<!-- 로고 -->
  <div class="aa-logo">
    <a href="/"><img src="img/logo2.png" alt="logo img"></a>
  </div>


  <div class="aa-header-bottom">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="aa-header-bottom-area">
        
              <!-- 검색 창 -->
                <div class="aa-search-box">
                  <form action="/searchAll" method="get" >
                    <input type="text" name="keyword" id="keyword" placeholder="상품 또는 판매자 검색">
                    <button type="submit" id="btnSearch"><span class="fa fa-search"></span></button>
                  </form>
                </div>

              </div>
            </div>
        </div>
      </div>
    </div>

  <!-- 메뉴 -->
  </header>
  <section id="menu">
		<div class="container">
			<div class="menu-area">
				<!-- Navbar -->
				<div class="navbar navbar-default" role="navigation">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span>
						</button>
					</div>
					<div class="navbar-collapse collapse">
						<!-- Left nav -->
						<ul class="nav navbar-nav">
							<li><a href='/products?category=농산물&pageNum=1&amount=9'>농산물<span
									class="caret" /></a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=채소&pageNum=1&amount=9'>채소</a></li>
									<li><a href='/products2?category2=과일&pageNum=1&amount=9'>과일</a></li>
									<li><a href='/products2?category2=쌀,잡곡류&pageNum=1&amount=9'>쌀,잡곡류</a></li>
									<li><a href='/products2?category2=견과류&pageNum=1&amount=9'>견과류</a></li>
								</ul></li>
							<li><a href='/products?category=수산물&pageNum=1&amount=9'>수산물<span
									class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=생선&pageNum=1&amount=9'>생선</a></li>
									<li><a href='/products2?category2=갑각류&pageNum=1&amount=9'>갑각류</a></li>
									<li><a href='/products2?category2=해조류&pageNum=1&amount=9'>해조류</a></li>
									<li><a href='/products2?category2=건어물&pageNum=1&amount=9'>건어물</a></li>
								</ul></li>
							<li><a href='/products?category=가공식품&pageNum=1&amount=9'>가공식품<span
									class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=즙류&pageNum=1&amount=9'>즙류</a></li>
									<li><a href='/products2?category2=분말류&pageNum=1&amount=9'>분말류</a></li>
									<li><a href='/products2?category2=잼류&pageNum=1&amount=9'>잼류</a></li>
								</ul></li>
							<li><a href='/productc?pageNum=1&amount=9'>추천상품<span class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/productc2?category=농산물&pageNum=1&amount=9'>농산물</a></li>
									<li><a href='/productc2?category=수산물&pageNum=1&amount=9'>수산물</a></li>
									<li><a href='/productc2?category=가공식품&pageNum=1&amount=9'>가공식품</a></li>
								</ul></li>
							<li><a href='/productf?pageNum=1&amount=9'>인기상품 <span class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/productf2?category=농산물&pageNum=1&amount=9'>농산물</a></li>
									<li><a href='/productf2?category=수산물&pageNum=1&amount=9'>수산물</a></li>
									<li><a href='/productf2?category=가공식품&pageNum=1&amount=9'>가공식품</a></li>
								</ul></li>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
	</section>

  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="/resources/js/bootstrap.js"></script>  
  <!-- SmartMenus jQuery plugin -->
  <script type="text/javascript" src="/resources/js/jquery.smartmenus.js"></script>
  <!-- SmartMenus jQuery Bootstrap Addon -->
  <script type="text/javascript" src="/resources/js/jquery.smartmenus.bootstrap.js"></script>  
  <!-- To Slider JS -->
  <script src="/resources/js/sequence.js"></script>
  <script src="/resources/js/slide.js"></script>  
  <!-- Product view slider -->
  <script type="text/javascript" src="/resources/js/jquery.simpleGallery.js"></script>
  <script type="text/javascript" src="/resources/js/jquery.simpleLens.js"></script>
  <!-- slick slider -->
  <script type="text/javascript" src="/resources/js/slick.js"></script>
  <!-- Price picker slider -->
  <script type="text/javascript" src="/resources/js/nouislider.js"></script>
  <!-- Custom js -->
  <script src="/resources/js/custom.js"></script>

</body>
</html>