<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>


<script type="text/javascript">
$(function(){
		$('#bookregi').click(function(){
			if($('#title').val().length<1){
				alert('검색으로 책정보를 가져와 주세요');
				event.preventDefault();
				return false;
			}else if($('#price').val().length<1){
				alert('책의 가격을 입력해 주세요');
				$('#price').focus();
				event.preventDefault();
				return false;
			}else if(!validate_phone($('#price').val())){
				alert('가격은 숫자만 입력가능합니다');
				$('#price').focus();
				event.preventDefault();
				return false;
			}
		});
		$('#bookinfocheckbt').click(function(){
				open("booksearch.jsp", "chk",
				"width=500,height=500,left=0,top=0,location=yes,resizable=yes");
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
                        <h2>책등록</h2>
                        <div class="breadcrumb__option">
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
                <h4>책 등록</h4>
                <form name="form2" method="post" action="bookregister_ok.jsp">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                           		<div class="col-lg-8">
                            	<div class="checkout__input">
                                 <p>ISBN으로 책검색</p>
                                 <input type="text" name="isbn" id="isbn" readonly> &nbsp;
                                 <input type="button" class="col-lg-4" value="책검색" id="bookinfocheckbt">
                             </div>
                            <div class="checkout__input">
                                 <p>제목</p>
                                 <input type="text" name="title" id="title">
                            </div>
                            <div class="checkout__input">
                                <p>출간일</p>
                                <input type="text" name="pubdate" id="pubdate" readonly>
                            </div>
                            <div class="checkout__input">
                                <p>작가</p>
                                <input type="text" name="author" id="author" readonly>
                            </div>
                            	<div class="checkout__input">
                                <p>판매가</p>
                                <input type="text" name="price" id="price">
                            </div>
                             <div class="checkout__input">
                                <p>출판사</p>
                                <input type="text" name="publisher" id="publisher" readonly>
                            </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                        	<div class="col-lg-8">
                        		<div class="checkout__input">
                                <p>이미지</p>
                                <input type="text" name="img" id="img" readonly>
                            </div>
                            <div class="checkout__input">
                                <p>내용</p>
                                <input type="text" name="about" id="about">
                            </div>
                            <div>
                            	<select name="category" id="category">
								    <option value="1">철학</option>
								    <option value="3">사회과학</option>
								    <option value="6">예술</option>
								    <option value="8">문학</option>
								</select>
							</div>
                        	</div>
                        </div>
	           		 </div>
	           		 <button type="submit" class="site-btn" id="bookregi" name="bookregi">책등록</button>
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