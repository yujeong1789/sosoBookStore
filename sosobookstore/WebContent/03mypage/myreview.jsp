<%@page import="com.bookstore.comment.model.CommentDTO"%>
<%@page import="com.bookstore.comment.model.CommentDAO"%>
<%@page import="com.bookstore.common.PageVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<%
   //회원이 담은 도서 목록 나열
   request.setCharacterEncoding("utf-8");
   
   //
   CommentDAO dao = new CommentDAO();
   List<CommentDTO> comList = null;
   
   try{
      //list= dao.showReview(bu_userid);
      //세션에서 userid 가져오는것은 include된 top.jsp파일에서 가져옴
      comList= dao.showReview(userid);
   } catch (SQLException e) {
      e.printStackTrace();
   }
   
   String c_no = request.getParameter("c_no");
   //페이징 처리
   int currentPage=1;  //현재 페이지
   
   //페이지번호를 클릭한 경우 처리
   if(request.getParameter("currentPage")!=null){
     currentPage=Integer.parseInt(request.getParameter("currentPage"));      
   }
   
   //[1] 현재 페이지와 무관한 변수
   int totalRecord=0;  //총 레코드 수
   if(comList!=null && !comList.isEmpty()){
      totalRecord = comList.size();  //예) 17
   }
   
   int pageSize=5;  //한 페이지에 보여줄 레코드(행) 수
   int blockSize=10; //한 블럭에 보여줄 페이지 수
      
   PageVo pageVo = new PageVo(currentPage, totalRecord, pageSize, blockSize);
   
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
							<thead>
								<tr>
									<th class="shoping__product" style="width: 5%" >번호</th>
									<th style="width: 10%">분류</th>
									<th style="width: 65%">제목</th>
									<th style="width: 10%">작성자</th>
									<th style="width: 10%">작성일</th>
								</tr>
							</thead>
							<tbody>

								<!-- 리뷰 목록  -->
								<%if(comList==null || comList.isEmpty()){%>
								<tr>
									<td colspan="5" class="align_center">게시물이 없습니다.</td>
								</tr>
								<%}else{%>
								<!-- 장바구니 반복문 시작 -->
								<%
		                              int num=pageVo.getNum();
		                              int curPos=pageVo.getCurPos();
		                                 
		                              for(int i=0;i<pageVo.getPageSize();i++){
		                                 if(num<1) break;
		                                    
		                                 CommentDTO dto =comList.get(curPos++);
		                                 num--;
		                           	
                              	%>

								<tr>
									<td class="shoping__cart__item">
										<h5><%=dto.getC_no() %></h5></td>
									<td class="shoping__cart__price">
										<h5><%=dto.getBd_no() %></h5></td>
									<td class="shoping__cart__item">
										<h5><a href="review_detail.jsp?no=<%=dto.getC_no() %>" style="color: gray;"><%=dto.getBd_title() %></a> </h5></td>
									<td class="shoping__cart__price">
										<h5><%=dto.getBu_userid() %></h5></td>
									<td class="shoping__cart__item">
										<h5><%=dto.getSc_regdate() %></h5></td>
									
								<%}//for
                        }//if %>

							</tbody>
						</table>
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