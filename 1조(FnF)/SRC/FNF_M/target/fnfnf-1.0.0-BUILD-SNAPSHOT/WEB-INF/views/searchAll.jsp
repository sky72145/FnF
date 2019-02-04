<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header.jsp"%>
<section id="aa-catg-head-banner">
	<img src="/resources/img/slider/farm.jpg" alt="farm" height="300"
		width="823"
		style="margin-left: auto; margin-right: auto; display: block;">
	<div class="aa-catg-head-banner-area">
		<div class="container">
			<div class="aa-catg-head-banner-content">
				<h2>상품목록</h2>
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
							<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${map.count}개의 상품이 검색되었습니다.</h4>
							<br /><br />
							<c:forEach items="${map.list}" var="row">
								<li>
									<figure>
										<a class="aa-product-img" href="#"><img
											src='/resources/img/<c:out value="${row.filename}"/>'></a>
										<figcaption>
											<h4 class="aa-product-title">
												<a href="#"><c:out value="${row.pname}" /></a>
											</h4>
											<span class="aa-product-price"><c:out
													value="${row.price}" /></span>
										</figcaption>
									</figure>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="aa-product-catg-pagination">
						<nav>
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
									<li class="paginate_button previous"><a
										href='/product/products?category=<c:out value="${pageMaker.cri.category}" />&pageNum=${pageMaker.startPage -1}&amount=9'>Previous</a></li>
								</c:if>

								<c:forEach var="num" begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}">
									<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
										<a href='/product/products?category=<c:out value="${pageMaker.cri.category}" />&pageNum=${num}&amount=9'>${num}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next}">
									<li class="paginate_button next"><a
										href='/product/products?category=<c:out value="${pageMaker.cri.category}" />&pageNum=${pageMaker.endPage +1 }&amount=9'>Next</a></li>	
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
							<li><a href='/product/products?category=농산물'>농산물</a></li>
							<li><a href='/product/products?category=수산물'>수산물</a></li>
							<li><a href='/product/products?category=가공식품'>가공식품</a></li>
							<li><a href='/product/productc'>추천상품</a></li>
							<li><a href='/product/productf'>인기상품</a></li>
						</ul>
					</div>
					<!-- single sidebar -->
					<div class="aa-sidebar-widget">
						<h3>Tags</h3>
						<div class="tag-cloud">
							<a href='/product/products2?category2=채소'>채소</a> <a
								href='/product/products2?category2=과일'>과일</a> <a
								href='/product/products2?category2=쌀,잡곡류'>쌀·잡곡류</a> <a
								href='/product/products2?category2=견과류'>견과류</a> <a
								href='/product/products2?category2=생선'>생선</a> <a
								href='/product/products2?category2=갑각류'>갑각류</a> <a
								href='/product/products2?category2=해조류'>해조류</a> <a
								href='/product/products2?category2=건어물'>건어물</a> <a
								href='/product/products2?category2=즙류'>즙류</a> <a
								href='/product/products2?category2=분말류'>분말류</a> <a
								href='/product/products2?category2=잼류'>잼류</a>
						</div>
					</div>
					<!-- single sidebar -->
					<div class="aa-sidebar-widget">
						<h3>Top Rated Products</h3>
						<div class="aa-recently-views">
							<ul>
								<c:forEach items="${productsf }" var="productf" begin="0" end="2">
									<li><a href="#" class="aa-cartbox-img"><img alt="img"
											src="/resources/img/${productf.filename}"></a>
										<div class="aa-cartbox-info">
											<h4>
												<a href="#"><c:out value="${productf.pname}" /></a>
											</h4>
											<p>
												<c:out value="${productf.price}" />
											</p>
										</div></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</aside>
			</div>
		</div>
	</div>
</section>

<%@include file="footer.jsp"%>
<!-- / product category -->
