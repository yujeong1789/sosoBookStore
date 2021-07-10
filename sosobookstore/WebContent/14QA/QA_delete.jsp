<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="qaDao" class="com.bookstore.qa.model.qaDAO"/>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String no = request.getParameter("no");
	
	int cnt = 0;
	String msg="공지 삭제 실패", url="/14QA/QA.jsp";
	try{
		cnt = qaDao.deleteqa(Integer.parseInt(no));
		if(cnt>0){
			msg="QA를 삭제했습니다.";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>