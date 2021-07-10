<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="qaDao" class="com.bookstore.qa.model.qaDAO"/>
<jsp:useBean id="qaVo" class="com.bookstore.qa.model.qaVO"/>
<body>
<%
	request.setCharacterEncoding("utf-8");

	int no = Integer.parseInt(request.getParameter("no"));
	int category=Integer.parseInt(request.getParameter("category"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	qaVo.setQa_no(no);
	qaVo.setQk_no(category);
	qaVo.setQa_title(title);
	qaVo.setQa_about(content);
	System.out.println("VO : "+qaVo);
	
	String msg="공지 수정 실패", url="/14QA/QA.jsp";
	try{
		int cnt = qaDao.editqa(qaVo);
		
		System.out.println("수정 성공여부 : "+cnt);
		if(cnt>0){
			msg="qa 수정 성공";
			url="/14QA/QA_detail.jsp?no="+no;
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	//
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>