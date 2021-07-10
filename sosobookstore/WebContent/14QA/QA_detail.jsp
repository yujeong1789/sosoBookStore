<%@page import="com.bookstore.user.model.UserService"%>
<%@page import="com.bookstore.qa.model.qaDAO"%>
<%@page import="com.bookstore.qa.model.qaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<%
	//공지사항 상세보기 
	
	//parameter 가져오기
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	
	qaDAO qaDao = new qaDAO();
	qaVO qaVo = qaDao.selectByNo(Integer.parseInt(no));
	
	System.out.println(qaVo.getBu_userid());
	System.out.println(userid);
%>
    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="../bs/img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2><%=qaVo.getQa_title() %></h2>
                        <ul>
                            <li><%=qaVo.getBu_userid() %></li>
                            <li><%=qaVo.getQa_regdate() %></li>
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
                        <h3><%=qaVo.getQa_title() %></h3>
                        <%=qaVo.getQa_about() %>
                    </div>
                </div>
            </div>
	<!-- 관리자에게만 보이는 옵션 -->
        		<hr>
				<%
				if(mastercheck==UserService.NORMAL_USER && qaVo.getBu_userid().equals(userid)){
					%>
					<a href="QA_delete.jsp?no=<%=qaVo.getQa_no() %>">
						<input type="button" class="site-btn" value="qa삭제"">
					</a>
					<a href="QA_edit.jsp?no=<%=qaVo.getQa_no() %>">
						<input type="button" class="site-btn" value="qa수정">
					</a>
					<%
				}else if(mastercheck==UserService.MASTER_USER){
					%>
					<a href="QAreply.jsp?no=<%=qaVo.getQa_no() %>">
						<input type="button" class="site-btn" value="답변하기">
					</a>
					<a href="QA_delete.jsp?no=<%=qaVo.getQa_no() %>">
						<input type="button" class="site-btn" value="qa삭제"">
					</a>
					<%
				}
				%>
    </section>
    <%System.out.println(qaVo.getQa_groupno()); %>
        </div>
    <!-- Blog Details Section End -->

    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->