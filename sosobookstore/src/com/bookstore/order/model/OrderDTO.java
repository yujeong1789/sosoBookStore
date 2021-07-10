package com.bookstore.order.model;

import java.sql.Timestamp;
import java.util.Date;

public class OrderDTO {
	private int o_no; // NUMBER NOT NULL, /* 결제번호 */
	private String bu_userid; //VARCHAR2(20) NOT NULL, /* 아이디 */
	private String o_zipcode; // VARCHAR2(20) NOT NULL, /* 우편번호 */
	private String o_address1; // VARCHAR2(100) NOT NULL, /* 주소 */
	private String o_address2; // VARCHAR2(200) NOT NULL, /* 상세주소 */
	private String o_delflag;// VARCHAR2(10) /* 주문취소여부 */
	private int o_totalPrice;//  number notnull // 주문 총 금액
	private Timestamp o_orderdate;//date sysdate 주문일
	
	public OrderDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderDTO(int o_no, String bu_userid, String o_zipcode, String o_address1, String o_address2,
			String o_delflag, int o_totalPrice, Timestamp o_orderdate) {
		super();
		this.o_no = o_no;
		this.bu_userid = bu_userid;
		this.o_zipcode = o_zipcode;
		this.o_address1 = o_address1;
		this.o_address2 = o_address2;
		this.o_delflag = o_delflag;
		this.o_totalPrice = o_totalPrice;
		this.o_orderdate = o_orderdate;
	}

	public int getO_no() {
		return o_no;
	}

	public void setO_no(int o_no) {
		this.o_no = o_no;
	}

	public String getBu_userid() {
		return bu_userid;
	}

	public void setBu_userid(String bu_userid) {
		this.bu_userid = bu_userid;
	}

	public String getO_zipcode() {
		return o_zipcode;
	}

	public void setO_zipcode(String o_zipcode) {
		this.o_zipcode = o_zipcode;
	}

	public String getO_address1() {
		return o_address1;
	}

	public void setO_address1(String o_address1) {
		this.o_address1 = o_address1;
	}

	public String getO_address2() {
		return o_address2;
	}

	public void setO_address2(String o_address2) {
		this.o_address2 = o_address2;
	}

	public String getO_delflag() {
		return o_delflag;
	}

	public void setO_delflag(String o_delflag) {
		this.o_delflag = o_delflag;
	}

	public int getO_totalPrice() {
		return o_totalPrice;
	}

	public void setO_totalPrice(int o_totalPrice) {
		this.o_totalPrice = o_totalPrice;
	}

	public Timestamp getO_orderdate() {
		return o_orderdate;
	}

	public void setO_orderdate(Timestamp o_orderdate) {
		this.o_orderdate = o_orderdate;
	}

	@Override
	public String toString() {
		return "OrderDTO [o_no=" + o_no + ", bu_userid=" + bu_userid + ", o_zipcode=" + o_zipcode
				+ ", o_address1=" + o_address1 + ", o_address2=" + o_address2 + ", o_delflag=" + o_delflag
				+ ", o_totalPrice=" + o_totalPrice + ", o_orderdate=" + o_orderdate + "]";
	}
}
