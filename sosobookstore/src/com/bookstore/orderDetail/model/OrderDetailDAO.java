package com.bookstore.orderDetail.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;

public class OrderDetailDAO {
	private ConnectionPoolMgr pool;
	
	public OrderDetailDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}
	
	//주문 상세 입력
	public int insertOrderDeatil(OrderDetailDTO dto) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con=pool.getConnection();
			String sql = "insert into orderdetail (od_no, od_qty, o_no, bd_no)\r\n" + 
					"values(orderdetail_seq.nextval, ?, ?, ?)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, dto.getOd_qty());
			ps.setInt(2, dto.getO_no());
			ps.setInt(3, dto.getBd_no());
			int cnt = ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//선택한 결제내역 상세 보기
	public List<OrderDetailDTO> showOrderDetail(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		List<OrderDetailDTO> list = new ArrayList<OrderDetailDTO>();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select o.od_no, b.BD_IMAGE, b.BD_TITLE, o.OD_QTY\r\n" + 
					"from orderdetail o join  bookdetail b\r\n" + 
					"on o.bd_no = b.bd_no\r\n" + 
					"where o_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,no);
			
			//4
			rs= ps.executeQuery();
			while(rs.next()) {
				OrderDetailDTO dto = new OrderDetailDTO();
				dto.setOd_no(rs.getInt("od_no"));
				dto.setBd_image(rs.getString("bd_image"));
				dto.setBd_title(rs.getString("bd_title"));
				dto.setOd_qty(rs.getInt("od_qty"));
				

				list.add(dto);
			}
			System.out.println("주문목록 상품 삭제 결과, list="+list.size()+", 매개변수 o_no="+no);
			
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//합계 불러오기
	public int showTotalPrice(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select sum(o_totalprice)\r\n" + 
					"from bookorder\r\n" + 
					"where o_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,no);
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("주문목록 상품 총 합계구하기, cnt="+cnt+", 매개변수 o_no="+no);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
}
