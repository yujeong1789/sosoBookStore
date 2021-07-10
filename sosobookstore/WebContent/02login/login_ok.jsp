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
<jsp:useBean id="userservice" class="com.bookstore.user.model.UserService" scope="session"></jsp:useBean>
<jsp:useBean id="userVO" class="com.bookstore.user.model.UserVO" scope="session"></jsp:useBean>
	<%
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("userid");
	String pwd = request.getParameter("password");

	String msg = "로그인 처리 실패", url = "/02login/login.jsp";
	try {
		System.out.println(userid + "비명" + pwd);
		int result = userservice.loginCheck(userid, pwd);

		if (result == UserService.LOGIN_OK) {
			session.setAttribute("userid", userid);
			userVO = userservice.selectUser(userid);
			session.setAttribute("userName", userVO.getBu_name());
			
			msg = userVO.getBu_name() + "님 로그인되었습니다.";
			session.setAttribute("mastercheck", UserService.NORMAL_USER);
			
			if(userservice.UserMasterCheck(userid)==UserService.MASTER_USER){
				msg = userVO.getBu_name() + "관리자님 로그인되었습니다.";
				session.setAttribute("mastercheck", UserService.MASTER_USER);
			}

			url = "/10main/index.jsp";//로그인 성공시 메인페이지로 이동
			
		} else if (result == UserService.PWD_DISAGREE) {
			msg = "비밀번호가 일치하지 않습니다.";
		} else if (result == UserService.ID_NONE) {
			msg = "해당 아이디가 존재하지 않습니다.";
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	//3
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	
	%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>