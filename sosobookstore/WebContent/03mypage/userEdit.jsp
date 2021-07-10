
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.user.model.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<jsp:useBean id="userService"
	class="com.bookstore.user.model.UserService" scope="session"></jsp:useBean>
<head>
<%
	request.setCharacterEncoding("utf-8");

	UserVO vo = null;
	try{
		vo = userService.selectUser(userid);
	}catch(SQLException e){
		e.printStackTrace();
	}

	String zipcode = vo.getBu_zipcode();
	String bu_address1 = vo.getBu_address1();
	String bu_address2 = vo.getBu_address2();
	if (zipcode == null)
		zipcode = "";
	if (bu_address1 == null)
		bu_address1 = "";
	if (bu_address2 == null)
		bu_address2 = "";

	String bu_hp = vo.getBu_hp();
	
	
%>
<head>
<script type="text/javascript">
	$(function() {
		$('#edit_submit').click(function() {
					if ($('#pwd').val().length < 1) {
						alert('비밀번호를 입력하세요');
						$('#pwd').focus();
						event.preventDefault();
					} else if ($('#pwd').val() != $('#pwd2').val()) {
						alert('비밀번호가 일치하지 않습니다.');
						$('#pwd2').focus();
						event.preventDefault();
					} else if (!validate_phone($('#hp').val())) {
						alert('전화번호는 숫자만 가능합니다.');
						$('#hp').focus();
						event.preventDefault();
					} else if ($('#address1').val()>1 && $('#address2')<1) {
						alert('상세 주소를 입력해주세요.');
						$('#address2').focus();
						event.preventDefault();
					}
				});
		
		$('#btnZipcode').click(function(){
			open("../09common/zipcode.jsp", "chk",
			"width=500,height=500,left=0,top=0,location=yes,resizable=yes");
		});
	});
</script>

<style type="text/css">
.checkout__form {
	width: 700px;
	margin-left: 200px;
}

/* 취소 버튼 */
.back-btn {
	font-size: 14px;
	color: white;
	font-weight: 800;
	text-transform: uppercase;
	display: inline-block;
	padding: 13px 30px 12px;
	background: #999999;
	border: none;
}
</style>

</head>

	<!-- 회원 정보 수정 시작 -->
	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="../bs/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2>회원 정보 수정</h2>
						<div class="breadcrumb__option">
							<a href="../bs/index.html">Home</a> <span>Edit</span>
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
				<h4>회원 정보 수정</h4>
				<!--  action="userEdit_ok.jsp" -->
				<form name="frm1" method="post" action="userEdit_ok.jsp">
					<div class="row">
						<div class="col-lg-8 col-md-6">
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											이름<span>*</span>
										</p>
									</div>
								</div>
							</div>
							<div class="checkout__input">
								<!-- ReadOnly  넣어주기-->
								<input type="text" value="<%=vo.getBu_name()%>" ReadOnly>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											아이디<span>*</span>
										</p>
									</div>
								</div>
							</div>
							<div class="checkout__input">
								<input type="text" value="<%=userid%>" ReadOnly>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											비밀번호<span>*</span>
										</p>
									</div>
								</div>
							</div>
							<div class="checkout__input">
								<input type="Password" name="pwd" id="pwd">
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											비밀번호 확인<span>*</span>
										</p>
									</div>
								</div>
							</div>
							<div class="checkout__input">
								<input type="Password" name="pwd2" id="pwd2">
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>주소</p>
										<input type="text" name="zipcode" id="zipcode" ReadOnly
											title="우편번호" placeholder="우편번호" value="<%=zipcode %>">
									</div>
								</div>
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											<span>&nbsp</span>
										</p>
										 <button type="button" class="site-btn" id="btnZipcode">우편번호 검색</button>
									</div>
								</div>
							</div>
							<div class="checkout__input">
								<input type="text" placeholder="기본 주소" class="checkout__input__add" name="address1" id="address1" value="<%=bu_address1%>"> 
								<input type="text" placeholder="상세 주소 입력" name="address2" id="address2" value="<%=bu_address2 %>">
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="checkout__input">
										<p>
											전화번호<span>*</span>
										</p>
										<input type="text" id="hp" placeholder="010-1111-1111"
											value="<%=vo.getBu_hp()%>" name="bu_hp">
									</div>
								</div>

							</div>
						</div>

					</div>
					<div class="row">
						<div class="col-lg-12 text-center">
							<!-- id="mem_submit" -->
							<button type="submit" class="site-btn" id="edit_submit">회원 정보 수정</button>
							<a href="../10main/index.jsp" class="back-btn">취소</a>
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