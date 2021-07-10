<%@page import="com.bookstore.qa.model.qaDAO"%>
<%@page import="com.bookstore.qa.model.qaVO"%>
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

<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	
	qaDAO qaDao = new qaDAO();
	qaVO qaVo = qaDao.selectByNo(Integer.parseInt(no));
	
	String title="[답변]"+qaVo.getQa_title()+" : 답변드립니다.";
	
%>

    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="../bs/img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2>QA 답변</h2>
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
                    <form name="frmWrite" method="post" action="QA_reply_ok.jsp">
                   		<input type="hidden" name="no" value="<%=qaVo.getQa_no()%>">
                   		<input type="hidden" name="userid" value="<%=userid%>">
                   		<!-- 에디터-->
                   		<div name="categoryDiv">
							<select class="selectpicker" id="category" name="category">
								<option value="1" <%if(qaVo.getQa_groupno()==1){%> selected <%}%>
								>주문 및 결제</option>
								<option value="2" <%if(qaVo.getQa_groupno()==2){%> selected <%}%>
								>반품/교환/환불</option>
								<option value="3" <%if(qaVo.getQa_groupno()==3){%> selected <%}%>
								>배송정보</option>
								<option value="4" <%if(qaVo.getQa_groupno()==4){%> selected <%}%>
								>기타</option>
							</select>
						</div><br><br>
						
						<div class="form-group">
						  	<input type="text" class="form-control" placeholder="제목을 입력하세요"
						  		id="title" name="title" value="<%=title%>">
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
					<input type="submit" value="답변등록" class="site-btn">
					<input type="button" value="글목록" class="site-btn"">
                    </form>
                    
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

<%@ include file="../00inc/footer.jsp"%>