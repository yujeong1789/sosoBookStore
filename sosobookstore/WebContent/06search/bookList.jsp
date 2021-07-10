<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="com.bookstore.common.PageVo"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<%
//////베스트셀러 도서 리스트 보여주기///////
//1.
//2
request.setCharacterEncoding("utf-8");

List<BookDetailVo> bestList = null;
try{
	bestList=bdDao.showBestseller();
	System.out.print("베스트셀러 레코드 수 :"+bestList.size());
}catch(SQLException e){
	e.printStackTrace();
}

//페이징처리
//PageVo pageVo = new PageVo(int currentPage, int totalRecord, int pageSize, int blockSize);
int currentPage=1;
if(request.getParameter("currentPage")!=null){
	currentPage=Integer.parseInt(request.getParameter("currentPage"));
}
PageVo pageVo = new PageVo(currentPage, bookList.size(), 9, 5);

%>
<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../bs/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Shop</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.html">Home</a>
                            <span>Shop</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb Section End -->
<!-- Product Section Begin -->
    <!-- 사이드메뉴 -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-5">
                    <div class="sidebar">
                    	<!-- 책 장르 카테고리 -->
                        <div class="sidebar__item">
                            <h4>Book field</h4>
                            <ul>
                                <li><a href="/sosobookstore/06search/bookList.jsp" value="문학">전체</a></li>
                                <li><a href="/sosobookstore/06search/bookList.jsp?searchCondition=문학" >문학</a></li>
                                <li><a href="/sosobookstore/06search/bookList.jsp?searchCondition=사회과학">사회과학</a></li>
                                <li><a href="/sosobookstore/06search/bookList.jsp?searchCondition=예술">예술</a></li>
                                <li><a href="/sosobookstore/06search/bookList.jsp?searchCondition=철학">철학</a></li>
                            </ul>
                        </div>
                       
                       <!-- 추천 도서 소개 -->
                        <div class="sidebar__item"> 
                            <div class="latest-product__text">
                                <h4>추천 도서</h4>
                                <div class="latest-product__slider owl-carousel">
                                    <div class="latest-prdouct__slider__item">
                                        <!-- 최신 도서 소개 리스트 [반복] -->
                                        <%if(bestList!=null && !bestList.isEmpty()){
                                        	for(int i=0; i<3; i++) {
                                        		BookDetailVo vo = bestList.get(i);
                                        	%>
                                        	<a href="/sosobookstore/07detail/bookDetail.jsp?no=<%=vo.getBd_no() %>" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img class="detailimage" src="<%=vo.getBd_image() %>" alt="도서 이미지">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6><%=vo.getBd_title() %></h6>
                                                <span><%=df.format(vo.getBd_price()) %>원</span>
                                            </div>
                                        </a>
                                        <%}//for
                                       	}//if%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div class="col-lg-9 col-md-7">
                   <div class="filter__item">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
	                        </div>
                            <div class="col-lg-4 col-md-4">
                            </div>
                            <div class="col-lg-4 col-md-3">
                                    <div class="filter__found">
                                    <h6><span>총 <%=bookList.size() %>개</span>의 도서가 있습니다.</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    <!-- 반복되는 상품 리스트 형식 -->
                    <% 
                    if(bookList==null && bookList.isEmpty()){%>
                    	<p> 검색 결과가 존재하지 않습니다. </p>
                    <%}else{
                    	int num = pageVo.getNum();
                    	int curPos = pageVo.getCurPos();
                    	for(int i=0; i<pageVo.getPageSize(); i++){
                    		if(num<1) break;
                    		
                    		BookDetailVo vo = bookList.get(curPos++);
                    		num--;
                    		%>
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic">
                                	<img class="listimage" src="<%=vo.getBd_image()%>">
                                </div>
                                <div class="product__item__text">
                                    <h6><a href="/sosobookstore/07detail/bookDetail.jsp?no=<%=vo.getBd_no() %>"><%=vo.getBd_title() %></a></h6>
                                    <h5><%=df.format(vo.getBd_price()) %>원</h5>
                                </div>
                            </div>
                        </div>
                      <%}//for 
                    }//if%>
                        
                    </div>
                    <!-- 페이지!!!!!!! -->
                    <div class="product__pagination">
                    	<!-- 이전 블럭으로 이동 -->
                    	<%if(pageVo.getFirstPage()>1) {%>
                    		<a href="bookList.jsp?currentPage=<%=pageVo.getFirstPage()-1%>&searchKeyword=<%=keyword%>&searchCondition=<%=condition%>"><i class="fa fa-long-arrow-left"></i></a>
                    	<%} %>
                    	<!-- 1 2 3 4 5  -->
                        <% for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
                        	if(i>pageVo.getTotalPage()) break;
                        	
                        	if(i==pageVo.getCurrentPage()){%>
                        		<a style="color:black"><%=i%></a>
                       	<%	}else{ %>
                       			<a href="bookList.jsp?currentPage=<%=i%>&searchKeyword=<%=keyword%>&searchCondition=<%=condition%>"><%=i%></a>
                    	<%}//if
                    	}//for %>
                    	<!-- 1 2 3 4 5  -->
                    	<%if(pageVo.getLastPage()<pageVo.getTotalPage()){ %>
                        	<a href="bookList.jsp?currentPage=<%=pageVo.getLastPage()+1%>&searchKeyword=<%=keyword%>&searchCondition=<%=condition%>"><i class="fa fa-long-arrow-right"></i></a>
                        <%} %>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->
</body>
</html>