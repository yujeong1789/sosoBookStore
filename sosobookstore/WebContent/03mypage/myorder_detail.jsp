<%@page import="com.bookstore.orderDetail.model.OrderDetailDTO"%>
<%@page import="com.bookstore.orderDetail.model.OrderDetailDAO"%>
<%@page import="com.bookstore.order.model.OrderDTO"%>
<%@page import="com.bookstore.order.model.OrderDAO"%>
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
<head>

</head>
<%

   request.setCharacterEncoding("utf-8");

   String no = request.getParameter("no");

   OrderDetailDAO dao = new OrderDetailDAO();
   List<OrderDetailDTO> olist = null;
   
   try{
	   olist = dao.showOrderDetail(Integer.parseInt(no));
   } catch (SQLException e) {
      e.printStackTrace();
   }
  
   //페이징 처리
   int currentPage=1;  //현재 페이지
   
   //페이지번호를 클릭한 경우 처리
   if(request.getParameter("currentPage")!=null){
     currentPage=Integer.parseInt(request.getParameter("currentPage"));      
   }
   
   //[1] 현재 페이지와 무관한 변수
   int totalRecord=0;  //총 레코드 수
   if(olist!=null && !olist.isEmpty()){
      totalRecord = olist.size();  //예) 17
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
					<h2>구매 상세 내역</h2>
					<div class="breadcrumb__option">
						<a href="../10main/index.jsp">Home</a> <span>Order Detail</span>
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
								<th colspan="2">
									결제 번호 <span>&nbsp&nbsp</span><%=no %>
								</th>
								<%-- <th style="width: 30%; text-align: right;">
									결제 번호 <span>&nbsp&nbsp</span><%=dto.getO_no() %>
								</th> --%>
							</tr>
						</thead>
						<tbody>
							

							<%if(olist==null || olist.isEmpty()){%>
							<tr>
								<td colspan="5" class="align_center">상세내역이 없습니다.</td>
							</tr>
							<%}else{%>
							<!-- 구매목록 반복문 시작 -->
							<%
		                              int num=pageVo.getNum();
		                              int curPos=pageVo.getCurPos();
		                                 
		                              for(int i=0;i<pageVo.getPageSize();i++){
		                                 if(num<1) break;
		                                    
		                                 OrderDetailDTO dto =olist.get(curPos++);
		                                 
		                                 num--;
		                           	
                              	%>
							<tr>
								
								<td rowspan="2">
									<img src="<%=dto.getBd_image()%>" style="width: 150px; height: 200px">
								</td>
								<td >
									제목 <span>&nbsp&nbsp</span> <%=dto.getBd_title() %>
								</td>
							</tr>

							<tr>
								<td>
									수량 <span>&nbsp&nbsp</span><%=dto.getOd_qty() %>
								</td>
							</tr>


							<%}//for
                        }//if %>
						</tbody>
					</table>
					<br>
					<br>
					<div class="col-lg-12 text-center" style="align-content: center;">
						<a href="../10main/index.jsp" class="site-btn ">홈</a> <a
							href="myorder.jsp" class="site-btn">목록으로</a>
					</div>
				</div>
			</div>
		</div>

	</div>
</section>
<!-- Shoping Cart Section End -->

<!-- Footer Section Begin -->
<%@include file="../00inc/footer.jsp"%>
<!-- Footer Section End -->
