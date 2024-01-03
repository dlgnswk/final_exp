
package com.spring.app.expedia.domain;

/** 
* @FileName  : CommentVO.java 
* @Project   : final_project 
* @Date      : 2023. 12. 26 
* @작성자      : 손명진
* @변경이력    : 
* @프로그램설명    : 
*/
public class CommentVO {

	
	private String c_seq; 		  // 댓글번호
	private String fk_lodge_id;   // 숙박시설 id
	private String fk_rs_seq;	  // 예약번호
	private String fk_h_userid;   // 사업자 id
	private String c_subject;	  // 글제목
	private String c_content;	  // 댓글 내용
	private String c_regDate;	  // 작성일자
	private String c_status;	  // 글삭제여부
	private int fk_c_rating;	  // 평점
	private String c_groupno;		  // 답변글쓰기에 있어서 그룹번호 
                                  // 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                  // 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
	private String c_org_seq;	  // 원글
	private String c_depthno;	  // 답변글쓰기에 있어서 답변글 이라면
								  // 원글(부모글)의 depthno + 1 을 가지게 되며,
                                  // 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	public String getC_seq() {
		return c_seq;
	}
	public void setC_seq(String c_seq) {
		this.c_seq = c_seq;
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
	public String getFk_h_userid() {
		return fk_h_userid;
	}
	public void setFk_h_userid(String fk_h_userid) {
		this.fk_h_userid = fk_h_userid;
	}
	public String getC_subject() {
		return c_subject;
	}
	public void setC_subject(String c_subject) {
		this.c_subject = c_subject;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public String getC_regDate() {
		return c_regDate;
	}
	public void setC_regDate(String c_regDate) {
		this.c_regDate = c_regDate;
	}
	public String getC_status() {
		return c_status;
	}
	public void setC_status(String c_status) {
		this.c_status = c_status;
	}
	public int getFk_c_rating() {
		return fk_c_rating;
	}
	public void setFk_c_rating(int fk_c_rating) {
		this.fk_c_rating = fk_c_rating;
	}
	public String getC_groupno() {
		return c_groupno;
	}
	public void setC_groupno(String c_groupno) {
		this.c_groupno = c_groupno;
	}
	public String getC_org_seq() {
		return c_org_seq;
	}
	public void setC_org_seq(String c_org_seq) {
		this.c_org_seq = c_org_seq;
	}
	public String getC_depthno() {
		return c_depthno;
	}
	public void setC_depthno(String c_depthno) {
		this.c_depthno = c_depthno;
	}
	
	
	
	
	
	
	
	

	
	
	
	
	
}
