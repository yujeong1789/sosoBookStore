<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<script type="text/javascript">
	$(function(){
		$('#title').focus();
		
		$('form[name=frmWrite]').find('input[type=button]').click(function(){
			location.href ='QA.jsp';
		});
		
		$('form[name=frmWrite]').submit(function(){
			if($('#title').val().length<1){
				alert('제목을 입력하세요');
				$('#title').focus();
				event.preventDefault();
			}	
		});
		
	});
</script>

    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="../bs/img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2>QA</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Hero End -->

    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-5 order-md-1 order-2">
                
                	<!-- frmWrite -->
                    <form name="frmWrite" method="post" action="QA_write_ok.jsp">
                   		<input type="hidden" name="userid" id="userid" value="<%=userid%>">
                   		
                   		<!-- 에디터-->
                   		<div name="categoryDiv">
							<select class="selectpicker" id="category" name="category">
								<option value="1">배송문의</option>
								<option value="2">상품문의</option>
								<option value="3">계정문의</option>
								<option value="4">기타문의</option>
							</select>
						</div><br><br>
						
						<div class="form-group">
						  	<input type="text" class="form-control" placeholder="제목을 입력하세요"
						  		id="title" name="title">
						</div><hr>
						<div name="contentDiv" >
							<textarea class="content" id="content" name="content"></textarea>
							<script type="text/javascript">
								CKEDITOR.replace('content', 
									{height : 500
								});
							</script>
						</div>
					<hr><br> 
					<input type="submit" value="등록" class="site-btn">
					<input type="button" value="글목록" class="site-btn"">
                    </form>
                    
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

<%@ include file="../00inc/footer.jsp"%>