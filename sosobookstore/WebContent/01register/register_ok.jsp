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
<jsp:useBean id="userVo" class="com.bookstore.user.model.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="userservice" class="com.bookstore.user.model.UserService" scope="session"></jsp:useBean>

<%
//1
request.setCharacterEncoding("utf-8");

String name=request.getParameter("name");
String userid=request.getParameter("userid");
String password=request.getParameter("password");
String zipcode=request.getParameter("zipcode");
String address1=request.getParameter("address1");
String address2=request.getParameter("address2");
String hp=request.getParameter("hp");

//2
String msg="회원가입 실패!", url="/12.register/register.jsp";

try{
	userVo.setBu_name(name);
	userVo.setBu_userid(userid);
	userVo.setBu_password(password);
	userVo.setBu_zipcode(zipcode);
	userVo.setBu_address1(address1);
	userVo.setBu_address2(address2);
	userVo.setBu_hp(hp);
	
	int cnt=userservice.insertUser(userVo);
	if(cnt>0){
		msg="회원가입되었습니다.";
		url="/02login/login.jsp";
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