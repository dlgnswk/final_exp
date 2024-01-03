package com.spring.app.expedia.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UserVO {

	private String userid; // 회원 아이디
	private String name; // 회원명
	private String email; // 회원 이메일
	private String pw; 	  // 비밀번호
	private String birth; // 생일
	private String mobile; // 연락처
	private String gender; // 성별
	private int postcode; // 우편번호
	private String address; // 주소
	private String detailAddress; // 상세주소
	private String extraAddress; // 추가주소
	private int role; // 0: 관리자, 1: 일반회원(구매자)
	private String registerDate; // 가입일자
	private int idle; // 0: 휴면, 1: 활동중, -1: 탈퇴
	private String user_lvl; // 회원등급 ( 0: blue, 1: silver, 2: gold)
	private int point; // 포인트
	private String emer_name; // 비상연락처_이름
	private String emer_phone; // 비상연락처_연락처
	private String pt_num; // 여권번호
	private String pt_nation; // 여권국적
	private String pt_endDate; // 여권만료일

	
	private int pwdchangegap;		  // select 용. 지금으로 부터 마지막으로 암호를 변경한지가 몇개월인지 알려주는 개월수(3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	private int lastlogingap;         // select 용. 지금으로 부터 마지막으로 로그인한지가 몇개월인지 알려주는 개월수(12개월 동안 로그인을 안 했을 경우 해당 로그인 계정을 비활성화 시키려고 함)
	
	//////////////////////////////////////////////////////////////////////////////////////
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	//////////////////////////////////////////////////////////////////////////////////////
	
	public UserVO() {}
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPostcode() {
		return postcode;
	}
	public void setPostcode(int postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	public String getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	public int getIdle() {
		return idle;
	}
	public void setIdle(int idle) {
		this.idle = idle;
	}
	public String getUser_lvl() {
		return user_lvl;
	}
	public void setUser_lvl(String user_lvl) {
		if("0".equals(user_lvl)) {
			this.user_lvl = "블루";
		}
		else if("1".equals(user_lvl)) {
			this.user_lvl = "실버";
		}
		else if("2".equals(user_lvl)) {
			this.user_lvl = "골드";
		}
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getEmer_name() {
		return emer_name;
	}
	public void setEmer_name(String emer_name) {
		this.emer_name = emer_name;
	}
	public String getEmer_phone() {
		return emer_phone;
	}
	public void setEmer_phone(String emer_phone) {
		this.emer_phone = emer_phone;
	}
	public String getPt_num() {
		return pt_num;
	}
	public void setPt_num(String pt_num) {
		this.pt_num = pt_num;
	}
	public String getPt_nation() {
		return pt_nation;
	}
	public void setPt_nation(String pt_nation) {
		this.pt_nation = pt_nation;
	}
	public String getPt_endDate() {
		return pt_endDate;
	}
	public void setPt_endDate(String pt_endDate) {
		this.pt_endDate = pt_endDate;
	}
	public int getPwdchangegap() {
		return pwdchangegap;
	}
	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}
	public int getLastlogingap() {
		return lastlogingap;
	}
	public void setLastlogingap(int lastlogingap) {
		this.lastlogingap = lastlogingap;
	}
	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}
	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	public int getAge() {
		
		int age = 0;
		
		// 회원의 올해생일이 현재날짜 보다 이전이라면 
		// 만나이 = 현재년도 - 회원의 태어난년도 
		
		// 회원의 올해생일이 현재날짜 보다 이후이라면
		// 만나이 = 현재년도 - 회원의 태어난년도 - 1
		
		Date now = new Date(); // 현재시각
		SimpleDateFormat sdfmt = new SimpleDateFormat("yyyyMMdd");
		String str_now = sdfmt.format(now); // "20231017"
		
		// 회원의 올해생일(문자열 타입)
		String str_now_birthday = str_now.substring(0, 4) + birth.substring(5,7) + birth.substring(8); 
		
		// 회원의 태어난년도
		int birth_year = Integer.parseInt(birth.substring(0, 4));
		
		// 현재년도
		int now_year = Integer.parseInt(str_now.substring(0, 4)); 
		
		try {
			Date now_birthday = sdfmt.parse(str_now_birthday); // 회원의 올해생일(연월일) 날짜 타입
			now = sdfmt.parse(str_now); // 오늘날짜(연월일) 날짜타입
			
			if(now_birthday.before(now)) {
				// 회원의 올해생일이 현재날짜 보다 이전이라면
				
				age = now_year - birth_year; 
				// 나이 = 현재년도 - 회원의 태어난년도
			}
			else {
				// 회원의 올해생일이 현재날짜 보다 이후이라면
				
				age = now_year - birth_year - 1;
				// 나이 = 현재년도 - 회원의 태어난년도 - 1
			}
			
		} catch (ParseException e) {
		
	  	}
		
		return age;
		
	/*
		>> 한국나이 << 
		
		Calendar currentDate = Calendar.getInstance(); 
		// 현재날짜와 시간을 얻어온다.
		
		int currentYear = currentDate.get(Calendar.YEAR);
		
		age =  currentYear - Integer.parseInt( birthday.substring(0, 4) ) + 1;
		
		return age;
	 */
	}

}
