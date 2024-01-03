package com.spring.app.expedia.domain;

public class LodgeVO {

	private String lodge_id;			// 숙박시설ID / ex) SIRA0001, WTWQ1234   *---> // 캘린더 대분류 번호
	private String fk_h_userid;			// 사업자아이디 / 
	private String lg_name;				// 숙박시설 이름 /						   *---> // 캘린더 대분류 명
	private String lg_en_name;			// 호텔영문명 / sin hotel busan
	private String lg_postcode;			// 우편번호 / 12345 02134
	
	private String lg_address;			// 주소
	private String lg_detailaddress;	// 상세주소
	private String lg_extraaddress;		// 참고항목 
	private String lg_latitude;			// 지역위도 / 123.41235521251
	private String lg_longitude;		// 지역경도 / 55.2315234124
	// 10 
	
	private String lg_hotel_star;		// 호텔등급 (몇성급) / lg_hotel_star
	private String lg_area;				// 지역명 / 서울
	private String lg_area_2;			// 지역명2 / 서대문구
	private String fk_lodge_type;		// 숙박시설유형 / 0,1,2,3,4,5
											// 0:호텔
											// 1:모텔
											// 2:아파트식호텔(레지던스)
											// 3:리조트
											// 4:펜션
	private String lg_qty;				// 객실수 / 숫자
	
	private String fk_cancel_opt;			// 취소정책옵션번호 / 0,1,2,4
												// 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
												// 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
												// 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
												// 3 : 체크인 1시간 이전 : 100% 환불가능
	private String fd_status;				// 프런트데스크 / 0:없음, 1:있음
	private String fd_time;					// 프런트데스크운영시간 / '없음' or '09:00 AM ~ 09:00 PM' or '24시간'
	private String fk_s_checkin_type;		// 셀프체크인방법 / 0,1,2,3,4,5
												// 0: 셀프체크인불가
												// 1: 엑세스코드
												// 2: 키 수령 안내
												// 3: 록박스 이용 안내
												// 4: 스마트 록 코드
												// 5: 익스프레스 체크인
	private String lg_checkin_start_time;	// 체크인시간_시작 / 09:00 AM
	// 20
	
	private String lg_checkin_end_time;		// 체크인시간_마감 / 09:00 PM
	private String lg_checkout_time;		// 체크아웃 (가능)시간 / 01:00 AM ~ 11:00 PM / 1시간 간격
	private String lg_age_limit;			// 제한나이 / 15~25
	private String lg_internet_yn;			// 인터넷제공 / 0:없음, 1:있음 --> 이후 체크박스 선택
	private String lg_park_yn;				// 주차장 / 0:없음, 1:있음 --> 이후 체크박스 선택
	
	private String lg_breakfast_yn;		// 아침식사 / 0:제공안됨, 1:제공됨
	private String lg_dining_place_yn;	// 다이닝 장소 / 0:없음, 1:있음 --> 이후 체크박스 선택
	private String lg_pool_yn;			// 수영장타입 / 0:없음, 1:있음 --> 이후 체크박스 선택
	private String lg_pet_yn;			// 반려동물 / 0:불가, 1:허용
	private String lg_pet_fare;			// 반려동물 요금 / null, 1마리당 요금 <input> ex) 30000
	// 30

	private String lg_fac_yn;			// 장애인 편의시설타입 / 0:없음,1:있음 --> 이후 체크박스 선택
	private String lg_service_yn;		// 고객서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
	private String lg_rm_service_yn;	// 객실 용품 및 서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
	private String lg_beach_yn;			// 해변 / 0:없음,1:있음
	private String fk_spa_type;			// 스파 / 0:없음, 1:풀서비스 스파, 2:시설 내 스파서피스

	private String lg_smoke_yn;			// 흡연구역 / 0:없음, 1:있음
	private String lg_business_yn;		// 비즈니스 / 0:없음,1:있음 --> 이후 체크박스 선택
	private String lg_fa_travel_yn;		// 가족여행 / 0:없음,1:있음 --> 이후 체크박스 선택
	private String lg_status;			// 시설 승인 상태 / 0:대기, 1:승인, 2:거절
	// 39
	
	
	
	// getter setter
	public String getLodge_id() {
		return lodge_id;
	}
	public void setLodge_id(String lodge_id) {
		this.lodge_id = lodge_id;
	}
	public String getFk_h_userid() {
		return fk_h_userid;
	}
	public void setFk_h_userid(String fk_h_userid) {
		this.fk_h_userid = fk_h_userid;
	}
	public String getLg_name() {
		return lg_name;
	}
	public void setLg_name(String lg_name) {
		this.lg_name = lg_name;
	}
	public String getLg_en_name() {
		return lg_en_name;
	}
	public void setLg_en_name(String lg_en_name) {
		this.lg_en_name = lg_en_name;
	}
	public String getLg_postcode() {
		return lg_postcode;
	}
	public void setLg_postcode(String lg_postcode) {
		this.lg_postcode = lg_postcode;
	}
	public String getLg_address() {
		return lg_address;
	}
	public void setLg_address(String lg_address) {
		this.lg_address = lg_address;
	}
	public String getLg_detailaddress() {
		return lg_detailaddress;
	}
	public void setLg_detailaddress(String lg_detailaddress) {
		this.lg_detailaddress = lg_detailaddress;
	}
	public String getLg_extraaddress() {
		return lg_extraaddress;
	}
	public void setLg_extraaddress(String lg_extraaddress) {
		this.lg_extraaddress = lg_extraaddress;
	}
	public String getLg_latitude() {
		return lg_latitude;
	}
	public void setLg_latitude(String lg_latitude) {
		this.lg_latitude = lg_latitude;
	}
	public String getLg_longitude() {
		return lg_longitude;
	}
	public void setLg_longitude(String lg_longitude) {
		this.lg_longitude = lg_longitude;
	}
	public String getLg_hotel_star() {
		return lg_hotel_star;
	}
	public void setLg_hotel_star(String lg_hotel_star) {
		this.lg_hotel_star = lg_hotel_star;
	}
	public String getLg_area() {
		return lg_area;
	}
	public void setLg_area(String lg_area) {
		this.lg_area = lg_area;
	}
	public String getLg_area_2() {
		return lg_area_2;
	}
	public void setLg_area_2(String lg_area_2) {
		this.lg_area_2 = lg_area_2;
	}
	public String getFk_lodge_type() {
		return fk_lodge_type;
	}
	public void setFk_lodge_type(String fk_lodge_type) {
		this.fk_lodge_type = fk_lodge_type;
	}
	public String getLg_qty() {
		return lg_qty;
	}
	public void setLg_qty(String lg_qty) {
		this.lg_qty = lg_qty;
	}
	public String getFk_cancel_opt() {
		return fk_cancel_opt;
	}
	public void setFk_cancel_opt(String fk_cancel_opt) {
		this.fk_cancel_opt = fk_cancel_opt;
	}
	public String getFd_status() {
		return fd_status;
	}
	public void setFd_status(String fd_status) {
		this.fd_status = fd_status;
	}
	public String getFd_time() {
		return fd_time;
	}
	public void setFd_time(String fd_time) {
		this.fd_time = fd_time;
	}
	public String getFk_s_checkin_type() {
		return fk_s_checkin_type;
	}
	public void setFk_s_checkin_type(String fk_s_checkin_type) {
		this.fk_s_checkin_type = fk_s_checkin_type;
	}
	public String getLg_checkin_start_time() {
		return lg_checkin_start_time;
	}
	public void setLg_checkin_start_time(String lg_checkin_start_time) {
		this.lg_checkin_start_time = lg_checkin_start_time;
	}
	public String getLg_checkin_end_time() {
		return lg_checkin_end_time;
	}
	public void setLg_checkin_end_time(String lg_checkin_end_time) {
		this.lg_checkin_end_time = lg_checkin_end_time;
	}
	public String getLg_checkout_time() {
		return lg_checkout_time;
	}
	public void setLg_checkout_time(String lg_checkout_time) {
		this.lg_checkout_time = lg_checkout_time;
	}
	public String getLg_age_limit() {
		return lg_age_limit;
	}
	public void setLg_age_limit(String lg_age_limit) {
		this.lg_age_limit = lg_age_limit;
	}
	public String getLg_internet_yn() {
		return lg_internet_yn;
	}
	public void setLg_internet_yn(String lg_internet_yn) {
		this.lg_internet_yn = lg_internet_yn;
	}
	public String getLg_park_yn() {
		return lg_park_yn;
	}
	public void setLg_park_yn(String lg_park_yn) {
		this.lg_park_yn = lg_park_yn;
	}
	public String getLg_breakfast_yn() {
		return lg_breakfast_yn;
	}
	public void setLg_breakfast_yn(String lg_breakfast_yn) {
		this.lg_breakfast_yn = lg_breakfast_yn;
	}
	public String getLg_dining_place_yn() {
		return lg_dining_place_yn;
	}
	public void setLg_dining_place_yn(String lg_dining_place_yn) {
		this.lg_dining_place_yn = lg_dining_place_yn;
	}
	public String getLg_pool_yn() {
		return lg_pool_yn;
	}
	public void setLg_pool_yn(String lg_pool_yn) {
		this.lg_pool_yn = lg_pool_yn;
	}
	public String getLg_pet_yn() {
		return lg_pet_yn;
	}
	public void setLg_pet_yn(String lg_pet_yn) {
		this.lg_pet_yn = lg_pet_yn;
	}
	public String getLg_pet_fare() {
		return lg_pet_fare;
	}
	public void setLg_pet_fare(String lg_pet_fare) {
		this.lg_pet_fare = lg_pet_fare;
	}
	public String getLg_fac_yn() {
		return lg_fac_yn;
	}
	public void setLg_fac_yn(String lg_fac_yn) {
		this.lg_fac_yn = lg_fac_yn;
	}
	public String getLg_service_yn() {
		return lg_service_yn;
	}
	public void setLg_service_yn(String lg_service_yn) {
		this.lg_service_yn = lg_service_yn;
	}
	public String getLg_rm_service_yn() {
		return lg_rm_service_yn;
	}
	public void setLg_rm_service_yn(String lg_rm_service_yn) {
		this.lg_rm_service_yn = lg_rm_service_yn;
	}
	public String getLg_beach_yn() {
		return lg_beach_yn;
	}
	public void setLg_beach_yn(String lg_beach_yn) {
		this.lg_beach_yn = lg_beach_yn;
	}
	public String getFk_spa_type() {
		return fk_spa_type;
	}
	public void setFk_spa_type(String fk_spa_type) {
		this.fk_spa_type = fk_spa_type;
	}
	public String getLg_smoke_yn() {
		return lg_smoke_yn;
	}
	public void setLg_smoke_yn(String lg_smoke_yn) {
		this.lg_smoke_yn = lg_smoke_yn;
	}
	public String getLg_business_yn() {
		return lg_business_yn;
	}
	public void setLg_business_yn(String lg_business_yn) {
		this.lg_business_yn = lg_business_yn;
	}
	public String getLg_fa_travel_yn() {
		return lg_fa_travel_yn;
	}
	public void setLg_fa_travel_yn(String lg_fa_travel_yn) {
		this.lg_fa_travel_yn = lg_fa_travel_yn;
	}
	public String getLg_status() {
		return lg_status;
	}
	public void setLg_status(String lg_status) {
		this.lg_status = lg_status;
	}
	
	
	
}
