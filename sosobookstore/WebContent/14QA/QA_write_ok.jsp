<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.qa.model.qaDAO"%>
<%@page import="com.bookstore.qa.model.qaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice_write_ok.jsp</title>
</head>
<jsp:useBean id="qaDao" class="com.bookstore.qa.model.qaDAO"/>
<jsp:useBean id="qaVo" class="com.bookstore.qa.model.qaVO"/>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String userid=request.getParameter("userid");
	int category=Integer.parseInt(request.getParameter("category"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	//
	String msg="Q 등록 실패", url="/14QA/QA.jsp";
	
	try{
		qaVo.setBu_userid(userid);
		qaVo.setQk_no(category);
		qaVo.setQa_title(title);
		qaVo.setQa_about(content);
		qaVo.setQa_step(0);
		
		int cnt=qaDao.insertqa(qaVo);
		if(cnt>0){
			msg="Q 등록 성공";
			url="/14QA/QA.jsp";
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