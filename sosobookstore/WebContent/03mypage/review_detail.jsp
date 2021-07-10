<%@page import="com.bookstore.comment.model.CommentDTO"%>
<%@page import="com.bookstore.comment.model.CommentDAO"%>
<%@page import="com.bookstore.common.PageVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Css Styles -->
<style type="text/css">
	input{
		border: 0px solid;
	}
</style>

<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<%
   //회원이 담은 도서 목록 나열
   request.setCharacterEncoding("utf-8");

   String no=request.getParameter("no");   
   
   CommentDAO dao = new CommentDAO();
   CommentDTO dto = null;
   
   System.out.println("no :" + no);
   try{
      dto= dao.showReviewByNo(Integer.parseInt(no));
   } catch (SQLException e) {
      e.printStackTrace();
   }
   
   String content= dto.getSc_about();
	if(content!=null){
		content=content.replace("\r\n", "<br>");
	}else{
		content="";
	}
%>
	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="../bs/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>도서 리뷰</h2>
						<div class="breadcrumb__option">
							<a href="./index.html">Home</a> <span>Book Review</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Shoping Cart Section Begin -->
	<section class="shoping-cart spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__table">
						<table>
							<tbody>
								<tr>
									<th class="shoping__product" colspan="4" ><h4><b>도서 정보<br></b></h4></th>
								</tr>
								
								<tr>
									<td width="30%"><img src ="<%=dto.getBd_img()%>" style="width: 150px; height: 200px"></td>
									<td><%=dto.getBd_title() %></td>
									<td><%=dto.getBd_author() %></td>
									<td><%=dto.getBd_price() %>원<br></td>
								</tr>
								
								<tr>
									
									<th class="shoping__product" colspan="4" ><h4><br><br><br><br><b>리뷰 내용<br></b></h4></th>
								</tr>
								
								<tr>
									<td colspan="2">작성자 : <span><%=dto.getBu_userid() %></span></td>
									<td colspan="2">작성일 : <%=dto.getSc_regdate() %> </td>
								</tr>
	
								<tr>
									<td colspan="4" height="250px"><%=content %></td>
								</tr>

							</tbody>
						</table>
						<br><br>
						<div class="col-lg-12 text-center" style="align-content: center;">
							<a href="../10main/index.jsp" class="site-btn " >홈</a>
							<a href="myreview.jsp" class="site-btn" >목록으로</a>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</section>
	<!-- Shoping Cart Section End -->

    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->
</body>
</html>