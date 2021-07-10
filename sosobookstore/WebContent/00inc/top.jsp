<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>sosoBookstore | 소소책방</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="../bs/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="../bs/css/style.css" type="text/css">
    <script src="../bs/js/main.js"></script>
    <script src="../bs/js/ckeditor/ckeditor.js"></script>
    <script src="../bs/js/jquery-3.5.1.min.js"></script>
</head>

<%
	boolean isLogin=false;
	String userid=(String)session.getAttribute("userid");
	String username=(String)session.getAttribute("userName");
	int mastercheck=0;
	System.out.println("session에 남아있는 로그인 아이디 : "+userid+", 회원 이름 : "+username);
	
	if(userid!=null && !userid.isEmpty()){
		isLogin=true; //로그인 된 경우에 true
		mastercheck=(int)session.getAttribute("mastercheck");
		System.out.println("session에 남아있는 관리자 권한 : "+mastercheck);
	}
	
	System.out.println("로그인 여부 isLogin="+isLogin);
%>

<body>
       <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <!-- Header Section Begin -->
    <header class="header">
        <div class="header__top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__left">
                            <ul>
                            <%if(isLogin){ %>
                                <li><%=username %>님 환영합니다.</li>
                            <%} %>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="header__top__right">
							<div class="header__top__right__auth">
							<%if(isLogin){ %>
                                <a href="../02login/logout.jsp"> 로그아웃 </a>
                                <a href="../03mypage/mypage.jsp"> 마이페이지 </a>
							<%}else{%>
                                <a href="../02login/login.jsp"> 로그인 </a>
							<%} %>
                                <a href="../04cart/cart.jsp"> 장바구니 </a>
							<%if(mastercheck==1){ %>
                                <a href="../12bookregister/bookregister.jsp"> 신규도서등록 </a>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="header__logo">
                        <a href="../10main/index.jsp"><img src="../bs/img/logo.png" alt="logo"></a>
                    </div>
                </div>
                <div class="col-lg-7">
                    <nav class="header__menu">
                        <ul>
                        	<!-- active효과 각 페이지 선택했을때만 줄것 -->
                            <li><a href="../10main/index.jsp">Home</a></li>
                            <li><a href="../06search/bookList.jsp">Shop</a></li>
                            <li><a href="#">Community</a>
                                <ul class="header__menu__dropdown">
                                    <li><a href="../11notice/notice.jsp">Notice</a></li>
                                    <li><a href="../14QA/QA.jsp">Q&A</a></li>
                                </ul>
                            </li>
                            <li><a href="../11notice/contact.jsp">Contact</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- Header Section End -->