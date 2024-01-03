package com.spring.app.expedia.domain;

import org.springframework.web.multipart.MultipartFile;

// === #52. VO 생성하기
// 먼저, 오라클에서 tbl_board 테이블을 생성해야 한다.
public class TripboardVO {

	private String tb_seq       ;  //     number                not null    -- 글번호
	private String fk_userid     ;  //    varchar2(20)          not null   -- 사용자ID
	private String tb_name       ;  //    varchar2(20)          not null    -- 글쓴이 
	private String tb_subject    ;  //    Nvarchar2(200)        not null    -- 글제목
	private String tb_city       ;  //    varchar2(20)          not null    -- 지역
	private String tb_content    ;  //    clob                  not null    -- 글내용   CLOB(4GB 까지 저장 가능한 데이터 타입) 타입
	private String tb_pw         ;  //    varchar2(20)          not null    -- 글암호
	private String tb_readCount  ;  //    number default 0      not null    -- 글조회수
	private String tb_regDate    ;  //    date default sysdate  not null    -- 글쓴시간
	private String tb_status     ;  //    number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
	private String tb_fileName   ;  //     varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(2023112409291535243254235235234.png)                                       
	private String tb_orgFilename;  //     varchar2(255)                    -- 진짜 파일명 
	private String tb_fileSize   ;  //     number                           -- 파일크기  
	
	private String tb_previousseq;      // 이전글번호
	private String tb_previoussubject;  // 이전글제목
	private String tb_nextseq;          // 다음글번호
	private String tb_nextsubject;      // 다음글제목	
	
	

	
	/*
		=== #152. 파일을 첨부하도록 VO 수정하기
		먼저, 오라클에서 tbl_board 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다. 
	*/
	
	private MultipartFile attach;
	/* 
		form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
		진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
		조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_board 테이블의 컬럼이 아니다.   
		/board/src/main/webapp/WEB-INF/views/tiles1/board/add.jsp 파일에서 input type="file" 인  name의 이름(attach)과  
		동일해야만 파일첨부가 가능해진다.!!!!
	*/
	
	
	

	public TripboardVO() {}
	
	public TripboardVO(String tb_seq, String fk_userid, String tb_name, String tb_subject, String tb_content, String tb_pw,
			String tb_readCount, String tb_regDate, String tb_status) {
		this.tb_seq = tb_seq;
		this.fk_userid = fk_userid;
		this.tb_name = tb_name;
		this.tb_subject = tb_subject;
		this.tb_content = tb_content;
		this.tb_pw = tb_pw;
		this.tb_readCount = tb_readCount;
		this.tb_regDate = tb_regDate;
		this.tb_status = tb_status;
	}

	public String getTb_seq() {
		return tb_seq;
	}

	public void setTb_seq(String tb_seq) {
		this.tb_seq = tb_seq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getTb_name() {
		return tb_name;
	}

	public void setTb_name(String tb_name) {
		this.tb_name = tb_name;
	}

	public String getTb_subject() {
		return tb_subject;
	}

	public void setTb_subject(String tb_subject) {
		this.tb_subject = tb_subject;
	}

	public String getTb_city() {
		return tb_city;
	}

	public void setTb_city(String tb_city) {
		this.tb_city = tb_city;
	}

	public String getTb_content() {
		return tb_content;
	}

	public void setTb_content(String tb_content) {
		this.tb_content = tb_content;
	}

	public String getTb_pw() {
		return tb_pw;
	}

	public void setTb_pw(String tb_pw) {
		this.tb_pw = tb_pw;
	}

	public String getTb_readCount() {
		return tb_readCount;
	}

	public void setTb_readCount(String tb_readCount) {
		this.tb_readCount = tb_readCount;
	}

	public String getTb_regDate() {
		return tb_regDate;
	}

	public void setTb_regDate(String tb_regDate) {
		this.tb_regDate = tb_regDate;
	}

	public String getTb_status() {
		return tb_status;
	}

	public void setTb_status(String tb_status) {
		this.tb_status = tb_status;
	}

	public String getTb_fileName() {
		return tb_fileName;
	}

	public void setTb_fileName(String tb_fileName) {
		this.tb_fileName = tb_fileName;
	}

	public String getTb_orgFilename() {
		return tb_orgFilename;
	}

	public void setTb_orgFilename(String tb_orgFilename) {
		this.tb_orgFilename = tb_orgFilename;
	}

	public String getTb_fileSize() {
		return tb_fileSize;
	}

	public void setTb_fileSize(String tb_fileSize) {
		this.tb_fileSize = tb_fileSize;
	}

	public String getTb_previousseq() {
		return tb_previousseq;
	}

	public void setTb_previousseq(String tb_previousseq) {
		this.tb_previousseq = tb_previousseq;
	}

	public String getTb_previoussubject() {
		return tb_previoussubject;
	}

	public void setTb_previoussubject(String tb_previoussubject) {
		this.tb_previoussubject = tb_previoussubject;
	}

	public String getTb_nextseq() {
		return tb_nextseq;
	}

	public void setTb_nextseq(String tb_nextseq) {
		this.tb_nextseq = tb_nextseq;
	}

	public String getTb_nextsubject() {
		return tb_nextsubject;
	}

	public void setTb_nextsubject(String tb_nextsubject) {
		this.tb_nextsubject = tb_nextsubject;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	
	
}
