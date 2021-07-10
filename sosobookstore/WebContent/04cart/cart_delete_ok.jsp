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
	//delete.jsp에서 post방식으로 submit
	//1
	request.setCharacterEncoding("utf-8");

	String c_no=request.getParameter("c_no");
	String bu_userid = request.getParameter("bu_userid");
	
	//2
	cartDAO dao = new cartDAO();
	
	int cnt=0;
	try{
		if(c_no!=null && bu_userid==null)
			cnt=dao.deleteCartByNo(Integer.parseInt(c_no));
		else
			cnt=dao.deleteCartAll(bu_userid);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt>0){ %>
		<script type="text/javascript">
			alert('장바구니에서 삭제되었습니다.');
			location.href='cart.jsp';
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert('도서 삭제 실패!');
			history.back();
		</script>		
	<%}%>
</body>
</html>