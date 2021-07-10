package com.bookstore.user.model;

import java.sql.SQLException;

public class UserService {
	//아이디 중복확인시 사용
	public static final int EXIST_ID=1;  //아이디가 이미 존재하는 경우
	public static final int NON_EXIST_ID=2; //존재하지 않는 경우
	
	//로그인 처리시 사용
	public static final int LOGIN_OK=1; //로그인 성공
	public static final int ID_NONE=2; //아이디가 없는 경우
	public static final int PWD_DISAGREE=3; //비밀번호 불일치
	
	//관리자체크시 사용
	public static final int NORMAL_USER=0; //일반사용자
	public static final int MASTER_USER=1; //관리자
		
	private UserDAO userDao;
	
	private static UserVO cuserVo;
	
	public UserService() {
		userDao=new UserDAO();
	}
	
	public int insertUser(UserVO vo) throws SQLException {
		int cnt=userDao.insertUser(vo);
		return cnt;
	}
	
	public int checkDup(String userid) throws SQLException {
		return userDao.checkDup(userid);
	}
		
	public int loginCheck(String userid, String pwd) throws SQLException {
		System.out.println("으악");
		return userDao.loginCheck(userid, pwd);
	}
		
	public UserVO selectUser(String userid) throws SQLException {
		return userDao.selectUser(userid);
	}
	
	public int updateUser(UserVO vo) throws SQLException {
		return userDao.updateUser(vo);
	}
	
	public int withdrawUser(String userid) throws SQLException {
		return userDao.withdrawUser(userid);
	}
	
	public int UserMasterCheck(String userid) throws SQLException {
		return userDao.checkMasterUser(userid);
	}
	
	
	public void controllUserInput(String userid) throws SQLException {
		cuserVo=userDao.selectUser(userid);
		System.out.println("유저 로그인 - "+cuserVo.getBu_name());
	}
	public void controllUserOut() throws SQLException {
		cuserVo=null;
		System.out.println("로그아웃");
	}
	public UserVO controllUser() throws SQLException {
		System.out.println("유저 호출 - "+cuserVo.getBu_name());
		return cuserVo;
	}
	
}
