<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.order.model.OrderDAO"%>
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
	request.setCharacterEncoding("utf-8");

	String no=request.getParameter("no");
	//String bu_userid = request.getParameter("bu_userid");
	
	//2
	OrderDAO dao = new OrderDAO();
	
	int cnt=0;
	try{
		cnt = dao.deleteOrderByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt>0){ %>
		<script type="text/javascript">
			alert('주문이 취소되었습니다.');
			location.href='myorder.jsp';
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert('주문 취소 실패!');
			history.back();
		</script>		
	<%}%>
</body>
</html>