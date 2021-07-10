<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@page import="com.bookstore.orderDetail.model.OrderDetailDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.order.model.OrderDAO"%>
<%@page import="com.bookstore.order.model.OrderDTO"%>
<%@page import="com.bookstore.orderDetail.model.OrderDetailDTO"%>
<%@page import="com.bookstore.cart.model.cartDTO"%>
<%@page import="java.util.List"%>
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
request.setCharacterEncoding("utf-8");
//1. 회원 정보와 주소 파라미터 값 가져오기
String userid = (String)session.getAttribute("userid");
String totalPrice = request.getParameter("totalPrice");
String name = request.getParameter("name");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String hp = request.getParameter("hp");
String email = request.getParameter("email");

//2. bookorder테이블에 주문 배송지 정보 넣으면서 주문 정보 생성하기
OrderDTO oDto = new OrderDTO();
oDto.setBu_userid(userid);
oDto.setO_address1(address1);
oDto.setO_address2(address2);
oDto.setO_zipcode(zipcode);
oDto.setO_totalPrice(Integer.parseInt(totalPrice));

OrderDAO oDao = new OrderDAO();
int od_no = 0; // 이 회원이 방금 주문한 주문번호 구하기
int oCnt =0;
try{
	oCnt = oDao.insertOrder(oDto);
	System.out.println("주문 입력 성공 cnt : "+oCnt);
	od_no = oDao.selectOrderByTime(userid);
}catch(SQLException e){
	e.printStackTrace();
}

//3. 장바구니를 회원 아이디로 검색해서 다 가져오면서 오더 상세에 넣기
cartDAO cartDao = new cartDAO();
List<cartDTO> cartList=cartDao.showCart(userid);
int odCnt = 0;
OrderDetailDAO odDao = new OrderDetailDAO();
BookDetailDAO bookDao = new BookDetailDAO();

try{
	if(oCnt>0){
		for(cartDTO n : cartList){
			System.out.println("장바구니 내역들 : "+n);
			
			OrderDetailDTO odDto = new OrderDetailDTO();
			odDto.setBd_no(n.getBd_no());//상품번호
			odDto.setOd_qty(n.getC_bookqty()); //수량
			//3-1 해당 상품번호에 주문 수량으로 판매 횟수 누적해주기
			odDto.setO_no(od_no); //주문번호
			odCnt = odDao.insertOrderDeatil(odDto);
			System.out.println("주문상세 입력 내역 : "+odDto);
			int cnt = bookDao.updateSellCount(n.getC_bookqty(), n.getBd_no());
			System.out.println("해당 도서 구매 갯수 업데이트 완료? cnt : "+cnt);
		}
	}
}catch(SQLException e){
	e.printStackTrace();
}

//4. 주문에 성공하면 장바구니 내역 삭제하기
int delOk = 0;
try{
	if(odCnt>0){
		delOk = cartDao.deleteCartAll(userid);
		System.out.println("장바구니 내역 삭제 내역 : "+delOk);
	}
}catch(SQLException e){
	e.printStackTrace();
}

//5.
String msg = "구매 실패했습니다.", url ="/05checkout/checkOut.jsp";
if(delOk>0){
	msg = "주문을 완료 했습니다. 구매감사합니다.";
	url = "/10main/index.jsp";
}
request.setAttribute("msg", msg);
request.setAttribute("url", url);
%>
<jsp:forward page="../09common/message.jsp"></jsp:forward>
</body>
</html>