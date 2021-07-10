<%@page import="com.bookstore.user.model.UserService"%>
<%@page import="com.bookstore.notice.model.NoticeDAO"%>
<%@page import="com.bookstore.notice.model.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<%
	//공지사항 상세보기 
	
	//parameter 가져오기
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
                        <h2><%=noticeVo.getNh_title() %></h2>
                        <ul>
                            <li><%=noticeVo.getBu_userid() %></li>
                            <li><%=noticeVo.getNh_regdate() %></li>
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
                
                <!-- category인클루드 자리 -->
				<%@ include file="../00inc/notice_category.jsp"%>
                
                <div class="col-lg-8 col-md-7 order-md-1 order-1">
                    <div class="blog__details__text">
                        <h3><%=noticeVo.getNh_title() %></h3>
                        <%=noticeVo.getNh_about() %>
                    
        		<hr>
					<a href="notice.jsp">
						<input type="button" class="site-btn" value="목록으로"">
					</a>
				<!-- 관리자에게만 보이는 옵션 -->
				<%if(mastercheck==UserService.MASTER_USER){%>
					<a href="notice_edit.jsp?no=<%=noticeVo.getNh_no()%>">
						<input type="button" class="site-btn" value="공지 수정">
					</a>
					<a href="notice_delete.jsp?no=<%=noticeVo.getNh_no()%>">
						<input type="button" class="site-btn" value="공지 삭제"">
					</a>
				<%}%>
					</div>
                </div>
            </div>
    </section>
        </div>
    <!-- Blog Details Section End -->

    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->