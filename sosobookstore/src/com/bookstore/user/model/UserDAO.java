package com.bookstore.user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.bookstore.db.ConnectionPoolMgr;

public class UserDAO {
	private ConnectionPoolMgr pool;
	
	public UserDAO() {
		pool=ConnectionPoolMgr.getInstance();
	}
	
	public int insertUser(UserVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into bookuser(bu_userid, bu_name, bu_password, bu_zipcode,"
					+ " bu_address1, bu_address2, bu_hp, bu_regdate, bu_authority)" + 
					"values(?, ?, ?, ?, ?, ?, ?, sysdate, 0)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getBu_userid());
			ps.setString(2, vo.getBu_name());
			ps.setString(3, vo.getBu_password());
			ps.setString(4, vo.getBu_zipcode());
			ps.setString(5, vo.getBu_address1());
			ps.setString(6, vo.getBu_address2());
			ps.setString(7, vo.getBu_hp());
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("회원가입 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int checkDup(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		int result=0;
		try {
			System.out.println("둠둠");
			con=pool.getConnection();
			
			String sql="select count(*) from bookuser" + 
					" where bu_userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				int count=rs.getInt(1);
				if(count>0) {
					result=UserService.EXIST_ID; //이미 존재
				}else {
					result=UserService.NON_EXIST_ID;
				}
			}//if
			
			System.out.println("아이디 중복확인 결과, result="+result
					+", 매개변수 userid="+userid);
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int loginCheck(String userid, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int result=0;
		try {
			con=pool.getConnection();
			System.out.println("아아!");
			String sql="select bu_password from bookuser" + 
					" where bu_userid=? and bu_secdate is null";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbPwd=rs.getString(1);
				if(dbPwd.equals(pwd)) {
					result=UserService.LOGIN_OK;
				}else {
					result=UserService.PWD_DISAGREE;
				}
			}else {
				result=UserService.ID_NONE;
			}
			
			System.out.println("로그인 처리 결과, result="+result
				+", 매개변수 userid="+userid+", pwd="+pwd);
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public UserVO selectUser(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		UserVO vo = new UserVO();
		try {
			con=pool.getConnection();
			
			String sql="select * from bookuser where bu_userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				String id=rs.getString("bu_userid");
				String name=rs.getString("bu_name");
				String password=rs.getString("bu_password");
				String zipcode=rs.getString("bu_zipcode");
				String address1=rs.getString("bu_address1");
				String address2=rs.getString("bu_address2");
				String hp=rs.getString("bu_hp");
				Timestamp regdate=rs.getTimestamp("bu_regdate");
				Timestamp secdate=rs.getTimestamp("bu_secdate");
				int authority=rs.getInt("bu_authority");
				
				vo.setBu_userid(id);
				vo.setBu_name(name);
				vo.setBu_password(password);
				vo.setBu_zipcode(zipcode);
				vo.setBu_address1(address1);
				vo.setBu_address2(address2);
				vo.setBu_hp(hp);
				vo.setBu_regdate(regdate);
				vo.setBu_secdate(secdate);
				vo.setBu_authority(authority);
			}
			System.out.println("회원정보 조회 결과 vo="+vo+", 매개변수 userid="
					+userid);
			
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int updateUser(UserVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update bookuser" + 
					" set bu_hp=?, bu_zipcode=?, bu_address1=?, bu_address2=?" + 
					" where bu_userid= ?";
			
			ps=con.prepareStatement(sql);
			ps.setString(1, vo.getBu_hp());
			ps.setString(2, vo.getBu_zipcode());
			ps.setString(3, vo.getBu_address1());
			ps.setString(4, vo.getBu_address2());
			ps.setString(5, vo.getBu_userid());
			
			int cnt=ps.executeUpdate();
			System.out.println("회원수정 결과 cnt="+cnt+", 매개변수 vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int withdrawUser(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="update bookuser" + 
					" set outdate=sysdate" + 
					" where bu_userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			int cnt=ps.executeUpdate();
			System.out.println("회원탈퇴 결과, cnt="+cnt+", 매개변수 userid="
					+userid);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int checkMasterUser(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		int result=0;
		
		try {
			con=pool.getConnection();
			
			String sql="select bu_authority from bookuser where bu_userid=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
				
			rs=ps.executeQuery();
			if(rs.next()) {
				int count=rs.getInt(1);
				System.out.println("관리자 등급 체크"+rs.getInt(1));	
				if(count==UserService.NORMAL_USER || count==UserService.MASTER_USER) {
					result=count;
				}
			}
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
