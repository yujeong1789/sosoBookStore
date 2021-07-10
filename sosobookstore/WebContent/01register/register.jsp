<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<script type="text/javascript" src="../bs/js/member.js"></script>
<script type="text/javascript">
$(function(){
		$('#regi').click(function(){
			if($('#name').val().length<1){
				alert('이름을 입력하세요');
				$('#name').focus();
				event.preventDefault();
				return false;
			}else if($('#userid').val().length<1){
				alert('아이디를 입력하세요');
				$('#userid').focus();
				event.preventDefault();
				return false;
			}else if(!validate_userid($('#userid').val())){
				alert('아이디는 영문,숫자,_만 가능합니다.');
				$('#userid').focus();
				event.preventDefault();
				return false;
			}else if($('#password').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#password').focus();
				event.preventDefault();
				return false;
			}else if($('#password').val()!=$('#passwordcheck').val()){
				alert('비밀번호가 일치하지 않습니다.');
				$('#passwordcheck').focus();
				event.preventDefault();
				return false;
			}else if($('#hp').val().length<1){
				alert('전화번호는 필수입니다. 입력해 주세요');
				$('#hp').focus();
				event.preventDefault();
				return false;
			}else if(!validate_phone($('#hp').val())){
				alert('전화번호는 숫자만 가능합니다.');
				$('#hp').focus();
				event.preventDefault();
				return false;
			}else if($('#chkId').val() !='Y'){
				alert('아이디 중복확인하세요');
				$('#btnChkId').focus();
				event.preventDefault();
				return false;
			}
		});
});
</script>

<body>
<%
request.setCharacterEncoding("utf-8");

//String userid=request.getParameter("userid"); top에서 불러오기때문에 잠시 주석처리

if(userid==null){
	userid="";
}
%>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../bs/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>회원가입</h2>
                        <div class="breadcrumb__option">
                            <a href="../02login/login.jsp">로그인</a>
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
                <h4>회원가입</h4>
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                        	<form name="form2" method="post" action="register_ok.jsp">
                        	<div class="row">
                           		<div class="col-lg-8  col-md-6">
                            	<div class="checkout__input">
                                 <p>이름</p>
                                 <input type="text" name="name" id="name" style="ime-mode:active" >
                             </div>
                             <div class="row">
                                <div class="col-lg-6">
                            <div class="checkout__input">
                                 <p>아이디</p>
                                <input type="text" placeholder="중복체크를 해주세요" value="<%=userid%>" style="ime-mode:inactive" name="userid" id="userid">&nbsp;
                                </div>
	                            </div>
                              <div class="col-lg-6">
		                            <div class="checkout__input">
		                                <p><span>&nbsp</span></p>
                                <button type="button" id="btnChkId" class="site-btn" title="아이디 중복 확인">아이디 중복 확인</button>
                                </div></div>
                            </div>
                            <div class="checkout__input">
                                <p>비밀번호</p>
                                <input type="password" name="password" id="password">
                            </div>
                            <div class="checkout__input">
                                <p>비밀번호확인</p>
                                <input type="password" name="passwordcheck" id="passwordcheck">
                            </div>
                            
                            <div class="row">
                           	 <div class="col-lg-6">
                            	<div class="checkout__input">
                                	<p>우편번호</p>
                                	<input type="text" name="zipcode" id="zipcode">
                                	</div>
                                	</div>
                                	<div class="col-lg-6">
		                            <div class="checkout__input">
		                            <p><span>&nbsp</span></p>
                                <button type="Button" class="site-btn" id="btnZipcode" title="우편번호 검색">우편번호 검색</button><br />
                            </div>
                            </div>
                            </div>
                             <div class="checkout__input">
                                <p>주소</p>
                                <input type="text" name="address1" id="address1" class="checkout__input__add" readonly><br>
                                <input type="text" name="address2" id="address2" placeholder="상세 주소 입력">
                            </div>
                            <div class="checkout__input">
                                <p>전화번호(-없이 입력)</p>
                                <input type="text" name="hp" id="hp">
                            </div>
                            <button type="submit" class="site-btn" id="regi" name="id">회원가입하기</button>
                            </div>
                            </div>
                            </form>
                        </div>
                        <div class="col-lg-4 col-md-6">
                    	</div>
	            </div>
            </div>
        </div>
    </section>
     <input type ="hidden" name="chkId" id="chkId">
    <!-- Checkout Section End -->
    
<!-- Footer Section Begin -->
<%@include file="../00inc/footer.jsp" %>
<!-- Footer Section End -->
