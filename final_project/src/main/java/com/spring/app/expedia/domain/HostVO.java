package com.spring.app.expedia.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HostVO {

	private String h_userid;           // 사업자아이디
	private String h_pw;               // 비밀번호 (SHA-256 암호화 대상)
	private String h_name;             // 사업자명
	private String h_lodgename;		   // 사업장명
	private String h_email;       	   // 이메일
	private String h_mobile; 		   // 연락처 
	private String h_postcode;         // 사업자우편번호
	private String h_address;          // 사업자주소 
	private String h_detailAddress;    // 사업자상세주소
	private String h_extraAddress;     // 사업자참고주소
	private String h_legalName;        // 숙박시설법인명
	private String h_businessNo;          // 사업자번호  
	private String h_registerday;   	  //가입일자 
	private String h_lastpwdchangedate; // 마지막으로 암호를 변경한 날짜  
	private int h_status; 		  	  	// 사업자승인유무   1: 사용가능(관리자승인o) / 0:사용불능(관리자승인x) 
									  	
	
	private int h_pwdchangegap;		  // select 용. 지금으로부터 마지막으로 암호를 변경한지가 몇 개월인지 알려주는 개월 수(3개월 동안 암호를 변경 안 했을 시 암호를 변경하라는 메시지를 보여주기 위함)
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	public HostVO() {}
	
	
	//회원 가입 시 생성자
	public HostVO(String h_userid, String h_pw, String h_name, String h_lodgename, String h_email, String h_mobile, String h_postcode
				  , String h_address, String h_detailAddress, String h_extraAddress, String h_legalName, String h_businessNo) {
		
		this.h_userid = h_userid;
		this.h_pw = h_pw;
		this.h_name = h_name;
		this.h_lodgename = h_lodgename;
		this.h_email = h_email;
		this.h_mobile = h_mobile;
		this.h_postcode = h_postcode;
		this.h_address = h_address;
		this.h_detailAddress = h_detailAddress;
		this.h_extraAddress = h_extraAddress;
		this.h_legalName = h_legalName;
		this.h_businessNo = h_businessNo;
		
	}
	
	
	
	


	public String getH_userid() {
		return h_userid;
	}
	
	public void setH_userid(String h_userid) {
		this.h_userid = h_userid;
	}
	
	public String getH_pw() {
		return h_pw;
	}
	
	public void setH_pw(String h_pw) {
		this.h_pw = h_pw;
	}
	
	public String getH_name() {
		return h_name;
	}
	
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	
	public String getH_lodgename() {
		return h_lodgename;
	}

	public void setH_lodgename(String h_lodgename) {
		this.h_lodgename = h_lodgename;
	}

	public String getH_email() {
		return h_email;
	}

	public void setH_email(String h_email) {
		this.h_email = h_email;
	}

	public String getH_postcode() {
		return h_postcode;
	}
	
	public void setH_postcode(String h_postcode) {
		this.h_postcode = h_postcode;
	}
	
	public String getH_address() {
		return h_address;
	}
	
	public void setH_address(String h_address) {
		this.h_address = h_address;
	}
	
	public String getH_detailAddress() {
		return h_detailAddress;
	}
	
	public void setH_detailAddress(String h_detailAddress) {
		this.h_detailAddress = h_detailAddress;
	}
	
	public String getH_extraAddress() {
		return h_extraAddress;
	}
	
	public void setH_extraAddress(String h_extraAddress) {
		this.h_extraAddress = h_extraAddress;
	}
	
	
	public String getH_legalName() {
		return h_legalName;
	}
	
	public void setH_legalName(String h_legalName) {
		this.h_legalName = h_legalName;
	}
	
	public String getH_businessNo() {
		return h_businessNo;
	}
	
	public void setH_businessNo(String h_businessNo) {
		this.h_businessNo = h_businessNo;
	}
	

	public String getH_mobile() {
		return h_mobile;
	}

	public void setH_mobile(String h_mobile) {
		this.h_mobile = h_mobile;
	}

	public String getH_registerday() {
		return h_registerday;
	}

	public void setH_registerday(String h_registerday) {
		this.h_registerday = h_registerday;
	}

	public String getH_lastpwdchangedate() {
		return h_lastpwdchangedate;
	}


	public void setH_lastpwdchangedate(String h_lastpwdchangedate) {
		this.h_lastpwdchangedate = h_lastpwdchangedate;
	}

	public int getH_status() {
		return h_status;
	}

	public void setH_status(int h_status) {
		this.h_status = h_status;
	}

	public int getH_pwdchangegap() {
		return h_pwdchangegap;
	}

	public void setH_pwdchangegap(int h_pwdchangegap) {
		this.h_pwdchangegap = h_pwdchangegap;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	
	
}
