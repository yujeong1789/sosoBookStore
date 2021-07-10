<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<script type="text/javascript">
	$(function(){
		$('#userid').focus();
		$('#registor').click(function(){
			location.href='../01register/register.jsp';
		});
		$('#loginBtn').click(function(){
			$('.call').each(function(idx, item){
				if($(this).val().length<1){
					alert($(this).prev().text() +"를 입력하세요");
					$(this).focus();
					event.preventDefault();
					return false;
				}
			});
		});
		
		
	});
</script>

<body>
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../bs/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>로그인</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.html">메인페이지</a>
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
                <h4>로그인</h4>
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                    <form name="bookLogin" method="post" action="login_ok.jsp">
                                        <p>아이디<input type="text" name="userid" id="userid" class="call"></p>
                                        <p>비밀번호<input type="password" name="password" id="password" class="call"></p>
                                        <input type="submit" class="site-btn" name="booklogin" id="loginBtn" value="로그인" style="color: white"></button>
                                        <input type="button" id="registor" class="site-btn" value="회원가입" style="color: white">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
            </div>
        </div>
    </section>
    <!-- Checkout Section End -->
    
    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->
