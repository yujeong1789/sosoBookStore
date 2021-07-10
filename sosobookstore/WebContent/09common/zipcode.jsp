<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<jsp:useBean id="zipDao" class="com.bookstore.zipcode.model.ZipcodeDAO" 
	scope="session"></jsp:useBean>   	
<%
	request.setCharacterEncoding("utf-8");
	String dong = request.getParameter("dong");
	
	if (dong == null)dong = "";
	
	List<ZipcodeVO> list = null;
	try {
		if (dong != null && !dong.isEmpty()) {
			list = zipDao.selectZipcode(dong);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		$('#submit').click(function(){
			if($('#dong').val().length<1){
				alert('지역명을 입력하세요');
				$('#dong').focus();
				event.preventDefault();
			}
		});
	});
	
	function setZipcode(address, zipcode){
		$(opener.document).find('#zipcode').val(zipcode);
		$(opener.document).find('input[name=add1]').val(address);
		$(opener.document).find('input[name=address1]').val(address);
		self.close();
	}
</script>
</head>
<body>
	<h2>우편번호 검색</h2>
	<br>
	<p>찾고 싶으신 주소의 동(읍/면)을 입력하세요</p>
	<form name="frmZipcode" method="post" action="zipcode.jsp">
		<label for="dong">지역명 : </label> 
		<input type="text" name="dong"
			id="dong" style="ime-mode: active"> 
		<input type="submit" id="submit" value="찾기">
	</form>
	
	<br>
	<table style="width: 470px" class="box2"
		summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
		<caption>우편번호 검색</caption>
		<colgroup>
			<col style="width: 20%" />
			<col style="width: *" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">우편번호</th>
				<th scope="col">주소</th>
			</tr>
		</thead>
		<tbody>
		<%if(list==null || list.isEmpty()){ %>
			<tr>
				<td colspan="2" style="text-align:center">
					해당하는 주소가 없습니다
				</td>	
			</tr>
		<%}else{ %>
			<!-- 반복 시작 -->
			<%for(ZipcodeVO vo : list){ 
				String address=vo.getZ_sido()+" " + vo.getZ_gugun() 
					+" " + vo.getZ_dong();
				String sbunji=vo.getZ_add1();
				String ebunji=vo.getZ_add2();
				
				String bunji="";
				if(ebunji!=null && !ebunji.isEmpty()){
					bunji=sbunji +" ~ " + ebunji;	
				}else{
					bunji=sbunji;
				}
				
				String zipcode=vo.getZ_zipcode();%>	
				
				<tr>
					<td><%=zipcode%></td>
					<td><a href="#" 
				onclick="setZipcode('<%=address%>','<%=zipcode%>')">
						<%=address %> <%=bunji %>
						</a>
					</td>
				</tr>
			<%}//for %>
			<!-- 반복 끝 -->
		<%}//if %>
			
		</tbody>
	</table>
</body>
</html>