package com.bookstore.cart.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;

public class cartDAO {
	private ConnectionPoolMgr pool;
	
	public cartDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}
	
	/*
	//도서 상세 페이지에서 장바구니 담기
	public int insertCartDetail(int bookNo, int bookQty, String userId) throws SQLException {
		Connection con = null;
		PreparedStatement ps =null;
		
		try {
			con=pool.getConnection();
			String sql="insert into cart(c_no, C_BOOKQTY, bu_userid, bd_no)\r\n" + 
					"values(cart_seq.nextval, ?, ? ,?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, bookQty);
			ps.setString(2, userId);
			ps.setInt(3, bookNo);
			int cnt=ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}*/
	
	//도서 상세페이지에서 장바구니 담기  : 프로시저 사용
	public void insertCartDetail(int bookNo, int bookQty, String userId) throws SQLException {
		Connection con = null;
		CallableStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql ="call insertcart(?,?,?)";
			ps=con.prepareCall(sql);
			ps.setInt(1, bookNo);
			ps.setInt(2, bookQty);
			ps.setString(3, userId);
			
			ps.execute();
			System.out.println("장바구니 담기 매개변수 도서번호 "+bookNo+", 추가수량 : "+bookQty+", 아이디 : "+userId);
			
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//사용자 아이디로 장바구니 내역 보여주기
	public List<cartDTO> showCart(String bu_userid) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<cartDTO> list = new ArrayList<cartDTO>();

		try {
			con = pool.getConnection();
			
			String sql = "select c_no, c_bookqty, c.bd_no, bd_title, bd_image, bd_price" + 
					" from cart c join bookdetail b" + 
					" on c.bd_no = b.bd_no" +
					" and bu_userid=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, bu_userid);
			
			rs= ps.executeQuery();
			while(rs.next()) {
				cartDTO dto = new cartDTO();
				dto.setC_no(rs.getInt("c_no"));
				dto.setC_bookqty(rs.getInt("c_bookqty"));
				dto.setBd_no(rs.getInt("bd_no"));
				dto.setBd_title(rs.getString("bd_title"));
				dto.setBd_price(rs.getInt("bd_price"));
				dto.setBd_image(rs.getString("bd_image"));
				list.add(dto);
			}
			System.out.println("회원의 장바구니 목록 개수 : " + list.size());
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		} 
	}
	
	
	//장바구니에서 상품 삭제하기
		public int deleteCartByNo(int c_no) throws SQLException {
			Connection con=null;
			PreparedStatement ps=null;
			
			try {
				//1,2
				con=pool.getConnection();
				
				//3
				String sql="delete from cart" + 
						" where c_no = ?";
				ps=con.prepareStatement(sql);
				ps.setInt(1, c_no);
				
				//4
				int cnt=ps.executeUpdate();
				System.out.println("장바구니 상품 삭제 결과, cnt="+cnt+", 매개변수 c_no="+c_no);
				
				return cnt;
			}finally {
				pool.dbClose(ps, con);
			}
		}
	
	//장바구니 전체 삭제 
		public int deleteCartAll(String bu_userid) throws SQLException {
			Connection con=null;
			PreparedStatement ps=null;
			
			try {
				//1,2
				con=pool.getConnection();
				
				//3
				String sql="delete from cart" + 
						" where bu_userid=?";
				ps=con.prepareStatement(sql);
				ps.setString(1, bu_userid);
				
				//4
				int cnt=ps.executeUpdate();
				System.out.println("장바구니 상품 삭제 결과, cnt="+cnt+", bu_userid="+bu_userid);
				
				return cnt;
			}finally {
				pool.dbClose(ps, con);
			}
		}
}
