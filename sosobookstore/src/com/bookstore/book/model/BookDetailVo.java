package com.bookstore.book.model;

import java.util.Date;

public class BookDetailVo {
	private int bd_no; //NUMBER NOT NULL, /* 상품번호 */
	private String bd_ISBN; //VARCHAR2(60) NOT NULL, /* ISBN */
	private String bd_title; //VARCHAR2(50) NOT NULL, /* 제목 */
	private Date bd_pubdate; //DATE NOT NULL, /* 출간일 */
	private String bd_author; //VARCHAR2(30) NOT NULL, /* 작가 */
	private String bd_image;//VARCHAR2(300), /* 이미지 */
	private String bd_about; //VARCHAR2(3000) NOT NULL, /* 내용 */
	private int bd_price; //NUMBER NOT NULL, /* 판매가 */
	private String bd_publisher; //VARCHAR2(40) NOT NULL, /* 출판사 */
	private int bd_sellcount;// NUMBER, /* 판매수 */
	private String bd_delflag;// VARCHAR2(10), /* 도서삭제 */
	private Date bd_regdate;// DATE DEFAULT sysdate, /* 등록일자 */
	private int bk_kind_no;// NUMBER NOT NULL /* 분류번호 */
	//table join : book_kind
	private String bk_kind_info;
	
	public BookDetailVo() {
		super();
	}

	public BookDetailVo(int bd_no, String bd_ISBN, String bd_title, Date bd_pubdate, String bd_author, String bd_image,
			String bd_about, int bd_price, String bd_publisher, int bd_sellcount, String bd_delflag, Date bd_regdate,
			int bk_kind_no,  String bk_kind_info) {
		super();
		this.bd_no = bd_no;
		this.bd_ISBN = bd_ISBN;
		this.bd_title = bd_title;
		this.bd_pubdate = bd_pubdate;
		this.bd_author = bd_author;
		this.bd_image = bd_image;
		this.bd_about = bd_about;
		this.bd_price = bd_price;
		this.bd_publisher = bd_publisher;
		this.bd_sellcount = bd_sellcount;
		this.bd_delflag = bd_delflag;
		this.bd_regdate = bd_regdate;
		this.bk_kind_no = bk_kind_no;
		this.bk_kind_info = bk_kind_info;
	}

	
	public String getBk_kind_info() {
		return bk_kind_info;
	}

	public void setBk_kind_info(String bk_kind_info) {
		this.bk_kind_info = bk_kind_info;
	}

	public int getBd_no() {
		return bd_no;
	}

	public void setBd_no(int bd_no) {
		this.bd_no = bd_no;
	}

	public String getBd_ISBN() {
		return bd_ISBN;
	}

	public void setBd_ISBN(String bd_ISBN) {
		this.bd_ISBN = bd_ISBN;
	}

	public String getBd_title() {
		return bd_title;
	}

	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}

	public Date getBd_pubdate() {
		return bd_pubdate;
	}

	public void setBd_pubdate(Date bd_pubdate) {
		this.bd_pubdate = bd_pubdate;
	}

	public String getBd_author() {
		return bd_author;
	}

	public void setBd_author(String bd_author) {
		this.bd_author = bd_author;
	}

	public String getBd_image() {
		return bd_image;
	}

	public void setBd_image(String bd_image) {
		this.bd_image = bd_image;
	}

	public String getBd_about() {
		return bd_about;
	}

	public void setBd_about(String bd_about) {
		this.bd_about = bd_about;
	}

	public int getBd_price() {
		return bd_price;
	}

	public void setBd_price(int bd_price) {
		this.bd_price = bd_price;
	}

	public String getBd_publisher() {
		return bd_publisher;
	}

	public void setBd_publisher(String bd_publisher) {
		this.bd_publisher = bd_publisher;
	}

	public int getBd_sellcount() {
		return bd_sellcount;
	}

	public void setBd_sellcount(int bd_sellcount) {
		this.bd_sellcount = bd_sellcount;
	}

	public String getBd_delflag() {
		return bd_delflag;
	}

	public void setBd_delflag(String bd_delflag) {
		this.bd_delflag = bd_delflag;
	}

	public Date getBd_regdate() {
		return bd_regdate;
	}

	public void setBd_regdate(Date bd_regdate) {
		this.bd_regdate = bd_regdate;
	}

	public int getBk_kind_no() {
		return bk_kind_no;
	}

	public void setBk_kind_no(int bk_kind_no) {
		this.bk_kind_no = bk_kind_no;
	}

	@Override
	public String toString() {
		return "BookDetailVo [bd_no=" + bd_no + ", bd_ISBN=" + bd_ISBN + ", bd_title=" + bd_title + ", bd_pubdate="
				+ bd_pubdate + ", bd_author=" + bd_author + ", bd_image=" + bd_image + ", bd_about=" + bd_about
				+ ", bd_price=" + bd_price + ", bd_publisher=" + bd_publisher + ", bd_sellcount=" + bd_sellcount
				+ ", bd_delflag=" + bd_delflag + ", bd_regdate=" + bd_regdate + ", bk_kind_no=" + bk_kind_no
				+ ", bk_kind_info=" + bk_kind_info + "]";
	}
	
}
