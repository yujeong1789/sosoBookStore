package com.bookstore.notice.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;

public class NoticeDAO {
	private ConnectionPoolMgr pool;
	
	public NoticeDAO() {
		pool=ConnectionPoolMgr.getInstance();
	}
	
	 //공지 전체출력+카테고리별 출력
	   public List<NoticeVO> selectNotice(String category) throws SQLException{
	      Connection con=null;
	      PreparedStatement ps=null;
	      ResultSet rs=null;
	      
	      List<NoticeVO> list=new ArrayList<NoticeVO>();
	      try {
	         con=pool.getConnection();
	         
	         String sql="select*from"
	               + " Notice_Help a join noticekind b"
	               + " on a.nk_kind_no=b.NK_KIND_NO";
	         if(category!=null && !category.isEmpty()) {
	            sql+=" where b.NK_KIND_NO=?";
	         }
	         sql+=" order by nh_regdate desc";
	         ps=con.prepareStatement(sql);
	         
	         if(category!=null && !category.isEmpty()) {
	        	 ps.setString(1, category);
	         }
	         
	         rs=ps.executeQuery();
	         while(rs.next()) {
	            NoticeVO vo=new NoticeVO();
	            vo.setBu_userid(rs.getString("bu_userid"));
	            vo.setNh_about(rs.getString("nh_about"));
	            vo.setNh_no(rs.getInt("nh_no"));
	            vo.setNh_regdate(rs.getTimestamp("nh_regdate"));
	            vo.setNh_title(rs.getString("nh_title"));
	            vo.setNk_kind_info(rs.getString("nk_kind_info"));
	            vo.setNk_kind_no(rs.getString("nk_kind_no"));
	            list.add(vo);
	         }
	         System.out.println("공지 검색 갯수"+list.size());
	         return list;
	      }finally {
	         pool.dbClose(rs, ps, con);
	      }
	      
	   }//
	
	//공지글 등록
	public int insertNotice(NoticeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="insert into notice_help(nh_no, bu_userid, "
					+ "	nk_kind_no, nh_title, nh_about)"
					+ " values(notice_help_seq.nextval, ?, ?, ?, ?)";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getBu_userid());
			ps.setString(2, vo.getNk_kind_no());
			ps.setString(3, vo.getNh_title());
			ps.setString(4, vo.getNh_about());
			
			int cnt=ps.executeUpdate();
			System.out.println("공지글 등록 결과="+cnt+", 매개변수 vo"+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//공지 상세 확인
	public NoticeVO selectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		try {
			con=pool.getConnection();
			String sql="select * from NOTICE_HELP where nh_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			
			rs=ps.executeQuery();
			NoticeVO vo = new NoticeVO();
			if(rs.next()) {
				vo.setNh_no(no);
				vo.setBu_userid(rs.getString("bu_userid"));
				vo.setNk_kind_no(rs.getString("nk_kind_no"));
				vo.setNh_title(rs.getString("nh_title"));
				vo.setNh_about(rs.getString("nh_about"));
				vo.setNh_regdate(rs.getTimestamp("NH_REGDATE"));
			}
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//공지 수정
	public int updateNotice(NoticeVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		System.out.println("수정 매개변수 vo : "+vo);
		
		try {
			con=pool.getConnection();
			String sql="update NOTICE_HELP\r\n" + 
						"set nk_kind_no=?, nh_title=?, nh_about=?\r\n" + 
						"where nh_no=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getNk_kind_no());
			ps.setString(2, vo.getNh_title());
			ps.setString(3, vo.getNh_about());
			ps.setInt(4, vo.getNh_no());
			int cnt = ps.executeUpdate();
			System.out.println("수정 매개변수 vo : "+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//공지 삭제
	public int deleteBook(int no)throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		System.out.println("매개변수 no : "+no);
		try {
			con=pool.getConnection();
			String sql="delete from NOTICE_HELP where nh_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			int cnt = ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
