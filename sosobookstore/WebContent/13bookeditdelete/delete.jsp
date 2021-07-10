<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="bookVo" class="com.bookstore.book.model.BookDetailVo" scope="page"></jsp:useBean>
<jsp:useBean id="bookDao" class="com.bookstore.book.model.BookDetailDAO" scope="session"></jsp:useBean>

<%
//1
request.setCharacterEncoding("utf-8");

int no=Integer.parseInt(request.getParameter("no"));
System.out.println(no);

//2
String msg="책 삭제 실패!", url="/13bookeditdelete/bookedit.jsp";

try{	
	int cnt=bookDao.deleteBookDetail(no);
	if(cnt>0){
		msg="책의 정보가 삭제되었습니다";
		url="/10main/index.jsp";
	}
}catch(SQLException e){
	e.printStackTrace();
}

//3	
request.setAttribute("msg", msg);
request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>