package com.spring.app.expedia.domain;


//===== #82. 답글 VO 생성하기
//먼저 오라클에서 tbl_comment 테이블을 생성한다.
//또한 tbl_board 테이블에 commentCount 컬럼을 추가한다. =====
public class ReplyVO {

	private String reply_no;       // 답글번호
    private String reply;      	   // 댓글내용
    private String reply_date;     // 작성일자
    private String fk_chat_no;     // 채팅 글번호
    private String r_status;         // 답글작성자여부    0:구매자 / 1:판매자
	
    public ReplyVO() {}
    
    public ReplyVO(String reply_no, String reply, String reply_date
    			 , String fk_chat_no, String r_status) {
		super();
		this.reply_no = reply_no;
		this.reply = reply;
		this.reply_date = reply_date;
		this.fk_chat_no = fk_chat_no;
		this.r_status = r_status;
	}

	public String getReply_no() {
		return reply_no;
	}

	public void setReply_no(String reply_no) {
		this.reply_no = reply_no;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getReply_date() {
		return reply_date;
	}

	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}

	public String getFk_chat_no() {
		return fk_chat_no;
	}

	public void setFk_chat_no(String fk_chat_no) {
		this.fk_chat_no = fk_chat_no;
	}

	public String getR_status() {
		return r_status;
	}

	public void setR_status(String r_status) {
		this.r_status = r_status;
	}

	
	
	
	
	
	
	
}
