<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="java.sql.SQLException"%>

<jsp:useBean id="bookVo" class="com.bookstore.book.model.BookDetailVo" scope="page"></jsp:useBean>
<jsp:useBean id="bookDao" class="com.bookstore.book.model.BookDetailDAO" scope="session"></jsp:useBean>
<script type="text/javascript">

</script>
<%
int no=Integer.parseInt(request.getParameter("no"));
bookVo=bookDao.selectByNo(no);
String title=bookVo.getBd_title();
Date pubdate=bookVo.getBd_pubdate();
String author=bookVo.getBd_author();
int price=bookVo.getBd_price();
String publisher=bookVo.getBd_publisher();
String img=bookVo.getBd_image();
String about=bookVo.getBd_about();
String isbn=bookVo.getBd_ISBN();
int sellcount=bookVo.getBd_sellcount();
int category=bookVo.getBk_kind_no();
%>
<body>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../bs/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>책정보 수정</h2>
                        <div class="breadcrumb__option">
                            <a href="../10main/index.jsp">메인페이지</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                <h4>수정</h4>
                <form name="form2" method="post"  action="bookedit_ok.jsp">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                           		<div class="col-lg-8">
                            <div class="checkout__input">
                                 <p>번호</p>
                                 <input type="text" name="no" id="no" readonly value=<%= no%>> &nbsp;
                                 <input type="button" class="col-lg-4" value="책검색" id="bookinfocheckbt">
                             </div>
                            <div class="checkout__input">
                                 <p>제목(수정불가)</p>
                                 <input type="text" name="title" id="title" readonly value=<%= title%>>
                            </div>
                            <div class="checkout__input">
                                <p>출간일(수정불가)</p>
                                <input type="text" name="pubdate" id="pubdate" readonly value=<%= pubdate%>>
                            </div>
                            <div class="checkout__input">
                                <p>작가(수정불가)</p>
                                <input type="text" name="author" id="author" readonly value=<%= author%>>
                            </div>
                            	<div class="checkout__input">
                                <p>판매가</p>
                                <input type="text" name="price" id="price" value=<%= price%>>
                            </div>
                             <div class="checkout__input">
                                <p>출판사(수정불가)</p>
                                <input type="text" name="publisher" id="publisher" readonly value=<%= publisher%>>
                            </div>
                            <div class="checkout__input">
                                <p>내용</p>
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                                <div class="col-lg-8">
                        		<div class="checkout__input">
                                <p>이미지(수정불가)</p>
                                <input type="text" name="img" id="img" readonly  value=<%= img%>>
                            </div>
                            <div class="checkout__input">
                                 <p>ISBN(수정불가)</p>
                                 <input type="text" name="isbn" id="isbn" readonly  value=<%= isbn%>>
                             </div>
                             <div class="checkout__input">
                                <p>판매수</p>
                                <input type="text" name="sellcount" id="sellcount" value=<%= sellcount%>>
                            </div>
							</div>
							 <div>
							 <p>도서 장르</p>
                            	<select name="category" id="category">
								    <option value="1">철학</option>
								    <option value="3">사회과학</option>
								    <option value="6">예술</option>
								    <option value="8">문학</option>
								</select>
							</div>
                        </div>
	           		 </div>
					<div class="row">
						<div class="text-center">
							<textarea cols="140" rows="10" name="about"><%=about%></textarea>
						</div>
					</div>
					<button type="submit" class="site-btn" id="bookedit"
						name="bookedit">책정보수정</button>
				</form>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->
</body>
</html>