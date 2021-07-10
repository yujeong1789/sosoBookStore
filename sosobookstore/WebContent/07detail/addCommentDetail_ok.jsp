<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.comment.model.CommentDAO"%>
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
	
	String bookNo = request.getParameter("bdNoForRivew");
	String comment = request.getParameter("rivewCont");
	//사용자 아이디 나중에 꼭 받아오기
	String userId = "testuser";
	//2
	CommentDAO dao = new CommentDAO();
	int cnt=0;
	try{
		cnt = dao.insertReview(Integer.parseInt(bookNo), userId, comment);
	}catch(SQLException e){
		e.printStackTrace();
	}
	String msg="댓글 달기 실패", url="/07detail/bookDetail.jsp?no="+bookNo;
	if(cnt>0){
		msg="도서의 리뷰를 작성했습니다.";
		System.out.println("댓글달기 성공여부 : "+cnt);
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>