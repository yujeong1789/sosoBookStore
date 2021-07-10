<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.bookstore.book.model.booksearchAPI"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="java.util.List"%>

<jsp:useBean id="booksearchApi" class="com.bookstore.book.model.booksearchAPI" 
scope="session"></jsp:useBean>

<%
request.setCharacterEncoding("utf-8");
String isbn = request.getParameter("isbn");
int cnt=0;
BookDetailVo vo = null;
	if (isbn == null){
		isbn = "";
	}
	System.out.println("isbn확인"+isbn);
try {
	if (isbn != null && !isbn.isEmpty()) {
		System.out.println("isbn검색"+isbn);
		cnt = booksearchApi.bookchekcISBN(isbn);
	}
	if (cnt==booksearchAPI.EXIST_BOOK) {
		System.out.println("객체생성 완료"+cnt);
		vo=booksearchApi.booksearchISBN(isbn);
		vo.setBd_ISBN(isbn);
	}
} catch(IOException e) {
	e.printStackTrace();
}
%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 검색</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/mainstyle.css" />
<style type="text/css">
body {
	margin: 5px;
	padding: 5px;
}

caption {
	visibility: hidden;
}
</style>
<script type="text/javascript" src="../bs/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search').click(function(){
			if($('#isbn').val().length<1){
				alert('코드를 입력하세요');
				$('#isbn').focus();
				event.preventDefault();
			}
		});
		<%if(isbn != null && !isbn.isEmpty()){%>
		$('#btUse').click(function(){
			<%
			Date d=vo.getBd_pubdate();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String to=transFormat.format(d);
			%>
				$(opener.document).find('#isbn').val("<%=vo.getBd_ISBN()%>");
				$(opener.document).find('#title').val("<%=vo.getBd_title()%>");
				$(opener.document).find('#pubdate').val("<%=to%>");
				$(opener.document).find('#author').val("<%=vo.getBd_author()%>");
				$(opener.document).find('#price').val("<%=vo.getBd_price()%>");
				$(opener.document).find('#publisher').val("<%=vo.getBd_publisher()%>");
				$(opener.document).find('#img').val("<%=vo.getBd_image()%>");
				$(opener.document).find('#about').val("<%=vo.getBd_about()%>");
				self.close();
		});
		<%}%>
	});
</script>
</head>
<body>
<h2>책 ISBN으로 검색</h2>
	<br>
	<p>ISBN코드를 입력하세요</p>
	<form name="frm" method="post" action="booksearch.jsp">
		<label for="isbn">ISBN : </label> 
		<input type="text" name="isbn" id="isbn" style="ime-mode: active" value="<%=isbn%>">
		<input type="submit" id="search" value="검색">
	</form>
	
	<br>
	<table style="width: 470px" class="box2"
		summary="ISBN코드를 통해 책 정보를 찾습니다">
		<caption>책 찾기</caption>
		<colgroup>
			<col style="width: 20%" />
			<col style="width: *" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">ISBN</th>
				<th scope="col">제목</th>
				<th scope="col">작가</th>
			</tr>
		</thead>
		<tbody>
		<%if(isbn.length()<1){ %>
			<tr>
				<td colspan="2" style="text-align:center">
					해당하는 책 미존재
				</td>
			</tr>
		<%}else{ %>
			<%
				String isbnq=vo.getBd_ISBN();
				System.out.println("a"+isbnq);
				String author=vo.getBd_author();
				System.out.println("b"+author);
				String title=vo.getBd_title();
				System.out.println("c"+title);
			%>	
				
				<tr>
					<td><%=isbnq%></td>
					<td><%=title%></td>
					<td><%=author%></td>
					<td><input type="button" value="사용하기" id="btUse" name="btUse"></td>
				</tr>
		<%}//if %>
			
		</tbody>
	</table>
</body>
</html>