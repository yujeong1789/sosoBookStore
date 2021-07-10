<%@page import="com.bookstore.utility.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bookstore.notice.model.NoticeVO"%>
<%@page import="com.bookstore.notice.model.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>

<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: underline;}
</style>


<%
	request.setCharacterEncoding("utf-8");
	String category=request.getParameter("category");
	
	NoticeDAO noticeDao=new NoticeDAO();
	
	List<NoticeVO>list=null;
	try{
		list=noticeDao.selectNotice(category);
		System.out.println("공지 레코드 수 : "+list.size());
		System.out.println("category="+category);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	
	
%>

    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="../bs/img/blog/details/details-hero.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2>Notice</h2>
                        <ul>
                            <li>고객센터</li>
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
                    <!-- 카테고리 include -->
                    <%@include file="/00inc/notice_category.jsp" %>
	                <div class="col-lg-9 col-md-7 order-md-1 order-1">
	                <!-- 테이블 들어갈 자리 -->
	                <table class="table">
					<thead>
		                	<tr style="text-align: center;">
		                		<th style="width: 10%">번호</th>
		                		<th style="width: 25%">카테고리</th>
		                		<th style="width: 40%">제목</th>
		                		<th style="width: 10%">관리자</th>
		                		<th style="width: 15%">등록일</th>
		                	</tr>
		                </thead>
		                <tbody>
		                <!-- 글목록 출력 -->
		                	<%if(list==null || list.isEmpty()){%>
		                	<tr>
		                		<p>데이터가 존재하지 않습니다</p>
		                	</tr>
		                	<%}else{
		                		for(int i=0; i<list.size();i++){
		                			NoticeVO vo=list.get(i);%>
			                	<tr>
			                		<td><%=vo.getNh_no()%></td>
			                		<td><%=vo.getNk_kind_info()%></td>
			                		<td><a href="notice_detail.jsp?no=<%=vo.getNh_no()%>">
			                			<%=Utility.cutString(vo.getNh_title(), 17) %></a></td>
			                		<td><%=vo.getBu_userid() %></td>
			                		<td><%=sdf.format(vo.getNh_regdate()) %></td>		                	
			                	</tr>
		                		<%}//for %>
		                	<%}//int %>
		                </tbody>
	                </table>
	                <br>
	                <%if(mastercheck>0){ %>
	                <input type="button" class="site-btn" value="글쓰기" 
	                	onclick="location.href='notice_write.jsp'" 
	                		style="text-align: right;">
	                <%} %>
	                </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

<%@ include file="../00inc/footer.jsp"%>