
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bookstore.user.model.UserService"%>
<%@page import="com.bookstore.user.model.UserVO"%>
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
SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

String isbn=request.getParameter("isbn");
String title=request.getParameter("title");
System.out.println("rbjenrbhresthjiep"+request.getParameter("pubdate"));
Date puddate=transFormat.parse(request.getParameter("pubdate"));
String img=request.getParameter("img");
String about=request.getParameter("about");
String author=request.getParameter("author");
int price=Integer.parseInt(request.getParameter("price"));
String publisher=request.getParameter("publisher");
int kindno=Integer.parseInt(request.getParameter("category"));
System.out.println("카테고리 "+kindno);

//2
String msg="책 등록 실패!", url="/12bookregister/bookregister.jsp";

try{
	bookVo.setBd_ISBN(isbn);
	bookVo.setBd_title(title);
	bookVo.setBd_pubdate(puddate);
	bookVo.setBd_image(img);
	bookVo.setBd_about(about);
	bookVo.setBd_author(author);
	bookVo.setBd_price(price);
	bookVo.setBd_publisher(publisher);
	bookVo.setBk_kind_no(kindno);
	
	int cnt=bookDao.insertBookDetail(bookVo);
	if(cnt>0){
		msg="책이 등록되었습니다.";
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