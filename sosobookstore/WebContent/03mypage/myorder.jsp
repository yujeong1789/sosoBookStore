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
<style>
button {
	border: 0px solid;
}
</style>
<script type="text/javascript">
$(function(){
	$('form[name=frmDelete]').submit(function(){
		if(!confirm('삭제하시겠습니까?')){
			event.preventDefault();
		}
	});
});
</script>
</head>
<%
	//회원 주문 내역
   request.setCharacterEncoding("utf-8");

	//회원의 주문 목록 리스트 쭉
   //String userid=request.getParameter("userid");   
   
   OrderDAO dao = new OrderDAO();
   List<OrderDTO> olist = null;
   
   try{
	   olist = dao.showAllOrder(userid);
   } catch (SQLException e) {
      e.printStackTrace();
   }
   
   String o_no = request.getParameter("o_no");
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
					<h2>구매 목록</h2>
					<div class="breadcrumb__option">
						<a href="../10main/index.jsp">Home</a> <span>Book Order</span>
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
							<!-- <tr>
								<th class="shoping__product" colspan="3"><h4>
										<b>구매 목록<br>
										<br></b>
									</h4></th>
							</tr> -->

							<%if(olist==null || olist.isEmpty()){%>
							<tr>
								<td colspan="5" class="align_center">구매내역이 없습니다.</td>
							</tr>
							<%}else{%>
							<!-- 구매목록 반복문 시작 -->
							<%
		                              int num=pageVo.getNum();
		                              int curPos=pageVo.getCurPos();
		                                 
		                              for(int i=0;i<pageVo.getPageSize();i++){
		                                 if(num<1) break;
		                                    
		                                 OrderDTO dto =olist.get(curPos++);
		                                 String address1 = dto.getO_address1();
		                                 String address2 = dto.getO_address2();
		                                 String address = address1 + address2;
		                                 
		                                 num--;
		                           	
                              	%>
							<tr>
								<td style="width: 25%; text-align: right;"><br><br>
									결제 번호 <span>&nbsp&nbsp</span>
								</td>
								<td
									style="width: 25%; text-align: left; font-size: 27px; font-weight: bold;">
									<a href="myorder_detail.jsp?no=<%=dto.getO_no()%>"><br> <%=dto.getO_no() %></a>
								</td>
								<td style="color:red; ">
									<%
										//
										if(dto.getO_delflag()==null){%>
											<br><br> 주문완료 
										<%}else{%>
											<br><br> <strike>주문취소</strike> 
										 <%}%>
								</td>
							</tr>

							<tr>
								<td style="text-align: right;">
									배송지 정보<span>&nbsp &nbsp</span>
								</td>
								<td
									style="width: 25%; text-align: left; color: gray; font-size: 15px;">
									(우편번호)<span> &nbsp</span> <%=dto.getO_zipcode()%> <br> <%=address %>
								</td>
								<td>
								<form action="myorder_delete_ok.jsp?no=<%=dto.getO_no() %>"
										method="post" name="frmDelete">
									<%if(dto.getO_delflag()==null){%> 
										<button type="submit">주문 취소</button> 
									<%}else{%>
										<button type="submit" disabled>주문 취소</button> 
									<%}%>
									
								</form>
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
							href="mypage.jsp" class="site-btn">목록으로</a>
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

</body>
</html>