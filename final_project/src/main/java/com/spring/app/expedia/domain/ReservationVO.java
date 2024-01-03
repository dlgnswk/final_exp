package com.spring.app.expedia.domain;

public class ReservationVO {

	private String rs_seq;    	  	// 예약 번호
	private String fk_userid;    	// 예약자 userid
	private String fk_h_userid;    	// 판매자 userid
	private String rs_date;    		// 예약일자
	private String rs_checkinDate;  // 체크인일자
	private String rs_checkoutDate; // 체크아웃일자
	private int rs_price;        	// 결제금액
	private int rs_payType;      	// 결제방식 (0 : 현장결제 / 1: 예약결제)
	private int rs_guest_cnt;		// 투숙인원 
	private String rs_name;  		// 예약자 이름
	private String rs_mobile;  		// 예약자 휴대폰번호
	private String rs_email;     	// 예약자 이메일
	private String fk_rm_seq;  		// 캘린더 소분류 번호(객실등급seq)
//	private String lodge_id;  		// 캘린더 대분류 번호(숙박시설이름)
	
	
	ReservationVO () {}



	public String getRs_seq() {
		return rs_seq;
	}



	public void setRs_seq(String rs_seq) {
		this.rs_seq = rs_seq;
	}



	public String getFk_userid() {
		return fk_userid;
	}



	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}



	public String getFk_h_userid() {
		return fk_h_userid;
	}



	public void setFk_h_userid(String fk_h_userid) {
		this.fk_h_userid = fk_h_userid;
	}



	public String getRs_date() {
		return rs_date;
	}



	public void setRs_date(String rs_date) {
		this.rs_date = rs_date;
	}



	public String getRs_checkinDate() {
		return rs_checkinDate;
	}



	public void setRs_checkinDate(String rs_checkinDate) {
		this.rs_checkinDate = rs_checkinDate;
	}



	public String getRs_checkoutDate() {
		return rs_checkoutDate;
	}



	public void setRs_checkoutDate(String rs_checkoutDate) {
		this.rs_checkoutDate = rs_checkoutDate;
	}



	public int getRs_price() {
		return rs_price;
	}



	public void setRs_price(int rs_price) {
		this.rs_price = rs_price;
	}



	public int getRs_payType() {
		return rs_payType;
	}



	public void setRs_payType(int rs_payType) {
		this.rs_payType = rs_payType;
	}



	public String getRs_name() {
		return rs_name;
	}



	public void setRs_name(String rs_name) {
		this.rs_name = rs_name;
	}



	public String getRs_mobile() {
		return rs_mobile;
	}



	public void setRs_mobile(String rs_mobile) {
		this.rs_mobile = rs_mobile;
	}



	public String getRs_email() {
		return rs_email;
	}



	public void setRs_email(String rs_email) {
		this.rs_email = rs_email;
	}




	/*
	 * public String getLodge_id() { return lodge_id; }
	 */



	/*
	 * public void setLodge_id(String lodge_id) { this.lodge_id = lodge_id; }
	 */


	public int getRs_guest_cnt() {
		return rs_guest_cnt;
	}



	public void setRs_guest_cnt(int rs_guest_cnt) {
		this.rs_guest_cnt = rs_guest_cnt;
	}



	public String getFk_rm_seq() {
		return fk_rm_seq;
	}



	public void setFk_rm_seq(String fk_rm_seq) {
		this.fk_rm_seq = fk_rm_seq;
	}



	

	

	
	
	
	
}
