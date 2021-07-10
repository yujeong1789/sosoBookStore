package com.bookstore.comment.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;

public class CommentDAO {
	private ConnectionPoolMgr pool;
	
	public CommentDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}
	
	//[1] 도서상세 > 도서리뷰에서 리뷰 리스트 읽어오기
	public List<CommentDTO> bookReview(int no) throws SQLException{
		Connection con =null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CommentDTO> list = new ArrayList<CommentDTO>();
		try { 
			con=pool.getConnection();
			String sql="select s.c_no,s.BD_NO, s.bu_userid, s.SC_ABOUT, s.SC_REGDATE, b.BD_TITLE\r\n" + 
					"from salecomment s join bookdetail b on s.BD_NO = b.BD_NO where s.bd_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			rs=ps.executeQuery();
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setC_no(rs.getInt("c_no"));
				dto.setBd_no(rs.getInt("bd_no"));
				dto.setBu_userid(rs.getString("bu_userid"));
				dto.setSc_about(rs.getString("sc_about"));
				dto.setSc_regdate(rs.getDate("sc_regdate"));
				
				list.add(dto);
			}
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[2] 도서상세페이지에서 리뷰 작성하기
	public int insertReview(int bookNo, String userId, String content) throws SQLException {
		Connection con =null;
		PreparedStatement ps = null;
		try {
			con=pool.getConnection();
			String sql = "insert into salecomment(c_no, bd_no, bu_userid, sc_about, sc_regdate) "
					     + " values(salecomment_seq.nextval, ?, ?, ?, sysdate)";
			ps=con.prepareStatement(sql);
			ps.setInt(1, bookNo);
			ps.setNString(2, userId);
			ps.setString(3, content);
			
			int cnt = ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//[3] 마이페이지>도서리뷰 보기
	public List<CommentDTO> showReview(String bu_userid) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<CommentDTO> list = new ArrayList<CommentDTO>();

		try {
			con = pool.getConnection();
			
			String sql="select s.c_no, s.BD_NO,  s.bu_userid,  s.SC_ABOUT,  s.SC_REGDATE,  b.BD_TITLE" + 
					" from salecomment s join bookdetail b on s.BD_NO = b.BD_NO" + 
					" where bu_userid =?";
			ps = con.prepareStatement(sql);
			ps.setString(1, bu_userid);
			
			rs= ps.executeQuery();
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setC_no(rs.getInt("c_no"));
				dto.setBd_no(rs.getInt("bd_no"));
				dto.setBu_userid(rs.getString("bu_userid"));
				dto.setBd_title(rs.getString("bd_title"));
				dto.setSc_about(rs.getString("sc_about"));
				dto.setSc_regdate(rs.getDate("sc_regdate"));
				list.add(dto);
			}
			System.out.println("회원의 리뷰 목록 개수 : " + list.size());
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		} 
	}
	
	//리뷰 상세보기
	public CommentDTO showReviewByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		CommentDTO dto = new CommentDTO();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select b.bd_image, b.bd_title, b.bd_author, b.bd_price, s.bu_userid, s.sc_regdate, s.SC_ABOUT\r\n" + 
					"from salecomment s join bookdetail b on  s.BD_NO = b.BD_NO\r\n" + 
					"where c_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				dto.setBd_img(rs.getString("bd_image"));
				dto.setBd_title(rs.getString("bd_title"));
				dto.setBd_author(rs.getString("bd_author"));
				dto.setBd_price(rs.getString("bd_price"));
				dto.setBu_userid(rs.getString("bu_userid"));
				dto.setSc_regdate(rs.getDate("sc_regdate"));
				dto.setSc_about(rs.getString("sc_about"));
			}
			System.out.println("리뷰 상세보기 결과 dto="+dto+", 매개변수 no="+no);
			
			return dto;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
