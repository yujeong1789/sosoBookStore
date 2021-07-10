<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
////////도서 리스트 보여주기///////
//[1] main 에서 shop 클릭하면 get방식으로 이동 
//[2] bookList.jsp에서 검색 버튼 클릭하면 post방식으로 submit
//[3] bookList.jsp에서 페이지 번호를 클릭하면 get방식으로 이동

//1.
request.setCharacterEncoding("utf-8");
String keyword=request.getParameter("searchKeyword");
String condition=request.getParameter("searchCondition");

//2.
BookDetailDAO bdDao = new BookDetailDAO();
List<BookDetailVo> bookList = null;
try {
	bookList = bdDao.showAll(keyword, condition);
	System.out.println("불러온 도서 레코드 수 :"+bookList.size());
} catch (SQLException e) {
	e.printStackTrace();
}

//3.
DecimalFormat df = new DecimalFormat("#,###");

if(keyword==null){
	keyword="";
}
if(condition==null){
	condition="";
}
%>
<!-- Hero Section Begin -->
	<section class="hero hero-normal">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<div class="hero__categories">
						<div class="hero__categories__all">
							<i class="fa fa-bars"></i> <span id="selectMenu">전체</span>
						</div>
						<ul>
							<li><a
								href="/sosobookstore/06search/bookList.jsp?searchCondition=문학">문학</a></li>
							<li><a
								href="/sosobookstore/06search/bookList.jsp?searchCondition=사회과학">사회과학</a></li>
							<li><a
								href="/sosobookstore/06search/bookList.jsp?searchCondition=예술">예술</a></li>
							<li><a
								href="/sosobookstore/06search/bookList.jsp?searchCondition=철학">철학</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-9">
					<div class="hero__search">
						<div class="hero__search__form">
							<!-- 검색 버튼 -->
							<form action="/sosobookstore/06search/bookList.jsp" method="post" name="searchFrm">
								<input type="text" name="searchKeyword"
									placeholder="검색하실 책의 제목 또는 작가명을 입력하세요." value="<%=keyword%>">
								<button type="submit" class="site-btn">SEARCH</button>
							</form>
						</div>
						<div class="hero__search__phone">
							<div class="hero__search__phone__icon">
								<i class="fa fa-phone"></i>
							</div>
							<div class="hero__search__phone__text">
								<h5>+65 11.188.888</h5>
								<span>support 24/7 time</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Hero Section End -->