package com.bookstore.orderDetail.model;

public class OrderDetailDTO {
	private int od_no; //NUMBER NOT NULL, /* 주문상세번호 */
	private int od_qty;//NUMBER DEFAULT 1 NOT NULL, /* 구매수량 */
	private int o_no; //NUMBER NOT NULL, /* 결제번호 */
	private int bd_no; //NUMBER NOT NULL /* 상품번호 */
	
	/*
	join BOOKDETAIL -> 상품 이름과 이미지, 가격을 얻기 위해
	select o.OD_NO, o.od_qty, o.o_no, b.BD_TITLE, b.bd_image, b.bd_price
	from orderdetail o join bookdetail b on o.BD_NO = b.BD_NO;
	*/
	private String bd_image; //이미지
	private String bd_title; //책 제목
	private int bd_price; //책가격
	
	public OrderDetailDTO() {
		super();
	}

	public OrderDetailDTO(int od_no, int od_qty, int o_no, int bd_no, String bd_image, String bd_title, int bd_price) {
		super();
		this.od_no = od_no;
		this.od_qty = od_qty;
		this.o_no = o_no;
		this.bd_no = bd_no;
		this.bd_image = bd_image;
		this.bd_title = bd_title;
		this.bd_price = bd_price;
	}
	

	public int getOd_no() {
		return od_no;
	}

	public void setOd_no(int od_no) {
		this.od_no = od_no;
	}

	public int getOd_qty() {
		return od_qty;
	}

	public void setOd_qty(int od_qty) {
		this.od_qty = od_qty;
	}

	public int getO_no() {
		return o_no;
	}

	public void setO_no(int o_no) {
		this.o_no = o_no;
	}

	public int getBd_no() {
		return bd_no;
	}

	public void setBd_no(int bd_no) {
		this.bd_no = bd_no;
	}

	public String getBd_image() {
		return bd_image;
	}

	public void setBd_image(String bd_image) {
		this.bd_image = bd_image;
	}

	public String getBd_title() {
		return bd_title;
	}

	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}

	public int getBd_price() {
		return bd_price;
	}

	public void setBd_price(int bd_price) {
		this.bd_price = bd_price;
	}

	@Override
	public String toString() {
		return "OrderDetailDTO [od_no=" + od_no + ", od_qty=" + od_qty + ", o_no=" + o_no + ", bd_no=" + bd_no
				+ ", bd_image=" + bd_image + ", bd_title=" + bd_title + ", bd_price=" + bd_price + "]";
	}
}
