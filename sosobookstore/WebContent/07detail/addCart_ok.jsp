<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//1
	//bookDetail에서 post방식으로 submit
	request.setCharacterEncoding("utf-8");
	String bookQ = request.getParameter("bookQty");
	String bookN = request.getParameter("bookNo");
	int bookQty = Integer.parseInt(bookQ);
	int bookNo = Integer.parseInt(bookN);
	String userId = (String)session.getAttribute("userid");
	System.out.println("받아온 회원아이디 : "+userId);
	
	//2
	
	cartDAO dao = new cartDAO();
	String msg ="", url="";
	try{
		dao.insertCartDetail(bookNo	, bookQty, userId);
		msg="장바구니에 "+bookQty+"권의 도서가 담겼습니다.";
		url="/07detail/bookDetail.jsp?no="+bookNo;
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>