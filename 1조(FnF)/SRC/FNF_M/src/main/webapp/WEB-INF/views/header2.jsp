<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				else location.href = "searchAll";
			})
		});
</script>
<meta charset="UTF-8">
<title>Fishers N Farmers</title>
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
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


<!-- 로고 -->
  <div class="aa-logo">
    <a href="/"><img src="../img/logo2.png" alt="logo img"></a>
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
							<li><a href='/products?category=농산물'>농산물<span
									class="caret" /></a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=채소'>채소</a></li>
									<li><a href='/products2?category2=과일'>과일</a></li>
									<li><a href='/products2?category2=쌀,잡곡류'>쌀,잡곡류</a></li>
									<li><a href='/products2?category2=견과류'>견과류</a></li>
								</ul></li>
							<li><a href='/products?category=수산물'>수산물<span
									class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=생선'>생선</a></li>
									<li><a href='/products2?category2=갑각류'>갑각류</a></li>
									<li><a href='/products2?category2=해조류'>해조류</a></li>
									<li><a href='/products2?category2=건어물'>건어물</a></li>
								</ul></li>
							<li><a href='/products?category=가공식품'>가공식품<span
									class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/products2?category2=즙류'>즙류</a></li>
									<li><a href='/products2?category2=분말류'>분말류</a></li>
									<li><a href='/products2?category2=잼류'>잼류</a></li>
								</ul></li>
							<li><a href='/productc'>추천상품<span class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/productc2?category=농산물'>농산물</a></li>
									<li><a href='/productc2?category=수산물'>수산물</a></li>
									<li><a href='/productc2?category=가공식품'>가공식품</a></li>
								</ul></li>
							<li><a href='/productf'>인기상품 <span class="caret" />
							</a>
								<ul class="dropdown-menu">
									<li><a href='/productf2?category=농산물'>농산물</a></li>
									<li><a href='/productf2?category=수산물'>수산물</a></li>
									<li><a href='/productf2?category=가공식품'>가공식품</a></li>
								</ul></li>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
	</section>
</body>
</html>