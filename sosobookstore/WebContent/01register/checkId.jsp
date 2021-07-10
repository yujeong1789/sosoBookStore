<%@page import="com.bookstore.user.model.UserService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="useService" 
	class="com.bookstore.user.model.UserService" 
	scope="session"></jsp:useBean>    
<%
	request.setCharacterEncoding("utf-8");
	String userid=request.getParameter("userid");
	
	//2
	int result=0;
	if(userid!=null && !userid.isEmpty()){
		try{
			result=useService.checkDup(userid);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	//3
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>
<script type="text/javascript" src="../bs/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btUse').click(function(){
			$(opener.document).find('#userid').val("<%=userid%>");
			$(opener.document).find('#chkId').val("Y");	
			self.close();
		});
	});
</script>
</head>
<body>
	<h2>아이디 중복 검사</h2><br>
	<form name="frmId" method="post" action="checkId.jsp">
		<input type="text" name="userid" id="userid" 
		 title="아이디입력" value="<%=userid%>">
		<input type="submit" id="submit" value="아이디 확인">
		
		<%
		if(result==UserService.EXIST_ID){%>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요.</p>
	<%	}else if(result==UserService.NON_EXIST_ID){%>
			<input type="button" value="사용하기" id="btUse" name="btUse">
			<p>사용가능한 아이디입니다.[사용하기]버튼을 클릭하세요</p>
	<%	}	%>
	</form>
	
</body>
</html>