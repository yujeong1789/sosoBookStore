<%@page import="com.bookstore.common.PageVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<script type="text/javascript">
$(function(){
		$('form[name=frmDelete]').submit(function(){
			if(!confirm('삭제하시겠습니까?')){
				event.preventDefault();
			}
		});
		
		var qty = $('#c_qty').val();
		
		var total = 0;
		
		//click 이벤트 발생 (마이너스)
		$('.pro-qty input .dec').click(function(){
		    $('.pro-qty input').val(qty);
		    qty -= 1;
		    $('#bookQty').val(qty);
		});
		
		//click 이벤트 발생 (플러스)
		$('.pro-qty input .inc').click(function(){
		    $('.pro-qty input').val(qty);
		    qty += 1;
		    $('#bookQty').val(qty);
		});
		
		//도서 수량별 가격 보여주기
		$('.pz_record').each(function(){
			var qty=$(this).find('#c_qty').val();
			console.log("도서 수량 : "+qty);
			$(this).find('.c_price').text(($(this).find('.price').text())*qty);
			total += $(this).find('.c_price').html()*1;
		});
		
		//전체 합계 가격 보여주기
		$('#total').text(total);
		$('#totalPrice').val(total);
	});
	
</script>
<body>

	<%
   //회원이 담은 도서 목록 나열
   request.setCharacterEncoding("utf-8");
   //
   cartDAO dao = new cartDAO();
   List<cartDTO> list = null;
   
   try{
      list= dao.showCart(userid);
      //list= dao.showCart("testuser");
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
   if(list!=null && !list.isEmpty()){
      totalRecord = list.size();  //예) 17
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
						<h2>장바구니</h2>
						<div class="breadcrumb__option">
							<a href="./index.html">Home</a> <span>Shopping Cart</span>
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
									<th class="shoping__product">도서 상품정보</th>
									<th>판매가</th>
									<th>수량</th>
									<th>합계</th>
									<th></th>
								</tr>
							</thead>
							<tbody>

								<!-- 장바구니 목록  -->
								<%if(list==null || list.isEmpty()){%>
								<tr>
									<td colspan="5" class="align_center">장바구니가 비어있습니다.</td>
								</tr>
								<%}else{%>
								<!-- 장바구니 반복문 시작 -->
								<%
		                              int num=pageVo.getNum();
		                              int curPos=pageVo.getCurPos();
		                                 
		                              for(int i=0;i<pageVo.getPageSize();i++){
		                                 if(num<1) break;
		                                    
		                                 cartDTO dto =list.get(curPos++);
		                                 num--;
		                           	
                              	%>
								<tr class="pz_record">
									<td class="shoping__cart__item">
										<img src="<%=dto.getBd_image() %>" alt="" style="width: 120px; height: 170px;">
										<h5><%=dto.getBd_title() %></h5>
									</td>
									<td class="shoping__cart__price">
										<span class="price"><%=dto.getBd_price() %></span>원
									</td>
									<td class="shoping__cart__quantity">
										<div class="quantity">
											<div class="pro-qty">
												<!-- 수량 증가할 때, 합계 변하게 어떻게, -->
												<input type="text" id="c_qty" value="<%=dto.getC_bookqty()%>">
												<input type="hidden" value="<%=dto.getC_bookqty()%>" id="bookQty" name="bookQty">
											</div>
										</div>
									</td>
									<td class="shoping__cart__total">
										<span class="c_price"></span>원
									</td>
									<!-- x누르면 장바구니에서 지우는 것 -->
									<td class="shoping__cart__item__close">
										<!-- 버튼 누르면 삭제  -->
										<form name="frmDelete" method="post"
											action="cart_delete_ok.jsp?c_no=<%=dto.getC_no()%>">
											<input type="submit" value="X" />

										</form>
									</td>

									<!-- <td class="shoping__cart__item__close">
									<spanclass="icon_close" ></span></td> -->
								</tr>
								<%}//for
                        }//if %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="shoping__cart__btns">
						<!-- 전체 삭제 -->
						
						<form name="frmDelete" method="post"
							action="cart_delete_ok.jsp?bu_userid=<%=userid%>">
							<input type="submit" value="전체 삭제" class="primary-btn cart-btn cart-btn-right" />
						</form>
						<!-- <a href="#" class="primary-btn cart-btn cart-btn-right"></span> </a> -->
					</div>
				</div>
				<div class="col-lg-6"></div>
				<div class="col-lg-12">
					<div class="shoping__checkout">
						<h5>
							장바구니 합계 : 
							<span id="total"> </span><span>원</span>
							<input type="hidden" id="totalPrice" value="0">
						</h5>
						<!-- <ul>
							<li>Subtotal <span>$454.98</span></li>
							<li>Total <span>$454.98</span></li>
						</ul> -->
						<a href="../05checkout/checkOut.jsp" class="primary-btn">상품 주문</a>
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