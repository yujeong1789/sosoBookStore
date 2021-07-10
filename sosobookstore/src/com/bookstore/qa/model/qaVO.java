package com.bookstore.qa.model;

import java.sql.Timestamp;

public class qaVO {
	int qa_no;	//문의번호
	String bu_userid;//문의자 이름
	int qk_no;//분류번호
	String qa_title;//문의제목
	String qa_about;//문의내용
	int qa_groupno;//문의 그룹번호(질문글, 답글모두 포함되기에 어떤 문의번호로 시작되었는지)
	int qa_step;//몇번째 답글인지
	Timestamp qa_regdate;//등록일
	String qa_delflag;//삭제여부
	
	
	public int getQa_no() {
		return qa_no;
	}
	public void setQa_no(int qa_no) {
		this.qa_no = qa_no;
	}
	public String getBu_userid() {
		return bu_userid;
	}
	public void setBu_userid(String qa_userid) {
		this.bu_userid = qa_userid;
	}
	public int getQk_no() {
		return qk_no;
	}
	public void setQk_no(int qk_no) {
		this.qk_no = qk_no;
	}
	public String getQa_title() {
		return qa_title;
	}
	public void setQa_title(String qa_title) {
		this.qa_title = qa_title;
	}
	public String getQa_about() {
		return qa_about;
	}
	public void setQa_about(String qa_about) {
		this.qa_about = qa_about;
	}
	public int getQa_groupno() {
		return qa_groupno;
	}
	public void setQa_groupno(int qa_groupno) {
		this.qa_groupno = qa_groupno;
	}
	public int getQa_step() {
		return qa_step;
	}
	public void setQa_step(int qa_step) {
		this.qa_step = qa_step;
	}
	public Timestamp getQa_regdate() {
		return qa_regdate;
	}
	public void setQa_regdate(Timestamp qa_regdate) {
		this.qa_regdate = qa_regdate;
	}
	public String getQa_delflag() {
		return qa_delflag;
	}
	public void setQa_delflag(String qa_delflag) {
		this.qa_delflag=qa_delflag;
	}
	
	@Override
	public String toString() {
		return "qaVO [qa_no=" + qa_no + ", bu_userid=" + bu_userid + ", qk_no=" + qk_no + ", qa_title="
				+ qa_title + ", qa_aboutr=" + qa_about + ", qa_groupno=" + qa_groupno + ", qa_step=" + qa_step
				+ ", qa_regdate=" + qa_regdate + ", qa_delflag=" + qa_delflag + "]";
	}
	
	
}