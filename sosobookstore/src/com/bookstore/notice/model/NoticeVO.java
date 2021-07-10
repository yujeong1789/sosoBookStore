package com.bookstore.notice.model;

import java.sql.Timestamp;

public class NoticeVO {
	private int nh_no; //게시번호
	private String bu_userid; //관리자아이디
	private String nk_kind_no; //공지글번호(1, 2, 3...)
	private String nk_kind_info; //공지글종류
	private String nh_title; //공지글 제목
	private String nh_about; //공지글 내용
	private Timestamp nh_regdate; //등록일
	
	public NoticeVO() {
		super();
	}
	
	public NoticeVO(int nh_no, String bu_userid, String nk_kind_no, String nk_kind_info, String nh_title,
			String nh_about, Timestamp nh_regdate) {
		super();
		this.nh_no = nh_no;
		this.bu_userid = bu_userid;
		this.nk_kind_no = nk_kind_no;
		this.nk_kind_info = nk_kind_info;
		this.nh_title = nh_title;
		this.nh_about = nh_about;
		this.nh_regdate = nh_regdate;
	}

	public int getNh_no() {
		return nh_no;
	}

	public void setNh_no(int nh_no) {
		this.nh_no = nh_no;
	}

	public String getBu_userid() {
		return bu_userid;
	}

	public void setBu_userid(String bu_userid) {
		this.bu_userid = bu_userid;
	}

	public String getNk_kind_no() {
		return nk_kind_no;
	}

	public void setNk_kind_no(String nk_kind_no) {
		this.nk_kind_no = nk_kind_no;
	}

	public String getNk_kind_info() {
		return nk_kind_info;
	}

	public void setNk_kind_info(String nk_kind_info) {
		this.nk_kind_info = nk_kind_info;
	}

	public String getNh_title() {
		return nh_title;
	}

	public void setNh_title(String nh_title) {
		this.nh_title = nh_title;
	}

	public String getNh_about() {
		return nh_about;
	}

	public void setNh_about(String nh_about) {
		this.nh_about = nh_about;
	}

	public Timestamp getNh_regdate() {
		return nh_regdate;
	}

	public void setNh_regdate(Timestamp nh_regdate) {
		this.nh_regdate = nh_regdate;
	}

	@Override
	public String toString() {
		return "NoticeVO [nh_no=" + nh_no + ", bu_userid=" + bu_userid + ", nk_kind_no=" + nk_kind_no
				+ ", nk_kind_info=" + nk_kind_info + ", nh_title=" + nh_title + ", nh_about=" + nh_about
				+ ", nh_regdate=" + nh_regdate + "]";
	}

	
	
}
