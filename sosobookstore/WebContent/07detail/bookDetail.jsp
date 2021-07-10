<%@page import="com.bookstore.user.model.UserService"%>
<%@page import="com.bookstore.cart.model.cartDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.bookstore.comment.model.CommentDTO"%>
<%@page import="com.bookstore.comment.model.CommentDAO"%>
<%@page import="com.bookstore.book.model.BookDetailVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.bookstore.book.model.BookDetailDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../00inc/top.jsp"%>
<%@ include file="../00inc/search.jsp"%>
<head>
<script type="text/javascript">
	$(function(){
		var qty = $('.pro-qty input').val() * 1;
		console.log(qty);
		
		$('.pro-qty .dec').click(function(){
		  if(qty === 1){
		    alert("0개 이상의 수량을 입력해주세요.");
		    console.log(qty);
		  } else {
		    $('.pro-qty input').val(qty);
		    qty -= 1;
		    console.log(qty);
		    $('#bookQty').val(qty);
		  }
		});

		$('.pro-qty .inc').click(function(){
		    $('.pro-qty input').val(qty);
		    qty += 1;
		    console.log(qty);
		    $('#bookQty').val(qty);
		});
		
		$('form[name=addCart]').submit(function(){
			if(<%=userid%>===null){
				alert("로그인 후 이용 가능합니다.");
				event.preventDefault();
			}
		});
		
		$('form[name=riviewFrm]').submit(function(){
			if(!$('#reviewContainer').val()){
				alert("내용을 입력해주세요.");
				event.preventDefault();
			}else if($('#reviewContainer').val().length>1000){
				alert("1000자 이하의 내용만 등록 가능합니다.");
				event.preventDefault();
			}else if(<%=userid%>===null){
				alert("로그인 후 이용 가능합니다.");
				event.preventDefault();
			}
		});

	});
</script>
</head>
<body>
	<%
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){
		%>
	<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href='/sosobookstore/06search/bookList.jsp';
		</script>
	<%
		return;
	}
	int intNo = Integer.parseInt(no);
	System.out.print("파라미터로 받은 no:"+intNo);
	
	//2-1
	//[[도서 정보 가져오기]]
	BookDetailDAO bookDao = new BookDetailDAO();
	BookDetailVo vo = null;
	try{
		vo = bookDao.selectByNo(intNo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//[[댓글 가져오기]]
	CommentDAO comDao = new CommentDAO();
	List<CommentDTO> list = null;
	try{
		list=comDao.bookReview(intNo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	int comCnt=list.size();
	
	//3
	//도서 소개 줄임
	String content = vo.getBd_about();
	String shortCont = vo.getBd_about();
	if(content.length()>90){
		shortCont = content.substring(0, 90)+"...";
	}
	
%>
	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="../bs/img/breadcrumb.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb__text">
						<h2><%=vo.getBd_title() %></h2>
						<div class="breadcrumb__option">
							<a href="../10main/index.jsp">Home</a><a><%=vo.getBk_kind_info() %></a>
							<span>도서 상세</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Product Details Section Begin -->
	<section class="product-details spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6">
					<div class="product__details__pic">
						<div class="product__details__pic__item">
							<img class="product__details__pic__item--large"
								src="<%=vo.getBd_image() %>" alt="도서 이미지">
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-6">
					<div class="product__details__text">
						<h3><%=vo.getBd_title() %></h3>
						<div class="product__details__rating">
							<span><%=comCnt %>개의 리뷰가 있습니다.</span>
						</div>
							<div class="product__details__price"><%=df.format(vo.getBd_price()) %>원</div>
							<p><%=shortCont%></p>
						
						<!-- 장바구니 담기 -->
						<form name="addCart" action="addCart_ok.jsp" method="post">
							<div class="product__details__quantity">
								<div class="quantity">
									<div class="pro-qty">
										<input type="text" value="1"> 
									</div>
								</div>
							</div>
							<input type="hidden" value="1" id="bookQty" name="bookQty">
							<input type="hidden" value="<%=vo.getBd_no() %>" id="bookNo" name="bookNo">
							<input type="submit" class="site-btn" value="ADD TO CARD">
						</form>
						<!-- 장바구니 담기 완료 -->
						
						<ul>
							<li><b>작가</b> <span><%=vo.getBd_author() %></span></li>
							<li><b>출판사</b> <span><%=vo.getBd_publisher() %> </span></li>
							<li><b>출판일</b> <span><%=vo.getBd_pubdate() %></span></li>
							<li><b>장르</b> <span><%=vo.getBk_kind_info() %></span></li>
						</ul>
						
						<!-- 관리자에게만 보이는 옵션 -->
						<%
						if(mastercheck==UserService.MASTER_USER){
							%>
							<a href="../13bookeditdelete/delete.jsp?no=<%=vo.getBd_no() %>">
								<input type="button" class="site-btn" value="도서 삭제" style="background-color:'red'">
							</a>
							
							<a href="../13bookeditdelete/bookedit.jsp?no=<%=vo.getBd_no() %>">
								<input type="button" class="site-btn" value="도서 수정">
							</a>
							<%
						}
						%>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="product__details__tab">
						<ul class="nav nav-tabs" role="tablist">
							<li class="nav-item"><a class="nav-link active"
								data-toggle="tab" href="#tabs-1" role="tab" aria-selected="true">도서
									소개</a></li>

							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								href="#tabs-3" role="tab" aria-selected="false">Reviews <span>(<%=comCnt %>)
								</span></a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tabs-1" role="tabpanel">
								<div class="product__details__tab__desc">
									<h6>도서 소개</h6>
									<p><%=content %></p>
								</div>
							</div>
							<div class="tab-pane" id="tabs-3" role="tabpanel">
								<div class="product__details__tab__desc">
									<div class="row">
										<div class="col-lg-12">
											<div class="shoping__cart__table">
												<table>
													<thead>
														<tr>
															<th class="shoping__product">리뷰</th>
															<th></th>
															<th>작성자</th>
															<th>작성일</th>
														</tr>
													</thead>
													<tbody>
														<%if(list!=null && !list.isEmpty()){ 
				                            				for(int i=0;i<list.size();i++){
				                            				CommentDTO dto = new CommentDTO();
				                            				dto = list.get(i);
				                            				%>
														<tr>
															<td class="shoping__cart__item">
																<h5><%=dto.getSc_about() %></h5>
															</td>
															<td></td>
															<td class="shoping__cart__price">
																<h5><%=dto.getBu_userid() %></h5>
															</td>
															<td class="shoping__cart__total">
																<h5><%=dto.getSc_regdate() %></h5>
															</td>
															
														</tr>
														<%}//for
                                					}else{%>
                                					<td colspan="4">아직 등록된 리뷰가 없습니다.</td>
                                					<%} %>
													</tbody>
												</table>
												
												<!-- 리뷰 작성하기 -->
												<div class="contact-form spad">
											        <div class="container">
											            <div class="row">
											                <div class="col-lg-12">
											                    <div class="contact__form__title">
											                        <h2>리뷰 등록</h2>
											                    </div>
											                </div>
											            </div>
											            <form action="addCommentDetail_ok.jsp" name="riviewFrm" method="post" >
											                <div class="row">
											                    <div class="col-lg-12 text-center">
											                    	<input type="hidden" value="<%=vo.getBd_no()%>" name="bdNoForRivew">
											                        <textarea placeholder="최대 1000자 까지 가능합니다." name="rivewCont" id="reviewContainer"></textarea>
											                        <button type="submit" class="site-btn">리뷰 등록하기</button>
											                    </div>
											                </div>
											            </form>
											        </div>
											    </div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Product Details Section End -->
	
    <!-- Footer Section Begin -->
	<%@include file="../00inc/footer.jsp" %>
    <!-- Footer Section End -->
</body>
</html>