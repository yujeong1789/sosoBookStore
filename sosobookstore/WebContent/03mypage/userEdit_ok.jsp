<%@page import="com.bookstore.user.model.UserVO"%>
<%@page import="com.bookstore.user.model.UserService"%>
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
<jsp:useBean id="userService" class="com.bookstore.user.model.UserService" scope="session"></jsp:useBean>
<%
	//1
	request.setCharacterEncoding("utf-8");
	String bu_userid=(String)session.getAttribute("userid");
	
	String bu_password=request.getParameter("pwd");
	String bu_zipcode=request.getParameter("zipcode");
	String bu_address1=request.getParameter("address1");
	String bu_address2=request.getParameter("address2");
	String bu_hp=request.getParameter("bu_hp");
	
	//2
	String msg="비밀번호 체크 실패", url="/03mypage/userEdit.jsp";
	try{
		int result=userService.loginCheck(bu_userid, bu_password);
		if(result==UserService.LOGIN_OK){
			UserVO vo = new UserVO();
			vo.setBu_address1(bu_address1);
			vo.setBu_address2(bu_address2);
			vo.setBu_hp(bu_hp);
			vo.setBu_userid(bu_userid);
			vo.setBu_password(bu_password);
			vo.setBu_zipcode(bu_zipcode);

			int cnt=userService.updateUser(vo);
			System.out.println("cnt : " + cnt);
			if(cnt>0){
				msg="회원정보가 수정되었습니다.";
			}else{
				msg="회원정보 수정 실패!";
			}
		}else if(result==UserService.PWD_DISAGREE){
			msg="비밀번호가 일치하지 않습니다.";
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