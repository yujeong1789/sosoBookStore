package com.bookstore.zipcode.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;



public class ZipcodeDAO {
	private ConnectionPoolMgr pool;
	
	public ZipcodeDAO() {
		pool=ConnectionPoolMgr.getInstance();
	}
	
	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs =null;
		
		List<ZipcodeVO> alist = new ArrayList<ZipcodeVO>();
		try{
			con = pool.getConnection();
			
			String sql="select * from zipcode where z_dong like ?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, dong);
			
			rs = ps.executeQuery();
			
			while(rs.next()){
				String sido = rs.getString("z_sido");
				String gugun = rs.getString("z_gugun");
				dong = rs.getString("z_dong");
				String add1 = rs.getString("z_address1");
				String add2 = rs.getString("z_address2");
				int seq =rs.getInt("z_no");
				String zipcode = rs.getString("z_zipcode");
				ZipcodeVO vo = new ZipcodeVO();
				
				vo.setZ_add1(add1);
				vo.setZ_add2(add2);
				vo.setZ_dong(dong);
				vo.setZ_gugun(gugun);
				vo.setZ_seq(seq);
				vo.setZ_sido(sido);
				vo.setZ_zipcode(zipcode);
				alist.add(vo);
			}
			
			System.out.println("우편번호 조회, alist.size()="+alist.size()
				+", 매개변수 dong="+dong);
			
			return alist;			
		}finally{
			pool.dbClose(rs, ps, con);
		}
	}

}
