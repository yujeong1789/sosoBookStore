<%@page import="com.bookstore.user.model.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<jsp:useBean id="userService" class="com.bookstore.user.model.UserService" scope="session"></jsp:useBean>
<jsp:useBean id="userVo" class="com.bookstore.user.model.UserVO" scope="session"></jsp:useBean>
<%
	userVo = userService.selectUser(userid);
	System.out.println("주문에서 가져오는 사용자 정보 : "+userVo);
%>
<script type="text/javascript">
	$(function(){
		$('#btnZipcode').click(function(){
			open("../09common/zipcode.jsp", "chk",
			"width=500,height=500,left=0,top=0,location=yes,resizable=yes");
		});
		
		$('#memAdress').click(function(){
			console.log($('#memAdress').prop("checked"));
			if($('#memAdress').prop("checked")){
				$('#name').val("<%=userVo.getBu_name()%>");
				if(<%=userVo.getBu_zipcode()%>!=null){
					$('#zipcode').val("<%=userVo.getBu_zipcode()%>");
					$('#address1').val("<%=userVo.getBu_address1()%>");
					$('#address2').val("<%=userVo.getBu_address2()%>");
				}
				if(<%=userVo.getBu_hp()%>!=null){
					$('#hp').val("<%=userVo.getBu_hp()%>");
				}
			}else{
				$('#name').val("");
				$('#zipcode').val("");
				$('#address1').val("");
				$('#address2').val("");
				$('#hp').val("");
			}
		});
		
		var sum=0;
		$('.price').each(function(idx,item){
			var price = $(this).html();
			price = price.replace(",","");
			sum += price*1;
		});
		
		$('#totalPrice').val(sum);
		$('#total').html(numberWithCommas(sum)+"원");
		
		$('form[name=orderFrm]').submit(function(){
			if($('#name').val()==''){ //empty체크1
				alert('이름을 입력하세요.');
				$('#name').focus();
				event.preventDefault();
			}else if($('#zipcode').val()==''){ //empty체크1
				alert('우편번호를 입력하세요.');
				event.preventDefault();
			}else if($('#address1').val()==''){ //empty체크1
			alert('주소를 입력하세요.');
			$('#address1').focus();
			event.preventDefault();
			}else if($('#address2').val()==''){ //empty체크1
				alert('상세 주소를 입력하세요.');
				$('#address2').focus();
				event.preventDefault();
			}else if($('#hp').val()==''){ //empty체크1
				alert('연락처를 입력하세요.');
				$('#hp').focus();
				event.preventDefault();
			}else if($('#email').val()==''){ //empty체크1
				alert('이메일을 입력하세요.');
				$('#email').focus();
				event.preventDefault();
			}
		});
	});
	
	
	
	function numberWithCommas(sum) {
	    return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	</script>
</head>
<body>
<jsp:useBean id="cartDao" class="com.bookstore.cart.model.cartDAO" scope="session"/>
 <%
 request.setCharacterEncoding("utf-8");

 List<cartDTO> list = new ArrayList<cartDTO>();
 try{
	 list = cartDao.showCart(userid);
	 System.out.println("장바구니에 담긴 갯수"+list.size());
 }catch(SQLException e){
	e.printStackTrace();
 }
 %>
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../bs/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>결제하기</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.html">Home</a>
                            <span>Checkout</span>
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
                <h4>주문 정보 입력</h4>
                <form action="checkOut_ok.jsp" name="orderFrm" method="post">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="row">
                                <div class="col-lg-6">
		                            <div class="checkout__input__checkbox">
		                                <label for="memAdress">
	                                		회원 정보 주소로 배송
		                                    <input type="checkbox" id="memAdress">
		                                    <span class="checkmark"></span>
		                                </label>
		                            </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>이름<span>*</span></p>
                                        <input type="text" id="name" name="name">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
		                            <div class="checkout__input">
		                                <p>우편번호<span>*</span></p>
		                                <input type="text" placeholder="우편번호 검색" id="zipcode" name="zipcode">
		                            </div>
	                            </div>
	                            <div class="col-lg-6">
		                            <div class="checkout__input">
		                                <p><span>&nbsp</span></p>
		                                <button type="button" class="site-btn" id="btnZipcode">우편번호 검색</button>
	                                </div>
                                </div>
                            </div>
                            <div class="checkout__input">
	                                <p>주소<span>*</span></p>
	                                <input type="text" placeholder="시/도/구/군" class="checkout__input__add" name="address1" id="address1">
	                                <input type="text" placeholder="상세 주소 입력" name="address2" id="address2">
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>전화번호<span>*</span></p>
                                        <input type="text" placeholder="010-1234-1234" name="hp" id="hp">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>Email<span>*</span></p>
                                        <input type="text" placeholder="Example@abc.com" name="email" id="email">
                                        <!-- totalPrice -->
                                        <input type="hidden" name="totalPrice" id="totalPrice">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4>주문 목록</h4>
                                <div class="checkout__order__products">상품명 <span>합계</span></div>
                                <!-- 장바구니 리스트 보여주기! 반복! -->
                                <ul>
                                <% if(list!=null && !list.isEmpty()){
                                	for(int i=0; i<list.size(); i++){
                                		cartDTO dto = list.get(i);
                                	%><li><%=dto.getBd_title() %> (<%=dto.getC_bookqty() %>권)<span class="price"> <%=df.format(dto.getBd_price()*dto.getC_bookqty()) %></span> </li>
                                	<%}//for
                                	}//if%>
                                </ul>
                                <div class="checkout__order__subtotal">합계 <span id="total"></span></div>
                                <p>주문해주셔서 감사합니다. 배송은 배송사에 따라 다르며 3~5일이 소요 됩니다. 즐거운 하루 되세요.	</p>
                                <button type="submit" class="site-btn">주문하기</button>
                            </div>
                        </div>
                    </div>
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