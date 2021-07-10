<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="noticeDao" class="com.bookstore.notice.model.NoticeDAO"/>
<jsp:useBean id="noticeVo" class="com.bookstore.notice.model.NoticeVO"/>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String no = request.getParameter("no");
	String category=request.getParameter("category");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	noticeVo.setNh_no(Integer.parseInt(no));
	noticeVo.setNk_kind_no(category);
	noticeVo.setNh_title(title);
	noticeVo.setNh_about(content);
	System.out.println("VO : "+noticeVo);
	
	String msg="공지 수정 실패", url="/11notice/notice.jsp";
	try{
		int cnt = noticeDao.updateNotice(noticeVo);
		System.out.println("수정 성공여부 : "+cnt);
		if(cnt>0){
			msg="공지 수정 성공";
			url="/11notice/notice_detail.jsp?no="+no;
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	//
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>