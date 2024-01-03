package com.spring.app.expedia.domain;

import com.google.gson.Gson;

public class ReviewVO {
	
	
	private String rv_seq; 		  // 댓글번호
	private String fk_lodge_id;   // 숙박시설 id
	private String fk_rs_seq;	  // 예약번호
	private String fk_userid;     // 구매자 id
	private String rv_subject;	  // 글제목
	private String rv_content;	  //  내용
	private String rv_regDate;	  // 작성일자
	private String rv_status;	  // 글삭제여부
	private int fk_rv_rating;	  // 평점
	private int rv_groupno;		  // 답변글쓰기에 있어서 그룹번호 
                                  // 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                  // 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
	private int rv_org_seq;		  // 원글
	private int rv_depthno;		  // 답변글쓰기에 있어서 답변글 이라면
								  // 원글(부모글)의 depthno + 1 을 가지게 되며,
                                  // 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	
	private String rv_rating_desc; // 평점 설명
	private String livedate;       // 숙박일수
	
	private int rating2;         // 2점 개수 
	private int rating4;         // 4점 개수     
	private int rating6;         // 6점 개수    
	private int rating8;         // 8점 개수    
	private int rating10;        // 10점 개수     
	private int rating_pct;      // 평점 백분율
	
	private double rating_avg;      // 평점 총 평균
    private int rating_cnt;         // 평점 총 개수 
    
	
	
	public ReviewVO() {}
		
		public ReviewVO(String rv_seq, String fk_lodge_id, String fk_rs_seq, String fk_userid, String rv_subject, String rv_content,
				String rv_regDate, String rv_status, int fk_rv_rating, int rv_groupno, int rv_org_seq, int rv_depthno) {
			this.rv_seq = rv_seq;
			this.fk_lodge_id = fk_lodge_id;
			this.fk_rs_seq = fk_rs_seq;
			this.fk_userid = fk_userid;
			this.rv_subject = rv_subject;
			this.rv_content = rv_content;
			this.rv_regDate = rv_regDate;
			this.rv_status = rv_status;
			this.fk_rv_rating = fk_rv_rating;
			this.rv_groupno = rv_groupno;
			this.rv_org_seq = rv_org_seq;
			this.rv_depthno = rv_depthno;
		}

		public String getRv_seq() {
			return rv_seq;
		}

		public void setRv_seq(String rv_seq) {
			this.rv_seq = rv_seq;
		}

		public String getFk_lodge_id() {
			return fk_lodge_id;
		}

		public void setFk_lodge_id(String fk_lodge_id) {
			this.fk_lodge_id = fk_lodge_id;
		}

		public String getFk_rs_seq() {
			return fk_rs_seq;
		}

		public void setFk_rs_seq(String fk_rs_seq) {
			this.fk_rs_seq = fk_rs_seq;
		}

		public String getFk_userid() {
			return fk_userid;
		}

		public void setFk_userid(String fk_userid) {
			this.fk_userid = fk_userid;
		}

		public String getRv_subject() {
			return rv_subject;
		}

		public void setRv_subject(String rv_subject) {
			this.rv_subject = rv_subject;
		}

		public String getRv_content() {
			return rv_content;
		}

		public void setRv_content(String rv_content) {
			this.rv_content = rv_content;
		}

		public String getRv_regDate() {
			return rv_regDate;
		}

		public void setRv_regDate(String rv_regDate) {
			this.rv_regDate = rv_regDate;
		}

		public String getRv_status() {
			return rv_status;
		}

		public void setRv_status(String rv_status) {
			this.rv_status = rv_status;
		}

		public int getFk_rv_rating() {
			return fk_rv_rating;
		}

		public void setFk_rv_rating(int fk_rv_rating) {
			this.fk_rv_rating = fk_rv_rating;
		}

		public int getRv_groupno() {
			return rv_groupno;
		}

		public void setRv_groupno(int rv_groupno) {
			this.rv_groupno = rv_groupno;
		}

		public int getRv_org_seq() {
			return rv_org_seq;
		}

		public void setRv_org_seq(int rv_org_seq) {
			this.rv_org_seq = rv_org_seq;
		}

		public int getRv_depthno() {
			return rv_depthno;
		}

		public void setRv_depthno(int rv_depthno) {
			this.rv_depthno = rv_depthno;
		}

		public String getRv_rating_desc() {
			return rv_rating_desc;
		}

		public void setRv_rating_desc(String rv_rating_desc) {
			this.rv_rating_desc = rv_rating_desc;
		}

		public String getLivedate() {
			return livedate;
		}

		public void setLivedate(String livedate) {
			this.livedate = livedate;
		}

		public int getRating2() {
			return rating2;
		}

		public void setRating2(int rating2) {
			this.rating2 = rating2;
		}

		public int getRating4() {
			return rating4;
		}

		public void setRating4(int rating4) {
			this.rating4 = rating4;
		}

		public int getRating6() {
			return rating6;
		}

		public void setRating6(int rating6) {
			this.rating6 = rating6;
		}

		public int getRating8() {
			return rating8;
		}

		public void setRating8(int rating8) {
			this.rating8 = rating8;
		}

		public int getRating10() {
			return rating10;
		}

		public void setRating10(int rating10) {
			this.rating10 = rating10;
		}

		public int getRating_pct() {
			return rating_pct;
		}

		public void setRating_pct(int rating_pct) {
			this.rating_pct = rating_pct;
		}

		public double getRating_avg() {
			return rating_avg;
		}

		public void setRating_avg(double rating_avg) {
			this.rating_avg = rating_avg;
		}

		public int getRating_cnt() {
			return rating_cnt;
		}

		public void setRating_cnt(int rating_cnt) {
			this.rating_cnt = rating_cnt;
		}
	
		///////////////////////////////////////////////////////
		
		
		public static ReviewVO convertMessage(String source) {
			
			Gson gson = new Gson();
		
			ReviewVO reviewvo = gson.fromJson(source, ReviewVO.class);
			// source 는 JSON 형태로 되어진 문자열
			// gson.fromJson(source, ReviewVO.class); 은 
			// JSON 형태로 되어진 문자열 source를 실제 ReviewVO 객체로 변환해준다.
		
			return reviewvo;
		}
		
	
	
	
	
}
