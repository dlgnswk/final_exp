package com.spring.app.expedia.domain;

//=== #52. 문의글(구매자용) VO 생성하기
public class ChatVO {

	// 필드
	private String chat_no; // 채팅방 번호
	private String fk_userid; // 구매자 ID
	private String fk_h_userid; // 판매자 ID
	private String chat_date; // 글쓴시간
	private String m_status; // 채팅방 삭제여부 1:사용가능한 채팅방, 0:삭제된 채팅방

	// === #137. 답변글쓰기 게시판을 위한 필드 추가하기
	// 먼저, 오라클에서 tbl_comment 테이블과 tbl_board 테이블을 drop 한 이후에
	// tbl_board 테이블 및 tbl_comment 테이블을 재생성 한 이후에 아래처럼 해야 한다.
	private String groupno;
	/*
	 * 답변글쓰기에 있어서 그룹번호 원글(부모글)과 답변글은 동일한 groupno 를 가진다. 답변글이 아닌 원글(부모글)인 경우 groupno
	 * 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
	 */

	private String fk_chat_no;
	/*
	 * fk_seq 컬럼은 절대로 foreign key가 아니다.!!!!!! fk_seq 컬럼은 자신의 글(답변글)에 있어서 원글(부모글)이
	 * 누구인지에 대한 정보값이다. 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 원글(부모글)의 seq 컬럼의 값을 가지게 되며,
	 * 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	 */

	private String depthno;
	/*
	 * 답변글쓰기에 있어서 답변글 이라면 원글(부모글)의 depthno + 1 을 가지게 되며, 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	 */

	// 생성자
	public ChatVO() {
	}

	public ChatVO(String chat_no, String fk_userid, String fk_h_userid, String chat_date, String m_status) {
		this.chat_no = chat_no;
		this.fk_userid = fk_userid;
		this.fk_h_userid = fk_h_userid;
		this.chat_date = chat_date;
		this.m_status = m_status;

	}

	public String getChat_no() {
		return chat_no;
	}

	public void setChat_no(String chat_no) {
		this.chat_no = chat_no;
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

	public String getChat_date() {
		return chat_date;
	}

	public void setChat_date(String chat_date) {
		this.chat_date = chat_date;
	}

	public String getM_status() {
		return m_status;
	}

	public void setM_status(String m_status) {
		this.m_status = m_status;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_chat_no() {
		return fk_chat_no;
	}

	public void setFk_chat_no(String fk_chat_no) {
		this.fk_chat_no = fk_chat_no;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}

}
