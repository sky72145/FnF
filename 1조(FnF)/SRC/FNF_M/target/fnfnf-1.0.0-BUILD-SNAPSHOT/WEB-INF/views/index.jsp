<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">    
    <title>Fishers N Farmers</title>
  </head>
  <body>
  
  <jsp:include page="header.jsp"></jsp:include>


  <!-- 슬라이드 사진  -->
  <section id="aa-slider">
    <div class="aa-slider-area">
      <div id="sequence" class="seq">
        <div class="seq-screen">
          <ul class="seq-canvas">
            <c:forEach var="i" begin="1" end="4" >
            <li>
              <div class="seq-model">
                <img data-seq src="/resources/img/slider/s${i}.jpg" >
              </div>
            </li>
            </c:forEach>                 
          </ul>
        </div>
        <fieldset class="seq-nav" aria-controls="sequence" aria-label="Slider buttons">
          <a type="button" class="seq-prev" aria-label="Previous"><span class="fa fa-angle-left"></span></a>
          <a type="button" class="seq-next" aria-label="Next"><span class="fa fa-angle-right"></span></a> 
        </fieldset>
      </div>
    </div>
  </section>


  <!-- 인기상품(MD's Pick) -->
  <section id="aa-promo">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="aa-promo-area">
            <div class="row">
            	<h3><a href="#">MD's Pick</a></h3>
            	
              <!-- 왼쪽 -->
              <div class="col-md-5 no-padding">                
                <div class="aa-promo-left">
                  <div class="aa-promo-banner">
                  <c:forEach items="${mdlist}" var="row" varStatus="st">
                  <c:if test="${st.count == 1}">                    
                    <img src="img/${row.filename}" alt="img">                    
                    <div class="aa-prom-content">
                      <!-- <span>75% Off</span> -->
                      <h4><a href="#">${row.pname}</a></h4>                      
                    </div>
                    </c:if>
                    </c:forEach>
                  </div>
                </div>
              </div>
              
              <!-- 오른쪽 -->
              <div class="col-md-7 no-padding">
                <div class="aa-promo-right">
                <c:forEach items="${mdlist}" var="row" varStatus="st">
                    <c:if test="${st.count > 1 && st.count < 6}"> 
                  <div class="aa-single-promo-right">
                    <div class="aa-promo-banner">            
                      <img src="img/${row.filename}" alt="img">                      
                      <div class="aa-prom-content">
                        <!-- <span>Exclusive Item</span> -->
                        <h4><a href="#">${row.pname}</a></h4>                        
                      </div>
                    </div>
                  </div>
                  </c:if>
                   </c:forEach>
        	</div>
        	</div>
        </div>
      </div>
    </div>
  </section>
<!-- /인기상품-->

  <!-- 메뉴 별 최근게시물  -->
  <section id="aa-product">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="aa-product-area">
              <div class="aa-product-inner">
                 <ul class="nav nav-tabs aa-products-tab">
                    <li class="active"><a href="#men" data-toggle="tab">농산물</a></li>
                    <li><a href="#women" data-toggle="tab">수산물</a></li>
                    <li><a href="#electronics" data-toggle="tab">가공식품</a></li>
                  </ul>
                  <div class="tab-content">

                    <!-- 농산물 -->
                    <div class="tab-pane fade in active" id="men">
                      <ul class="aa-product-catg">
                        <c:forEach items="${nlist}" var="row" varStatus="st">
                        <c:if test="${st.count <= 8}">
                        <li> 
                          <figure>
                            <a class="aa-product-img" href="#"><img src="img/${row.filename}"></a>
                            <a class="aa-add-card-btn" href="#"><span class="fa fa-search"></span>View Detail</a>
                          </figure>
                          <figcaption>
                              <h4 class="aa-product-title"><a href="#">${row.pname}</a></h4>
                              <span class="aa-product-price">￦
                              <fmt:formatNumber value="${row.price}" pattern="###,###,###" />
                              </span>
                          </figcaption>                                                
                         <!-- <span class="aa-badge aa-sale" href="#">SALE</span>
                         <span class="aa-badge aa-sold-out" href="#">Sold Out</span>
                         <span class="aa-badge aa-hot" href="#">HOT</span> -->
                        </li>
                        </c:if>
						</c:forEach> 
						</ul>
						<a class="aa-browse-btn" href=""> 더 보기 </a>
						</div>
                    <!-- /농산물 -->
                               
                    <!-- 수산물-->
                    <div class="tab-pane fade" id="women">
                      <ul class="aa-product-catg">
                        <c:forEach items="${slist}" var="row" varStatus="st">
                        <c:if test="${st.count <= 8}">
                        <li>
                          <figure>
                            <a class="aa-product-img" href="#"><img src="img/${row.filename}"></a>
                            <a class="aa-add-card-btn"href="#"><span class="fa fa-search"></span>View Detail</a>
                          </figure>                         
                          <figcaption>
                              <h4 class="aa-product-title"><a href="#">${row.pname}</a></h4>
                              <span class="aa-product-price">￦
                              <fmt:formatNumber value="${row.price}" pattern="###,###,###" />
                              </span>
                          </figcaption>    
                        </li>
                        </c:if>
                        </c:forEach>
                        </ul>
                        <a class="aa-browse-btn" href=""> 더 보기 </a>
                        </div>
                      <!-- /수산물 -->

                    <!-- 가공식품 -->
                    <div class="tab-pane fade" id="electronics">
                       <ul class="aa-product-catg">
                       <c:forEach items="${glist}" var="row" varStatus="st">
                        <c:if test="${st.count <= 8}">
                        <li>
                          <figure>
                            <a class="aa-product-img" href="#"><img src="img/${row.filename}"></a>
                            <a class="aa-add-card-btn" href="#"><span class="fa fa-search"></span>View Detail</a>
                          </figure>                         
                          <figcaption>
                              <h4 class="aa-product-title"><a href="#">${row.pname}</a></h4>
                              <span class="aa-product-price">￦
                              <fmt:formatNumber value="${row.price}" pattern="###,###,###" />
                              </span>
                          </figcaption>     
                        </li>
                        </c:if>
                        </c:forEach>
                        </ul>
                        <a class="aa-browse-btn" href=""> 더 보기 </a>
                        </div>           
                  <!-- /가공식품 -->
                  
                  </div>
				</div>
          </div>
        </div>
      </div>
    </div>
    </div>
  </section>
  <!-- / 메뉴 별 최근게시물 -->


  <!-- 인기 상품  -->
  <section id="aa-popular-category">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="row">
            <div class="aa-popular-category-area">
             <ul class="nav nav-tabs aa-products-tab">
                <li class="active"><a href="#" data-toggle="tab">인기 상품</a></li>
                <!-- <li><a href="#featured" data-toggle="tab">Featured</a></li>
                <li><a href="#latest" data-toggle="tab">Latest</a></li>    -->                 
              </ul>
              <div class="tab-content">
                <div class="tab-pane fade in active" id="popular">
                  <ul class="aa-product-catg aa-popular-slider">
                    <c:forEach items="${hlist}" var="row" varStatus="st">
                    <c:if test="${st.count <= 8}">
                    <li>
                      <figure>
                        <a class="aa-product-img" href="#"><img src="img/${row.filename}" ></a>
                        <a class="aa-add-card-btn"href="#"><span class="fa fa-search"></span>View Detail</a>
                      </figure>                     
                      <figcaption>
                              <h4 class="aa-product-title"><a href="#">${row.pname}</a></h4>
                              <span class="aa-product-price">￦
                              <fmt:formatNumber value="${row.price}" pattern="###,###,###" />
                              </span>
                      </figcaption>
                      <!-- <span class="aa-badge aa-hot" href="#">HOT</span> -->
                    </li> 
                    </c:if>
                    </c:forEach>                                                                                
                  </ul>         
                  <a class="aa-browse-btn" href="#">더 보기 </a>
                </div>
              </div>
            </div>
          </div> 
        </div>
      </div>
    </div>
  </section>
<!-- / 인기 상품  -->


<jsp:include page="footer.jsp"></jsp:include>

  

  </body>
</html>