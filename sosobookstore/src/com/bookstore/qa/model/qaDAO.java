package com.bookstore.qa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;
import com.bookstore.notice.model.NoticeVO;

public class qaDAO {
private ConnectionPoolMgr pool;
	
	public qaDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}
	
	//qa입력
	public int insertqa(qaVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			String sql="insert into qa(qa_no, bu_userid, qk_no, qa_title, qa_about, qa_groupno, qa_step, qa_regdate) " + 
					" values(qa_seq.nextval, ?, ?, ?, ?, qa_seq.CURRVAL, ?, sysdate)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getBu_userid());
			ps.setInt(2, vo.getQk_no());
			ps.setString(3, vo.getQa_title());
			ps.setString(4, vo.getQa_about());
			ps.setInt(5, vo.getQa_step());
			
			//4
			System.out.println("다섯");
			int cnt=ps.executeUpdate();
			System.out.println("여섯");

			System.out.println("qa입력 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int replyqa(qaVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			String sql="insert into qa(qa_no, bu_userid, qk_no, qa_title, qa_about, qa_groupno, qa_step, qa_regdate) " + 
					" values(qa_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getBu_userid());
			ps.setInt(2, vo.getQk_no());
			ps.setString(3, vo.getQa_title());
			ps.setString(4, vo.getQa_about());
			ps.setInt(5, vo.getQa_groupno());
			ps.setInt(6, vo.getQa_step());
			
			//4
			System.out.println("다섯");
			int cnt=ps.executeUpdate();
			System.out.println("여섯");

			System.out.println("qa입력 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//qa수정
	public int editqa(qaVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		try {
			//1,2
			con=pool.getConnection();
			
			String sql="update qa set qa_title = ?, qa_about = ?, qk_no = ? where qa_no = ?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getQa_title());
			ps.setString(2, vo.getQa_about());
			ps.setInt(3, vo.getQk_no());
			ps.setInt(4, vo.getQa_no());
			
			//4
			System.out.println("하나");
			int cnt=ps.executeUpdate();
			System.out.println("둘");

			System.out.println("qa수정 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//qa삭제
	public int deleteqa(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		String yy="Y";
			
		try {
			//1,2
			con=pool.getConnection();
				
			//3
			String sql="update qa set qa_delflag = ? where qa_no = ?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, yy);
			ps.setInt(2, no);
				
			//4
			System.out.println("셋");
			int cnt=ps.executeUpdate();
			System.out.println("넷");

			System.out.println("qa삭제 결과, cnt="+cnt);
				
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//qa총출력
	public List<qaVO> showAll() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		List<qaVO> list = new ArrayList<qaVO>();
		
		try {
			//1,2
			con=pool.getConnection();
				
			//3
			String sql="select qa_no, bu_userid, qk_no, qa_title, qa_about, qa_groupno, qa_step, qa_regdate from qa where QA_DELFLAG is null order by qa_groupno desc, qa_step";
			ps=con.prepareStatement(sql);

			//4
			rs= ps.executeQuery();
			while(rs.next()) {
				qaVO vo = new qaVO();
				vo.setQa_no(rs.getInt("qa_no"));
				vo.setBu_userid(rs.getString("bu_userid"));
				vo.setQk_no(rs.getInt("qk_no"));
				vo.setQa_title(rs.getString("qa_title"));
				vo.setQa_about(rs.getString("qa_about"));
				vo.setQa_groupno(rs.getInt("qa_groupno"));
				vo.setQa_step(rs.getInt("qa_step"));
				vo.setQa_regdate(rs.getTimestamp("qa_regdate"));
				
				list.add(vo);
			}
			System.out.println("qa갯수 : " + list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public qaVO selectByNo(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		try {
			con=pool.getConnection();
			String sql="select * from qa where qa_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			
			rs=ps.executeQuery();
			qaVO vo = new qaVO();
			if(rs.next()) {
				vo.setQa_no(rs.getInt("qa_no"));
				vo.setBu_userid(rs.getString("bu_userid"));
				vo.setQk_no(rs.getInt("qk_no"));
				vo.setQa_title(rs.getString("qa_title"));
				vo.setQa_about(rs.getString("qa_about"));
				vo.setQa_groupno(rs.getInt("qa_groupno"));
				vo.setQa_step(rs.getInt("qa_step"));
				vo.setQa_regdate(rs.getTimestamp("qa_regdate"));
			}
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
