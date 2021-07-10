<%@page import="com.bookstore.notice.model.NoticeDAO"%>
<%@page import="com.bookstore.notice.model.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<script type="text/javascript">
	$(function(){
		$('#title').focus();
		
		$('form[name=frmWrite]').find('input[type=button]').click(function(){
			location.href ='notice.jsp';
		});
		
		$('form[name=frmWrite]').submit(function(){
			if($('#title').val().length<1){
				alert('제목을 입력하세요');
				$('#title').focus();
				event.preventDefault();
			}else if($('#content').val().length<1){
				alert('내용을 입력하세요');
				$('#content').focus();
				event.preventDefault();
			}		
		});
		
	});
</script>

<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	
	NoticeDAO noticeDao = new NoticeDAO();
	NoticeVO noticeVo = noticeDao.selectByNo(Integer.parseInt(no));
	
%>

    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="../bs/img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2>Notice</h2>
                        <ul>
                            <li>공지사항 수정</li>
                        </ul>
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
                    <form name="frmWrite" method="post" action="notice_edit_ok.jsp">
                   		<input type="hidden" name="no" value="<%=noticeVo.getNh_no()%>">
                   		
                   		<!-- 에디터-->
                   		<div name="categoryDiv">
							<select class="selectpicker" id="category" name="category">
								<option value="1" <%if(noticeVo.getNk_kind_no().equals("1")){%> selected <%}%>
								>주문 및 결제</option>
								<option value="2" <%if(noticeVo.getNk_kind_no().equals("2")){%> selected <%}%>
								>반품/교환/환불</option>
								<option value="3" <%if(noticeVo.getNk_kind_no().equals("3")){%> selected <%}%>
								>배송정보</option>
								<option value="4" <%if(noticeVo.getNk_kind_no().equals("4")){%> selected <%}%>
								>기타</option>
								<option value="5" <%if(noticeVo.getNk_kind_no().equals("5")){%> selected <%}%>
								>공지사항</option>
							</select>
						</div><br><br>
						
						<div class="form-group">
						  	<input type="text" class="form-control" placeholder="제목을 입력하세요"
						  		id="title" name="title" value="<%=noticeVo.getNh_title()%>">
						</div><hr>
						<div name="contentDiv" >
							<textarea class="content" id="content" name="content"><%=noticeVo.getNh_about() %></textarea>
							<script type="text/javascript">
								CKEDITOR.replace('content', 
									{height : 500
								});
							</script>
						</div>
					<hr><br> 
					<input type="submit" value="수정" class="site-btn">
					<input type="button" value="글목록" class="site-btn"">
                    </form>
                    
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

<%@ include file="../00inc/footer.jsp"%>