package com.bookstore.zipcode.model;

public class ZipcodeVO {
	private String z_zipcode;
	private String z_sido;
	private String z_gugun;
	private String z_dong;
	private String z_add1;
	private String z_add2;
	private int z_seq;
	
	public ZipcodeVO() {
		super();
	}
	
	public ZipcodeVO(String z_zipcode, String z_sido, String z_gugun, String z_dong, String z_add1, String z_add2,
			int z_seq) {
		super();
		this.z_zipcode = z_zipcode;
		this.z_sido = z_sido;
		this.z_gugun = z_gugun;
		this.z_dong = z_dong;
		this.z_add1 = z_add1;
		this.z_add2 = z_add2;
		this.z_seq = z_seq;
	}

	public String getZ_zipcode() {
		return z_zipcode;
	}

	public void setZ_zipcode(String z_zipcode) {
		this.z_zipcode = z_zipcode;
	}

	public String getZ_sido() {
		return z_sido;
	}

	public void setZ_sido(String z_sido) {
		this.z_sido = z_sido;
	}

	public String getZ_gugun() {
		return z_gugun;
	}

	public void setZ_gugun(String z_gugun) {
		this.z_gugun = z_gugun;
	}

	public String getZ_dong() {
		return z_dong;
	}

	public void setZ_dong(String z_dong) {
		this.z_dong = z_dong;
	}

	public String getZ_add1() {
		return z_add1;
	}

	public void setZ_add1(String z_add1) {
		this.z_add1 = z_add1;
	}

	public String getZ_add2() {
		return z_add2;
	}

	public void setZ_add2(String z_add2) {
		this.z_add2 = z_add2;
	}

	public int getZ_seq() {
		return z_seq;
	}

	public void setZ_seq(int z_seq) {
		this.z_seq = z_seq;
	}
	
	
	@Override
	public String toString() {
		return "ZipcodeVO [zipcode=" + z_zipcode + ", sido=" + z_sido + ", gugun=" + z_gugun + ", dong=" + z_dong
				+ ", startbunji=" + z_add1 + ", endbunji=" + z_add2 + ", seq=" + z_seq + "]";
	}
}
