<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.notice.model.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice_write_ok.jsp</title>
</head>
<jsp:useBean id="noticeDao" class="com.bookstore.notice.model.NoticeDAO"/>
<jsp:useBean id="noticeVo" class="com.bookstore.notice.model.NoticeVO"/>
<body>
<%
	//notice_write.jsp에서 post방식으로 이동
	request.setCharacterEncoding("utf-8");

	String userid=request.getParameter("userid");
	String category=request.getParameter("category");
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	//
	String msg="공지 등록 실패", url="/11notice/notice.jsp";
	
	try{
		noticeVo.setBu_userid(userid);
		noticeVo.setNk_kind_no(category);
		noticeVo.setNh_title(title);
		noticeVo.setNh_about(content);
		
		int cnt=noticeDao.insertNotice(noticeVo);
		if(cnt>0){
			msg="공지 등록 성공";
			url="/11notice/notice.jsp";
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