package com.bookstore.book.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bookstore.db.ConnectionPoolMgr;

public class BookDetailDAO {
	private ConnectionPoolMgr pool;
	
	public BookDetailDAO(){
		pool=ConnectionPoolMgr.getInstance();
	}
	
	//[1] 신규 도서 입력
	public int insertBookDetail(BookDetailVo vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into bookdetail(bd_no, bd_ISBN, bd_title, bd_pubdate, bd_author, bd_image, bd_about, bd_price, bd_publisher, bd_sellcount, bd_regdate, bk_kind_no)"+
					"values(BOOKDETAIL_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, 0, sysdate, ?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getBd_ISBN());
			ps.setString(2, vo.getBd_title());
			Timestamp puddate=new Timestamp((vo.getBd_pubdate()).getTime());
			ps.setTimestamp(3, puddate);
			ps.setString(4, vo.getBd_author());
			ps.setString(5, vo.getBd_image());
			ps.setString(6, vo.getBd_about());
			ps.setInt(7, vo.getBd_price());
			System.out.println(vo.getBd_publisher());
			ps.setString(8, vo.getBd_publisher());
			ps.setInt(9, vo.getBk_kind_no());
			
			//4
			System.out.println("하나둘셋");
			int cnt=ps.executeUpdate();
			System.out.println("넷다섯여섯");

			System.out.println("책 등록 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	//[2] 도서 수정
	public int editBookDetail(int no, BookDetailVo vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			//3
			String sql="update bookdetail set bd_about = ?, bd_price = ?, bd_sellcount = ?, bk_kind_no = ? where bd_no=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getBd_about());
			ps.setInt(2, vo.getBd_price());
			ps.setInt(3, vo.getBd_sellcount());
			ps.setInt(4, vo.getBk_kind_no());
			ps.setInt(5, vo.getBd_no());
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("도서수정");

			System.out.println("책 등록 결과, cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//[3] 도서 삭제 - 실제로 테이블에서 삭제하지 말고 delflag만 Y로 바꿔주기
	public int deleteBookDetail(int no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		String yy="Y";
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="update bookdetail set bd_delflag = ? where bd_no=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, yy);
			ps.setInt(2, no);
			
			//4
			System.out.println("붕붕붕");
			int cnt=ps.executeUpdate();
			System.out.println("도서삭제");

			System.out.println("책 삭제 결과, cnt="+cnt);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//[4] 도서 번호로 검색
	public BookDetailVo selectByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		BookDetailVo vo = new BookDetailVo();
		
		try {
			con=pool.getConnection();
			String sql ="select * from bookdetail bd join bookkind bk on bd.bk_kind_no=bk.bk_kind_no and bd.bd_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, no);
			rs=ps.executeQuery();
			if(rs.next()) {
				vo.setBd_about(rs.getString("bd_about"));
				vo.setBd_author(rs.getString("bd_author"));
				vo.setBd_delflag(rs.getString("Bd_delflag"));
				vo.setBd_image(rs.getString("bd_image"));
				vo.setBd_ISBN(rs.getString("bd_isbn"));
				vo.setBd_no(no);
				vo.setBd_price(rs.getInt("bd_price"));
				vo.setBd_pubdate(rs.getDate("bd_pubdate"));
				vo.setBd_publisher(rs.getString("bd_publisher"));
				vo.setBd_regdate(rs.getDate("bd_regdate"));
				vo.setBd_sellcount(rs.getInt("bd_sellcount"));
				vo.setBd_title(rs.getString("bd_title"));
				vo.setBk_kind_info(rs.getString("bk_kind_info"));
			}
			System.out.println("도서 번호 검색 매개변수 : "+no+"\n\n 검색 결과 : "+vo);
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[5] 도서 전체 검색 + 이름, 카테고리로 검색
	public List<BookDetailVo> showAll(String keyword, String condition) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<BookDetailVo> list = new ArrayList<BookDetailVo>();
		try {
			con=pool.getConnection();
			String sql = "select * from bookdetail";
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" where bd_title||bd_author like '%' || ? || '%' and bd_delflag is null ";
				condition=null;
			}
			if(condition!=null && !condition.isEmpty()) {
				sql+=" bd join bookkind bk on bd.bk_kind_no=bk.bk_kind_no and bk.bk_kind_info=? where bd.bd_delflag is null";
				keyword=null;
			}
			if(keyword==null && condition==null) {
				sql+=" where bd_delflag is null";
			}
			sql+=" order by bd_regdate desc";
			ps=con.prepareStatement(sql);
			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			if(condition!=null && !condition.isEmpty()) {
				ps.setString(1, condition);
			}
			rs=ps.executeQuery();
			while(rs.next()) {
				BookDetailVo vo = new BookDetailVo();
				vo.setBd_about(rs.getString("bd_about"));
				vo.setBd_author(rs.getString("bd_author"));
				vo.setBd_delflag(rs.getString("Bd_delflag"));
				vo.setBd_image(rs.getString("bd_image"));
				vo.setBd_ISBN(rs.getString("bd_isbn"));
				vo.setBd_no(rs.getInt("bd_no"));
				vo.setBd_price(rs.getInt("bd_price"));
				vo.setBd_pubdate(rs.getDate("bd_pubdate"));
				vo.setBd_publisher(rs.getString("bd_publisher"));
				vo.setBd_regdate(rs.getDate("bd_regdate"));
				vo.setBd_sellcount(rs.getInt("bd_sellcount"));
				vo.setBd_title(rs.getString("bd_title"));
				list.add(vo);
			}
			System.out.println("도서 전체 검색 갯수"+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[6] 인기도서보여주기 : 판매숫자가 높은 도서 보여주기
	public List<BookDetailVo> showBestseller() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<BookDetailVo> list = new ArrayList<BookDetailVo>();
		try {
			con=pool.getConnection();
			String sql = "SELECT bd_no, bd_title, bd_price, bd_image, \r\n" + 
						"RANK() OVER (ORDER BY bd_sellcount DESC) AS bestseller\r\n" + 
						"FROM bookdetail where bd_delflag is null";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				BookDetailVo vo = new BookDetailVo();
				vo.setBd_no(rs.getInt("bd_no"));
				vo.setBd_price(rs.getInt("bd_price"));
				vo.setBd_title(rs.getString("bd_title"));
				vo.setBd_image(rs.getString("bd_image"));
				list.add(vo);
			}
			System.out.println("베스트셀러 검색 결과 : "+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[7] 최신순으로 상위 8건만 조회 
	public List<BookDetailVo> showMainBook() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<BookDetailVo> list = new ArrayList<BookDetailVo>();
		try {
			con=pool.getConnection();
			String sql = "select*from"
					+ "(select bd_no, bd_title, bd_price, bd_image\r\n"
					+ "    from bookdetail where bd_delflag is null order by bd_regdate desc)"
					+ " where rownum<=8";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				BookDetailVo vo = new BookDetailVo();
				vo.setBd_no(rs.getInt("bd_no"));
				vo.setBd_price(rs.getInt("bd_price"));
				vo.setBd_title(rs.getString("bd_title"));
				vo.setBd_image(rs.getString("bd_image"));
				list.add(vo);
			}
			System.out.println("등록순 상위 8건 조회 결과 : "+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[8] 베스트셀러
	public List<BookDetailVo> showBestBook() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<BookDetailVo> list = new ArrayList<BookDetailVo>();
		try {
			con=pool.getConnection();
			String sql = "select*from\r\n" + 
					"(select bd_no, bd_title, bd_price, bd_image, bd_sellcount\r\n" + 
					"from bookdetail where bd_delflag is null order by BD_SELLCOUNT desc)\r\n" + 
					"where rownum<=8";
			ps=con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				BookDetailVo vo = new BookDetailVo();
				vo.setBd_no(rs.getInt("bd_no"));
				vo.setBd_price(rs.getInt("bd_price"));
				vo.setBd_title(rs.getString("bd_title"));
				vo.setBd_image(rs.getString("bd_image"));
				list.add(vo);
			}
			System.out.println("등록순 상위 8건 조회 결과 : "+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//[9]판매시 판매 수량 판매 누적 업데이트
	public int updateSellCount(int qtyNo, int bdNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con=pool.getConnection();
			String sql="update bookdetail\r\n" + 
					"set BD_SELLCOUNT=BD_SELLCOUNT+?\r\n" + 
					"where bd_no = ?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, qtyNo);
			ps.setInt(2, bdNo);
			
			int cnt = ps.executeUpdate();
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
}
