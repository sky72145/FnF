<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피셔스 앤 파머스</title>
<!-- Font awesome -->
<link href="/resources/css/font-awesome.css" rel="stylesheet">
<!-- Bootstrap -->
<link href="/resources/css/bootstrap.css" rel="stylesheet">
<!-- SmartMenus jQuery Bootstrap Addon CSS -->
<link href="/resources/css/jquery.smartmenus.bootstrap.css"
	rel="stylesheet">
<!-- Product view slider -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/jquery.simpleLens.css">
<!-- slick slider -->
<link rel="stylesheet" type="text/css" href="/resources/css/slick.css">
<!-- price picker slider -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/nouislider.css">
<!-- Theme color -->
<link id="switcher" href="/resources/css/theme-color/default-theme.css"
	rel="stylesheet">
<!-- <link id="switcher" href="css/theme-color/bridge-theme.css" rel="stylesheet"> -->
<!-- Top Slider CSS -->
<link href="/resources/css/sequence-theme.modern-slide-in.css"
	rel="stylesheet" media="all">
<!-- Main style sheet -->
<link href="/resources/css/style1.css" rel="stylesheet">
<link href="/resources/css/style2.css" rel="stylesheet">
<!-- Google Font -->
<link href='https://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway'
	rel='stylesheet' type='text/css'>
 <link href="/resources/css/sidebar.css" rel="stylesheet">
<link href="/resources/css/fix.css" rel="stylesheet"> 

</head>
<body>
<!-- ---------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->
<jsp:include page="header.jsp"></jsp:include>
<!-- ------------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------- -->

<section id="aa-catg-head-banner">
	<img src="/static/img/productlist/상품.png" alt="farm" 
		style="margin-left: auto; margin-right: auto; display: block;">
	<div class="aa-catg-head-banner-area">
		<div class="container">
			<div class="aa-catg-head-banner-content">
				<h2>추천상품</h2>
				<br/>
					<p style="color:white;">농산물/수산물/가공식품<p>
			</div>
		</div>
	</div>
</section>
<!-- product category -->
<section id="aa-product-category">
	<div class="container">
		<div class="row">
			<div class="col-lg-9 col-md-9 col-sm-8 col-md-push-3">
				<div class="aa-product-catg-content">
					<div class="aa-product-catg-body">
						<ul class="aa-product-catg">
							<!-- start single product item -->
							<c:forEach items="${productc2 }" var="product">
								<li>
									<figure>
										<a class="aa-product-img" href='/PD/<c:out value="${product.idx}"/>'><img
											src='/static/img/<c:out value="${product.filename}"/>'
											alt="afasgaw"></a>
										<figcaption>
											<h4 class="aa-product-title">
												<a href='/PD/<c:out value="${product.idx}"/>'><c:out value="${product.pname}" /></a>
											</h4>
											<span class="aa-product-price"><c:out
													value="${product.price}" /></span>
										</figcaption>
									</figure>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="aa-product-catg-pagination">
						<nav>
						 	<ul class="pagination">
								<c:if test="${pageMaker3.prev}">
									<li class="paginate_button previous"><a
										href='/productc2?category=<c:out value="${pageMaker3.cri.category}" />&pageNum=${pageMaker3.startPage -1}&amount=9'>Previous</a></li>
								</c:if>

								<c:forEach var="num" begin="${pageMaker3.startPage}"
									end="${pageMaker3.endPage}">
									<li class="paginate_button  ${pageMaker3.cri.pageNum == num ? "active":""} ">
										<a href='/productc2?category=<c:out value="${pageMaker3.cri.category}" />&pageNum=${num}&amount=9'>${num}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker3.next}">
									<li class="paginate_button next"><a
										href='/productc2?category=<c:out value="${pageMaker3.cri.category}" />&pageNum=${pageMaker3.endPage +1 }&amount=9'>Next</a></li>	
								</c:if>
							</ul>  
						</nav>
					</div>
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-4 col-md-pull-9">
				<aside class="aa-sidebar">
					<!-- single sidebar -->
					<div class="aa-sidebar-widget">
						<h3>Category</h3>
						<ul class="aa-catg-nav">
							<li><a href='/products?category=농산물'>농산물</a></li>
							<li><a href='/products?category=수산물'>수산물</a></li>
							<li><a href='/products?category=가공식품'>가공식품</a></li>
							<li><a href='/productc'>추천상품</a></li>
							<li><a href='/productf'>인기상품</a></li>
						</ul>
					</div>
					<!-- single sidebar -->
					<div class="aa-sidebar-widget">
						<h3>Tags</h3>
						<div class="tag-cloud">
							<a href='/products2?category2=채소'>채소</a> <a
								href='/products2?category2=과일'>과일</a> <a
								href='/products2?category2=쌀,잡곡류'>쌀,잡곡류</a> <a
								href='/products2?category2=견과류'>견과류</a> <a
								href='/products2?category2=생선'>생선</a> <a
								href='/products2?category2=갑각류'>갑각류</a> <a
								href='/products2?category2=해조류'>해조류</a> <a
								href='/products2?category2=건어물'>건어물</a> <a
								href='/products2?category2=즙류'>즙류</a> <a
								href='/products2?category2=분말류'>분말류</a> <a
								href='/products2?category2=잼류'>잼류</a>
						</div>
					</div>
					<!-- single sidebar -->
					<div class="aa-sidebar-widget">
						<h3>Recently Views</h3>
						<div class="aa-recently-views">
								<ul>
									<c:if test="${cookie.idx.value ne null}">
										<li><a href='/PD/${cookie.idx.value}'
											class="aa-cartbox-img"><img alt="img"
												src="/static/img/${cookie.filename.value}"></a>
											<div class="aa-cartbox-info">
												<h4>
													<a href='/PD/${cookie.idx.value}'>${cookie.pname.value}</a>
												</h4>
												<p>${cookie.price.value}</p>
											</div>
										</li>
									</c:if>
									<c:if test="${cookie.idx1.value ne null}">
										<li><a href='/PD/${cookie.idx1.value}'
											class="aa-cartbox-img"><img alt="img"
												src="/static/img/${cookie.filename1.value}"></a>
											<div class="aa-cartbox-info">
												<h4>
													<a href='/PD/${cookie.idx1.value}'>${cookie.pname1.value}</a>
												</h4>
												<p>${cookie.price1.value}</p>
											</div>
										</li>
									</c:if>
									<c:if test="${cookie.idx2.value ne null}">
										<li><a href='/PD/${cookie.idx2.value}'
											class="aa-cartbox-img"><img alt="img"
												src="/static/img/${cookie.filename2.value}"></a>
											<div class="aa-cartbox-info">
												<h4>
													<a href='/PD/${cookie.idx2.value}'>${cookie.pname2.value}</a>
												</h4>
												<p>${cookie.price2.value}</p>
											</div>
										</li>
									</c:if>
								</ul>
						</div>
					</div>
				</aside>
			</div>
		</div>
	</div>
</section>
<!-- footer -->  
  <jsp:include page="footer.jsp"></jsp:include>
 <!-- / footer -->
 <!-- ------------------------------------------------------- -->
  <script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="/resources/js/bootstrap.js"></script>
<!-- SmartMenus jQuery plugin -->
<script type="text/javascript" src="/resources/js/jquery.smartmenus.js"></script>
<!-- SmartMenus jQuery Bootstrap Addon -->
<script type="text/javascript" src="/resources/js/jquery.smartmenus.bootstrap.js"></script>
<!-- To Slider JS -->
<script src="/resources/js/sequence.js"></script>
<script src="/resources/js/sequence-theme.modern-slide-in.js"></script>
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
