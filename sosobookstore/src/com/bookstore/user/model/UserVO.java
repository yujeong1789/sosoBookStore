package com.bookstore.user.model;

import java.sql.Timestamp;

public class UserVO {
	private String bu_userid;
	private String bu_name;
	private String bu_password;
	private String bu_zipcode;
	private String bu_address1;
	private String bu_address2;
	private String bu_hp;
	private Timestamp bu_regdate;
	private Timestamp bu_secdate;
	private int bu_authority;
	
	public UserVO() {
		super();
	}
	
	public UserVO(String bu_userid, String bu_name, String bu_password, String bu_zipcode,
			String bu_address1, String bu_address2, String bu_hp, Timestamp bu_regdate, 
			Timestamp bu_secdate, int bu_authority) {
		super();
		this.bu_userid = bu_userid;
		this.bu_name = bu_name;
		this.bu_password = bu_password;
		this.bu_zipcode = bu_zipcode;
		this.bu_address1 = bu_address1;
		this.bu_address2 = bu_address2;
		this.bu_hp = bu_hp;
		this.bu_regdate = bu_regdate;
		this.bu_secdate = bu_secdate;
		this.bu_authority = bu_authority;
	}
	
	
	public String getBu_userid() {
		return bu_userid;
	}

	public void setBu_userid(String bu_userid) {
		this.bu_userid = bu_userid;
	}

	public String getBu_name() {
		return bu_name;
	}
	public void setBu_name(String bu_name) {
		this.bu_name = bu_name;
	}
	public String getBu_password() {
		return bu_password;
	}
	public void setBu_password(String bu_password) {
		this.bu_password = bu_password;
	}
	public String getBu_zipcode() {
		return bu_zipcode;
	}
	public void setBu_zipcode(String bu_zipcode) {
		this.bu_zipcode = bu_zipcode;
	}
	public String getBu_address1() {
		return bu_address1;
	}
	public void setBu_address1(String bu_address1) {
		this.bu_address1 = bu_address1;
	}
	public String getBu_address2() {
		return bu_address2;
	}
	public void setBu_address2(String bu_address2) {
		this.bu_address2 = bu_address2;
	}
	public String getBu_hp() {
		return bu_hp;
	}
	public void setBu_hp(String bu_hp) {
		this.bu_hp = bu_hp;
	}
	public Timestamp getBu_regdate() {
		return bu_regdate;
	}

	public void setBu_regdate(Timestamp bu_regdate) {
		this.bu_regdate = bu_regdate;
	}

	public Timestamp getBu_secdate() {
		return bu_secdate;
	}

	public void setBu_secdate(Timestamp bu_secdate) {
		this.bu_secdate = bu_secdate;
	}
	public int getBu_authority() {
		return bu_authority;
	}
	public void setBu_authority(int bu_authority) {
		this.bu_authority = bu_authority;
	}
	
	@Override
	public String toString() {
		return "UserVO [bu_userid=" + bu_userid + ", bu_name=" + bu_name + ", bu_password=" + bu_password + ", bu_zipcode="
				+ bu_zipcode + ", bu_address1=" + bu_address1 + ", bu_address2=" + bu_address2 + ", bu_hp=" + bu_hp
				+ ", bu_regdate=" + bu_regdate + ", bu_secdate=" + bu_secdate + ", bu_authority=" + bu_authority + "]";
	}
}