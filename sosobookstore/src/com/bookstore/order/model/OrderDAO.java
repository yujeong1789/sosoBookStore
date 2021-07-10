package com.bookstore.order.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;
import com.bookstore.orderDetail.model.OrderDetailDTO;

public class OrderDAO {
	private ConnectionPoolMgr pool;

	public OrderDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}

	//주문 생성 order insert
	public int insertOrder(OrderDTO dto) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con=pool.getConnection();

			String sql ="insert into bookorder(o_no, bu_userid, o_zipcode, o_address1, o_address2, o_totalprice, o_orderdate)\r\n" + 
					"values(bookorder_seq.nextval, ?, ?, ?, ?, ?, sysdate)";
			ps=con.prepareStatement(sql);
			ps.setString(1, dto.getBu_userid());
			ps.setString(2, dto.getO_zipcode());
			ps.setString(3, dto.getO_address1());
			ps.setString(4, dto.getO_address2());
			ps.setInt(5, dto.getO_totalPrice());
			int cnt = ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	//특정 회원아이디로 3초안에 주문이 들어간 것의 주문 번호를 구하기
	public int selectOrderByTime(String userid) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con=pool.getConnection();
			String sql ="SELECT o_no FROM bookorder\r\n" + 
					"WHERE o_orderdate >= SYSDATE - 1/((24*60*60)*3) and bu_userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			int no = 0;
			if(rs.next()) {
				no = rs.getInt("o_no");
			}
			return no;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	//주문취소 -> del falg만 Y로 update하기
	public int deleteOrder(int o_no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con=pool.getConnection();

			String sql ="update bookorder\r\n" + 
					"set o_delflag='Y'\r\n" + 
					"where o_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, o_no);

			int cnt=ps.executeUpdate();
			System.out.println("주문취소 결과, cnt="+cnt+", 매개변수 o_no="
					+o_no);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	//회원의 전체 주문목록 보기
	public List<OrderDTO> showAllOrder(String userid) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<OrderDTO> list = new ArrayList<OrderDTO>();

		try {
			con = pool.getConnection();

			String sql = "select *\r\n" + 
					"from bookorder\r\n" + 
					"where bu_userid = ?"
					+ "order by o_no desc";
			ps = con.prepareStatement(sql);
			ps.setString(1, userid);

			rs= ps.executeQuery();
			while(rs.next()) {
				OrderDTO dto = new OrderDTO();
				dto.setO_no(rs.getInt("o_no"));
				dto.setO_zipcode(rs.getString("o_zipcode"));
				dto.setO_address1(rs.getString("o_address1"));
				dto.setO_address2(rs.getString("o_address2"));
				dto.setO_delflag(rs.getString("o_delflag"));
				dto.setO_totalPrice(rs.getInt("o_totalPrice"));
				dto.setO_orderdate(rs.getTimestamp("o_orderdate"));

				list.add(dto);
			}
			System.out.println("회원의 주문 목록 개수 : " + list.size());
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		} 
	}

	//주문 내역 - 기록은 남겨두기
	public int deleteOrderByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;

		try {
			//1,2
			con=pool.getConnection();

			//3
			String sql="update bookorder\r\n" + 
					"set o_delflag='Y'\r\n" + 
					"where o_no = ?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,no);

			//4
			int cnt=ps.executeUpdate();
			System.out.println("주문목록 상품 삭제 결과, cnt="+cnt+", 매개변수 o_no="+no);

			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

}
