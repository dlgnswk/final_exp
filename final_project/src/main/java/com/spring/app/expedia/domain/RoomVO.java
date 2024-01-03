package com.spring.app.expedia.domain;

public class RoomVO {
	private String rm_seq;          	// 객실고유번호		// 캘린더 소분류 번호(객실 seq)
	private String fk_lodge_id;     	// fk_시설id			// 캘린더 대분류 번호
	private String rm_type;         	// 객실이름(type)		// 캘린더 소분류 명(객실등급명)
	private String rm_bedrm_cnt;    	// 침실개수
	private String rm_smoke_yn;     	// 흡연유무 (0: 불가 / 1: 가능)
	private String rm_size_feet;    	// 객실크기(제곱피트)
	private String rm_size_meter;   	// 객실크기(제곱미터)
	private String rm_size_pyug;   		// 객실크기(평)
	private String rm_extra_bed_yn;   	// 침대 추가 가능여부 (0: 불가 / 1: 가능)
	private String rm_single_bed;   	// 싱글침대 개수
	private String rm_ss_bed;   		// 슈퍼싱글침대 개수
	private String rm_double_bed;   	// 더블침대 개수
	private String rm_queen_bed;   		// 퀸사이즈침대 개수
	private String rm_king_bed;  	 	// 킹사이즈침대 개수
	private String rm_wheelchair_yn;   	// 휠체어이용가능 유무 (0: 무 / 1: 유)
	private String rm_bathroom_cnt;   	// 전용욕실갯수
	private String rm_p_bathroom_yn;   	// 공용욕실유무
	private String rm_kitchen_yn;   	// 주방(조리시설)유무 (0: 무 / 1: 유)
	private String fk_view_no;   		// fk_전망옵션
	private String rm_snack_yn;   		// 객실 내 다과
	private String rm_ent_yn;   		// 객실 내 엔터테인먼트
	private String rm_tmp_ctrl_yn;   	// 온도조절기
	private String rm_guest_cnt;   		// 투숙가능인원
	private String rm_price;   			// 숙박요금
	private String fk_h_userid;     	// 캘린더 소분류 작성자 유저아이디(판매자id)
	private String rm_breakfast_yn;		// 조식포함 유무(불포함시 금액지불) / 호텔에서 조식서비스를 제공할때만 선택가능 (0: 무 / 1: 유)
	
	
	
	
	public String getRm_seq() {
		return rm_seq;
	}
	public void setRm_seq(String rm_seq) {
		this.rm_seq = rm_seq;
	}
	public String getFk_lodge_id() {
		return fk_lodge_id;
	}
	public void setFk_lodge_id(String fk_lodge_id) {
		this.fk_lodge_id = fk_lodge_id;
	}
	public String getRm_type() {
		return rm_type;
	}
	public void setRm_type(String rm_type) {
		this.rm_type = rm_type;
	}
	public String getRm_bedrm_cnt() {
		return rm_bedrm_cnt;
	}
	public void setRm_bedrm_cnt(String rm_bedrm_cnt) {
		this.rm_bedrm_cnt = rm_bedrm_cnt;
	}
	public String getRm_smoke_yn() {
		return rm_smoke_yn;
	}
	public void setRm_smoke_yn(String rm_smoke_yn) {
		this.rm_smoke_yn = rm_smoke_yn;
	}
	public String getRm_size_feet() {
		return rm_size_feet;
	}
	public void setRm_size_feet(String rm_size_feet) {
		this.rm_size_feet = rm_size_feet;
	}
	public String getRm_size_meter() {
		return rm_size_meter;
	}
	public void setRm_size_meter(String rm_size_meter) {
		this.rm_size_meter = rm_size_meter;
	}
	public String getRm_size_pyug() {
		return rm_size_pyug;
	}
	public void setRm_size_pyug(String rm_size_pyug) {
		this.rm_size_pyug = rm_size_pyug;
	}
	public String getRm_extra_bed_yn() {
		return rm_extra_bed_yn;
	}
	public void setRm_extra_bed_yn(String rm_extra_bed_yn) {
		this.rm_extra_bed_yn = rm_extra_bed_yn;
	}
	public String getRm_single_bed() {
		return rm_single_bed;
	}
	public void setRm_single_bed(String rm_single_bed) {
		this.rm_single_bed = rm_single_bed;
	}
	public String getRm_ss_bed() {
		return rm_ss_bed;
	}
	public void setRm_ss_bed(String rm_ss_bed) {
		this.rm_ss_bed = rm_ss_bed;
	}
	public String getRm_double_bed() {
		return rm_double_bed;
	}
	public void setRm_double_bed(String rm_double_bed) {
		this.rm_double_bed = rm_double_bed;
	}
	public String getRm_queen_bed() {
		return rm_queen_bed;
	}
	public void setRm_queen_bed(String rm_queen_bed) {
		this.rm_queen_bed = rm_queen_bed;
	}
	public String getRm_king_bed() {
		return rm_king_bed;
	}
	public void setRm_king_bed(String rm_king_bed) {
		this.rm_king_bed = rm_king_bed;
	}
	public String getRm_wheelchair_yn() {
		return rm_wheelchair_yn;
	}
	public void setRm_wheelchair_yn(String rm_wheelchair_yn) {
		this.rm_wheelchair_yn = rm_wheelchair_yn;
	}
	public String getRm_bathroom_cnt() {
		return rm_bathroom_cnt;
	}
	public void setRm_bathroom_cnt(String rm_bathroom_cnt) {
		this.rm_bathroom_cnt = rm_bathroom_cnt;
	}
	public String getRm_p_bathroom_yn() {
		return rm_p_bathroom_yn;
	}
	public void setRm_p_bathroom_yn(String rm_p_bathroom_yn) {
		this.rm_p_bathroom_yn = rm_p_bathroom_yn;
	}
	public String getRm_kitchen_yn() {
		return rm_kitchen_yn;
	}
	public void setRm_kitchen_yn(String rm_kitchen_yn) {
		this.rm_kitchen_yn = rm_kitchen_yn;
	}
	public String getFk_view_no() {
		return fk_view_no;
	}
	public void setFk_view_no(String fk_view_no) {
		this.fk_view_no = fk_view_no;
	}
	public String getRm_snack_yn() {
		return rm_snack_yn;
	}
	public void setRm_snack_yn(String rm_snack_yn) {
		this.rm_snack_yn = rm_snack_yn;
	}
	public String getRm_ent_yn() {
		return rm_ent_yn;
	}
	public void setRm_ent_yn(String rm_ent_yn) {
		this.rm_ent_yn = rm_ent_yn;
	}
	public String getRm_tmp_ctrl_yn() {
		return rm_tmp_ctrl_yn;
	}
	public void setRm_tmp_ctrl_yn(String rm_tmp_ctrl_yn) {
		this.rm_tmp_ctrl_yn = rm_tmp_ctrl_yn;
	}
	public String getRm_guest_cnt() {
		return rm_guest_cnt;
	}
	public void setRm_guest_cnt(String rm_guest_cnt) {
		this.rm_guest_cnt = rm_guest_cnt;
	}
	public String getRm_price() {
		return rm_price;
	}
	public void setRm_price(String rm_price) {
		this.rm_price = rm_price;
	}
	public String getFk_h_userid() {
		return fk_h_userid;
	}
	public void setFk_h_userid(String fk_h_userid) {
		this.fk_h_userid = fk_h_userid;
	}
	public String getRm_breakfast_yn() {
		return rm_breakfast_yn;
	}
	public void setRm_breakfast_yn(String rm_breakfast_yn) {
		this.rm_breakfast_yn = rm_breakfast_yn;
	}
	
	
	
	
	
	
	
	
	
	
	
}
