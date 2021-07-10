<%@page import="com.bookstore.common.PageVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="../bs/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>마이페이지</h2>
						<div class="breadcrumb__option">
							<a href="./index.html">Home</a> <span>MyPage</span>
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
									<th colspan="5" class="align_center" style="font-size: 20px;" >
										<a href="myorder.jsp"  style="color: black;" >주문내역</a></th>
								</tr>
								<tr>
									<td colspan="5" class="align_center"  >
										<a href="myorder.jsp?userid=<%=userid %>" style="color: gray;" >고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</a></td>
								</tr>
								
								<tr>
									<th colspan="5" class="align_center" style="font-size: 20px;" >
										<a href="userEdit.jsp"  style="color: black;" ><br><br>회원정보 수정</a></th>
								</tr>
								<tr>
									<td colspan="5" class="align_center"  >
										<a href="userEdit.jsp" style="color: gray;" >회원이신 고객님의 개인정보를 관리하는 공간입니다.</a></td>
								</tr>
								
								<tr>
									<th colspan="5" class="align_center" style="font-size: 20px;" >
										<a href="../04cart/cart.jsp"  style="color: black;" ><br><br>장바구니</a></th>
								</tr>
								<tr>
									<td colspan="5" class="align_center"  >
										<a href="../04cart/cart.jsp" style="color: gray;" >고객님의 장바구니 내역을 확인하실 수 있습니다.</a></td>
								</tr>
								
								<tr>
									<th colspan="5" class="align_center" style="font-size: 20px;" >
										<a href="myreview.jsp"  style="color: black;" ><br><br>도서리뷰</a></th>
								</tr>
								<tr>
									<td colspan="5" class="align_center"  >
										<a href="myreview.jsp" style="color: gray;" >고객님께서 작성하신 게시물을 관리하는 공간입니다.</a></td>
								</tr>
								

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