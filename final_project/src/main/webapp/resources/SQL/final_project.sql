show user;

select * from tab;

insert into name(name) 
values('임채혁');

commit;

select *
from name;

create table tbl_tripboard
(tb_seq           number                not null    -- 글번호
,fk_userid      varchar2(20)            not null    -- 사용자ID
,tb_name          varchar2(20)          not null    -- 글쓴이 
,tb_subject       Nvarchar2(200)        not null    -- 글제목
,tb_city        varchar2(20)            not null      -- 지역
,tb_content       clob                  not null    -- 글내용   CLOB(4GB 까지 저장 가능한 데이터 타입) 타입
,tb_pw            varchar2(20)          not null    -- 글암호
,tb_readCount     number default 0      not null    -- 글조회수
,tb_regDate       date default sysdate  not null    -- 글쓴시간
,tb_status        number(1) default 1   not null    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
,tb_fileName       varchar2(255)                    -- WAS(톰캣)에 저장될 파일명(2023112409291535243254235235234.png)                                       
,tb_orgFilename    varchar2(255)                    -- 진짜 파일명 
,tb_fileSize       number                           -- 파일크기  

,constraint PK_tbl_tripboard_tb_seq primary key(tb_seq)
,constraint FK_tbl_tripboard_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint CK_tbl_tripboard_tb_status check(tb_status in(0,1) )
);

desc tbl_tripboard;

select *
from tbl_tripboard
order by tb_seq desc;

select trim(tb_name)
from tbl_tripboard;

SELECT REPLACE(tb_name, ' ', '') AS tb_name
FROM tbl_tripboard;

SELECT 
    substr(tb_name, 1,1) || '*' || substr(tb_name, 4) AS tb_name
FROM tbl_tripboard;

update tbl_tripboard set tb_readCount = tb_readCount + 1
      where tb_seq= 203
commit;

create sequence tb_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;

create table tbl_tripbd_like
(fk_userid   varchar2(40) not null 
,fk_tb_seq     number(8) not null
,constraint  PK_tbl_tripbd_like primary key(fk_userid,fk_pnum)
,constraint  FK_tbl_tripbd_like_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_tripbd_like_t_seq foreign key(fk_t_seq) references tbl_tripboard(tb_seq) on delete cascade
);

create table tbl_review
(rv_seq  NVARCHAR2(10) -- 글 번호
,fk_lodge_id NVARCHAR2(10) not null -- 숙박시설 id
,fk_rs_seq  VARCHAR2(30) -- 예약번호
,rv_subject NVARCHAR2(200) -- 글제목
,rv_content NVARCHAR2(2000) -- 후기내용
,rv_regDate date default sysdate not null --작성일자
,rv_status NVARCHAR2(1) -- 글 삭제여부 (0: 삭제 / 1:삭제X)
,rv_rating number(1) -- 평점
,constraint PK_tbl_review_rv_seq primary key(rv_seq)
,constraint FK_tbl_review_fk_lodge_id foreign key (fk_lodge_id) references tbl_lodge(lodge_id)
,constraint FK_tbl_review_fk_rs_seq foreign key (fk_rs_seq) references tbl_reservation(rs_seq)
);

create sequence seq_tbl_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;





create table tbl_review_like
(fk_userid   varchar2(40) not null
,fk_rs_seq    number(5)    not null    -- 예약번호
,fk_tb_seq    number(8) not null
,constraint  PK_tbl_tripbd_like primary key(fk_userid,fk_pnum)
,constraint  FK_tbl_tripbd_like_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_tripbd_like_t_seq foreign key(fk_t_seq) references tbl_tripboard(tb_seq) on delete cascade
);

select *
from  tbl_lodge


------------------------------------------------숙소 세부 테이블 (시작) ------------------------------------------------------

SELECT tb_previousseq, tb_previoussubject
     , tb_seq , fk_userid, tb_name, tb_subject, tb_content, tb_readCount, tb_regDate, tb_pw
     , tb_nextseq, tb_nextsubject
     , tb_fileName, tb_orgFilename, tb_fileSize
FROM 
(
select lag(tb_seq, 1) over(order by tb_seq desc) AS tb_previousseq
     , lag(tb_subject, 1) over(order by tb_seq desc) AS tb_previoussubject 
     , tb_seq , fk_userid, tb_name, tb_subject, tb_content, tb_readCount
     , to_char(tb_regDate, 'yyyy-mm-dd hh24:mi:ss') AS tb_regDate, tb_pw
     , lead(tb_seq, 1) over(order by tb_seq desc) AS tb_nextseq
     , lead(tb_subject, 1) over(order by tb_seq desc) AS tb_nextsubject
     , tb_fileName, tb_orgFilename, tb_fileSize
from tbl_tripboard
where tb_status = 1
) V
WHERE V.tb_seq = 2;

update tbl_tripboard set tb_readCount = tb_readCount + 1
      where tb_seq = ${tb_seq}

------------------------------------------------숙소 세부 테이블 (끝) ------------------------------------------------------

create table tbl_review
(rv_seq  NVARCHAR2(10) -- 이용후기 글 번호
,fk_lodge_id NVARCHAR2(10) not null -- 숙박시설 id
,fk_rs_seq  VARCHAR2(30) -- 예약번호
,fk_userid 
,rv_subject NVARCHAR2(200) -- 글제목
,rv_content NVARCHAR2(2000) -- 후기내용
,rv_regDate date default sysdate not null --작성일자
,rv_status NVARCHAR2(1) -- 글 삭제여부 (0: 삭제 / 1:삭제X)
,fk_rv_rating number(2) -- 평점
,rv_groupno number   not null    -- 답변글쓰기에 있어서 그룹번호 
                                                 -- 원글(부모글)과 답변글은 동일한 groupno 를 가진다.
                                                 -- 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.
,rv_org_seq number default 0  not null   -- rv_org_seq 컬럼은 자신의 글(답변글)에 있어서 원글(rv_seq)이 누구인지에 대한 정보값이다.
                                                 -- 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 원글(부모글)의  컬럼의 값을 가지게 되며,
                                                 -- 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
,rv_depthno number default 0  not null  -- 답변글 여부 1이면 답글 0이면 원글 (들여쓰기용)
,constraint PK_tbl_review_rv_seq primary key(rv_seq)
,constraint FK_tbl_review_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_review_fk_lodge_id foreign key (fk_lodge_id) references tbl_lodge(lodge_id)
,constraint FK_tbl_review_fk_rs_seq foreign key (fk_rs_seq) references tbl_reservation(rs_seq)
,constraint FK_tbl_review_fk_rv_rating foreign key (fk_rv_rating) references tbl_rating(rv_rating)
);



create sequence seq_tbl_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

desc tbl_review

select *
from tbl_review;

select *
from tbl_rating;

select *
from tbl_lodge

ALTER TABLE TBL_REVIEW ADD rv_groupno NUMBER; 

ALTER TABLE TBL_REVIEW ADD rv_org_seq NUMBER DEFAULT 0;
ALTER TABLE TBL_REVIEW ADD rv_depthno NUMBER DEFAULT 0;

COMMIT;

select *
from tbl_comment

create table tbl_comment
(c_seq           number               not null   -- 댓글번호
,fk_h_userid     varchar2(100)           not null   -- 사용자ID
,fk_rv_seq       NVARCHAR2(10)                 not null   -- 원게시물 글번호
,c_content       varchar2(200)       not null   -- 댓글내용
,c_regDate       date default sysdate not null   -- 작성일자
,c_status        number(1) default 1    not null   -- 글삭제여부
                                               -- 1 : 사용가능한 글,  0 : 삭제된 글
                                               -- 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
,constraint PK_tbl_comment_c_seq primary key(c_seq)
,constraint FK_tbl_comment_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)
,constraint FK_tbl_comment_fk_rv_seq foreign key(fk_rv_seq) references tbl_review(rv_seq) on delete cascade
,constraint CK_tbl_comment_c_status check( c_status in(1,0) ) 
);

commit;

create table tbl_review_like
(fk_userid   VARCHAR2(20) not null 
,fk_rv_seq   NVARCHAR2(10) not null
,constraint  PK_tbl_review_like primary key(fk_userid,fk_rv_seq)
,constraint  FK_tbl_review_like_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint  FK_tbl_review_like_fk_rv_seq foreign key(fk_rv_seq) references tbl_review(rv_seq) on delete cascade
);

commit;


select *
from tbl_review
order by rv_seq desc;

select *
from tbl_rating;

select *
from tbl_review

select *
from TBL_RESERVATION





select *
from TBL_RESERVATION R
join tbl_review V on R.RS_SEQ  = V.FK_RS_SEQ
join tbl_rating A on A. rv_rating = V.fk_rv_rating 

SELECT *
FROM TBL_USER;


select *
from tbl_review R
join tbl_reservation S on R.FK_RS_SEQ = S.RS_SEQ
join tbl_rating A on A.rv_rating = R.fk_rv_rating;

select *
from tbl_comment

select *
from tbl_review R
join tbl_reservation S on R.FK_RS_SEQ = S.RS_SEQ
join tbl_rating A on A.rv_rating = R.fk_rv_rating;

select *
from tbl_review
order by rv_seq desc;


select *
from tbl_rating

select *
from tbl_comment;

DESC TBL_RESERVATION


select fk_rv_seq, fk_lodge_id, rv_subject, rv_content, rv_regdate, rv_status
     , rv_rating, rv_rating_desc, rv_groupno, rv_org_seq, rv_depthno, livedate
FROM 
(
SELECT C.fk_rv_seq, R.fk_lodge_id, R.rv_subject, R.rv_content, TO_CHAR(R.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS rv_regdate, R.rv_status,
     , A.rv_rating, A.rv_rating_desc, R.rv_groupno, R.rv_org_seq, R.rv_depthno
     , (TO_DATE(S.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(S.rs_checkindate, 'YYYY-MM-DD')) AS livedate     
FROM tbl_review R
left JOIN tbl_rating A ON A.rv_rating = R.fk_rv_rating
left JOIN tbl_comment C ON C.fk_rv_seq = R.rv_seq
left JOIN tbl_reservation S ON R.fk_rs_seq = S.rs_seq
)V
start with R.rv_seq = 1 
connect by prior R.rv_seq = C.c_seq 
order siblings by groupno desc, R.rv_seq desc

-------------------------------------------------------

select *
from tbl_review;

desc tbl_review;
/*
RV_SEQ       NOT NULL NVARCHAR2(10)   
FK_LODGE_ID  NOT NULL NVARCHAR2(10)   
FK_RS_SEQ             VARCHAR2(30)
FK_USERID             VARCHAR2(100)
FK_testseq            NVARCHAR2(10)
RV_SUBJECT            NVARCHAR2(200)  
RV_CONTENT            NVARCHAR2(2000) 
RV_REGDATE   NOT NULL DATE            
RV_STATUS             NVARCHAR2(1)    
FK_RV_RATING NOT NULL NUMBER(2)       
RV_GROUPNO   NOT NULL NUMBER          
RV_ORG_SEQ   NOT NULL NUMBER          
RV_DEPTHNO   NOT NULL NUMBER 
*/

ALTER TABLE tbl_review 
ADD (
    FK_USERID VARCHAR2(100), -- 예시: 새로운 컬럼 추가
    CONSTRAINT FK_tbl_review_fk_userid FOREIGN KEY(fk_userid) REFERENCES tbl_user(userid)
);

ALTER TABLE tbl_review 
ADD (
    FK_testseq NVARCHAR2(10)
);


commit;

desc tbl_comment;
/*
C_SEQ       NOT NULL NVARCHAR2(10)
FK_LODGE_ID NOT NULL NVARCHAR2(10)
FK_RS_SEQ             VARCHAR2(30)
FK_H_USERID           VARCHAR2(100) 
FK_RV_SEQ   NOT NULL NVARCHAR2(10)
C_SUBJECT            NVARCHAR2(200)
C_CONTENT   NOT NULL NVARCHAR2(2000) 
C_REGDATE   NOT NULL DATE          
C_STATUS    NOT NULL NVARCHAR2(1)
FK_C_RATING NOT NULL NUMBER(2) 
C_GROUPNO   NOT NULL NUMBER        
C_ORG_SEQ   NOT NULL NUMBER        
C_DEPTHNO   NOT NULL NUMBER
*/



-- 글 전체 조회 (관련성)
SELECT V.RV_SEQ, V.FK_LODGE_ID, V.FK_RS_SEQ, V.FK_USERID, R.RS_NAME, V.RV_SUBJECT, V.RV_CONTENT
     , TO_CHAR(V.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS RV_REGDATE, V.RV_STATUS, V.RV_GROUPNO, V.RV_ORG_SEQ, V.RV_DEPTHNO
     , V.FK_RV_RATING, T.RV_RATING_DESC
     , (TO_DATE(R.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(R.rs_checkindate, 'YYYY-MM-DD'))||'박' AS livedate, h.H_LODGENAME
FROM
(
select RV_SEQ,FK_LODGE_ID, FK_RS_SEQ, FK_USERID, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS,  RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_RV_RATING
from tbl_review
union all 
select C_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_H_USERID, C_SUBJECT, C_CONTENT, C_REGDATE, C_STATUS, C_GROUPNO, C_ORG_SEQ, C_DEPTHNO, FK_C_RATING
from tbl_comment
) V
left join tbl_reservation R ON R.RS_SEQ = V.FK_RS_SEQ
left join tbl_host H ON H.h_userid = V.fk_userid
left join tbl_rating T ON T.RV_RATING = V.FK_RV_RATING     
where RV_STATUS = 1
start with RV_ORG_SEQ = 0 
connect by prior RV_SEQ = RV_ORG_SEQ 
order siblings by RV_GROUPNO desc, RV_SEQ asc;



-- 글 전체 조회 (최고 평점순)
SELECT V.RV_SEQ, V.FK_LODGE_ID, V.FK_RS_SEQ, V.FK_USERID, R.RS_NAME, V.RV_SUBJECT, V.RV_CONTENT
     , TO_CHAR(V.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS RV_REGDATE, V.RV_STATUS, V.RV_GROUPNO, V.RV_ORG_SEQ, V.RV_DEPTHNO
     , V.FK_RV_RATING, T.RV_RATING_DESC
     , (TO_DATE(R.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(R.rs_checkindate, 'YYYY-MM-DD'))||'박' AS livedate, h.H_LODGENAME
FROM
(
select RV_SEQ,FK_LODGE_ID, FK_RS_SEQ, FK_USERID, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS,  RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_RV_RATING
from tbl_review
union all 
select C_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_H_USERID, C_SUBJECT, C_CONTENT, C_REGDATE, C_STATUS, C_GROUPNO, C_ORG_SEQ, C_DEPTHNO, FK_C_RATING
from tbl_comment
) V
left join tbl_reservation R ON R.RS_SEQ = V.FK_RS_SEQ
left join tbl_host H ON H.h_userid = V.fk_userid
left join tbl_rating T ON T.RV_RATING = V.FK_RV_RATING     
where RV_STATUS = 1
start with RV_ORG_SEQ = 0 
connect by prior RV_SEQ = RV_ORG_SEQ 
order siblings by V.FK_RV_RATING desc, RV_GROUPNO desc, RV_SEQ asc;


-- 글 전체 조회 (최저 평점순)
SELECT V.RV_SEQ, V.FK_LODGE_ID, V.FK_RS_SEQ, V.FK_USERID, R.RS_NAME, V.RV_SUBJECT, V.RV_CONTENT
     , TO_CHAR(V.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS RV_REGDATE, V.RV_STATUS, V.RV_GROUPNO, V.RV_ORG_SEQ, V.RV_DEPTHNO
     , V.FK_RV_RATING, T.RV_RATING_DESC
     , (TO_DATE(R.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(R.rs_checkindate, 'YYYY-MM-DD'))||'박' AS livedate, h.H_LODGENAME
FROM
(
select RV_SEQ,FK_LODGE_ID, FK_RS_SEQ, FK_USERID, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS,  RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_RV_RATING
from tbl_review
union all 
select C_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_H_USERID, C_SUBJECT, C_CONTENT, C_REGDATE, C_STATUS, C_GROUPNO, C_ORG_SEQ, C_DEPTHNO, FK_C_RATING
from tbl_comment
) V
left join tbl_reservation R ON R.RS_SEQ = V.FK_RS_SEQ
left join tbl_host H ON H.h_userid = V.fk_userid
left join tbl_rating T ON T.RV_RATING = V.FK_RV_RATING     
where RV_STATUS = 1
start with RV_ORG_SEQ = 0 
connect by prior RV_SEQ = RV_ORG_SEQ 
order siblings by V.FK_RV_RATING asc, RV_GROUPNO desc, RV_SEQ asc;




-- 글 최신 순으로 보여주기
SELECT V.RV_SEQ, V.FK_LODGE_ID, V.FK_RS_SEQ, V.FK_USERID, R.RS_NAME, V.RV_SUBJECT, V.RV_CONTENT
     , TO_CHAR(V.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS RV_REGDATE, V.RV_STATUS, V.RV_GROUPNO, V.RV_ORG_SEQ, V.RV_DEPTHNO
     , V.FK_RV_RATING, T.RV_RATING_DESC
     , (TO_DATE(R.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(R.rs_checkindate, 'YYYY-MM-DD')) || '박' AS livedate, h.H_LODGENAME
FROM (
    SELECT RV_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_USERID, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS, RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_RV_RATING
    FROM tbl_review
    UNION ALL 
    SELECT C_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_H_USERID, C_SUBJECT, C_CONTENT, C_REGDATE, C_STATUS, C_GROUPNO, C_ORG_SEQ, C_DEPTHNO, FK_C_RATING
    FROM tbl_comment
) V
LEFT JOIN tbl_reservation R ON R.RS_SEQ = V.FK_RS_SEQ
LEFT JOIN tbl_host H ON H.h_userid = V.fk_userid
LEFT JOIN tbl_rating T ON T.RV_RATING = V.FK_RV_RATING
WHERE V.RV_STATUS = 1
START WITH V.RV_ORG_SEQ = 0 
CONNECT BY PRIOR V.RV_SEQ = V.RV_ORG_SEQ 
ORDER SIBLINGS BY V.RV_SEQ desc, V.RV_GROUPNO DESC, V.RV_DEPTHNO ASC;




select *
from tbl_review

desc tbl_review



SELECT RV_SEQ,FK_LODGE_ID, FK_RS_SEQ, FK_USERID, 
       DECODE(NVL(FK_RV_SEQ, 0), 0, RV_SUBJECT
                                  , '[답글] : ' || RV_SUBJECT) AS RV_SUBJECT , 
       RV_CONTENT, RV_REGDATE, RV_STATUS, FK_RV_RATING, RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_RV_SEQ
FROM
(
select RV_SEQ,FK_LODGE_ID, FK_RS_SEQ, FK_USERID, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS, FK_RV_RATING, RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_TESTSEQ AS FK_RV_SEQ
from tbl_review
union all 
select C_SEQ, FK_LODGE_ID, FK_RS_SEQ, FK_H_USERID, C_SUBJECT, C_CONTENT, C_REGDATE, C_STATUS,  FK_C_RATING, C_GROUPNO, C_ORG_SEQ, C_DEPTHNO, FK_RV_SEQ 
from tbl_comment
) V
where RV_STATUS = 1
start with NVL(FK_RV_SEQ, 0) = 0 
connect by prior RV_SEQ = FK_RV_SEQ 
order siblings by RV_GROUPNO desc, RV_SEQ asc;

-- join 하고 싶은 테이블      컬럼명
-- tbl_reservation        rs_checkinDate, rs_checkoutDate
-- tbl_rating             rv_rating_desc
-- tbl_host               h_lodgename


/*
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     RV_SEQ  FK_LODGE_ID  FK_RS_SEQ   FK_USERID  RV_SUBJECT  RV_CONTENT  RV_REGDATE  RV_STATUS  RV_GROUPNO  RV_ORG_SEQ  RV_DEPTHNO FK_RV_RATING  tbl_rating.RV_RATING_DESC  
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  -- 너무 길어서 아래 이어서
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tbl_reservation.rs_checkinDate  tbl_reservation.rs_checkoutDate   tbl_reservation.rs_checkinDate  tbl_reservation.rs_checkinDate  tbl_host.h_lodgename  
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/










select *
from tbl_review R left join tbl_comment C
on  R.rv_seq = C.fk_rv_seq

-------------------------------------------------------

select R.rv_seq, R.fk_lodge_id, R.rv_subject, R.rv_content, TO_CHAR(R.rv_regdate, 'yyyy"년" mm"월" dd"일"') AS rv_regdate,
      R.rv_status, A.rv_rating, A.rv_rating_desc, R.rv_groupno, R.rv_org_seq, R.rv_depthno,
      (TO_DATE(S.rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(S.rs_checkindate, 'YYYY-MM-DD')) AS livedate
from tbl_review R
left join tbl_reservation S on S.rs_seq = R.fk_rs_seq
left join tbl_comment C on C.fk_rv_seq = R.rv_seq
left JOIN tbl_rating A ON A.rv_rating = R.fk_rv_rating
order by 1 desc






select *
FROM tbl_review R
JOIN tbl_rating A ON A.rv_rating = R.fk_rv_rating
JOIN tbl_comment C ON C.fk_rv_seq = R.rv_seq
JOIN tbl_reservation S ON R.fk_rs_seq = S.rs_seq

select *
from tbl_review;




SELECT (TO_DATE(rs_checkoutdate, 'YYYY-MM-DD') - TO_DATE(rs_checkindate, 'YYYY-MM-DD')) AS day_diff
FROM tbl_reservation;


select seq, fk_userid, name, subject
          , readCount, to_char(regDate, 'yyyy-mm-dd hh24:mi:ss') AS regDate 
          , commentCount
          , groupno, fk_seq, depthno 
     from tbl_board
     where status = 1
     start with fk_seq = 0 
     connect by prior seq = fk_seq 
     order siblings by groupno desc, seq asc





ALTER TABLE tbl_rating
MODIFY rv_rating NUMBER(2) DEFAULT 0;

commit;

ALTER TABLE tbl_review
MODIFY fk_rv_rating NUMBER(2) DEFAULT 0 NOT NULL;

commit;

select round(avg(fk_rv_rating) , 1) AS AVG_RATING
from tbl_review;



select fk_rv_rating
     , round(count(*) / (select count(*) from tbl_review) * 100 , 1 ) AS rating_pct
from tbl_review
group by fk_rv_rating




SELECT 'Average' AS category, ROUND(AVG(fk_rv_rating), 1) AS avg_rating, NULL AS fk_rv_rating, NULL AS rating_pct
FROM tbl_review
UNION ALL
SELECT 'Percentage', NULL, fk_rv_rating, ROUND(COUNT(*) / (SELECT COUNT(*) FROM tbl_review) * 100, 1) AS rating_pct
FROM tbl_review
GROUP BY fk_rv_rating;


SELECT *
FROM TBL_REVIEW




-- 평점, 평점멘트, 각 점수별 개수, 백분율 
SELECT 
    R.FK_RV_RATING AS RATING,
    RA.RV_RATING_DESC AS RATING_DESC,
    SUM(CASE WHEN R.FK_RV_RATING = 2 THEN 1 ELSE 0 END) AS RATING2,
    SUM(CASE WHEN R.FK_RV_RATING = 4 THEN 1 ELSE 0 END) AS RATING4,
    SUM(CASE WHEN R.FK_RV_RATING = 6 THEN 1 ELSE 0 END) AS RATING6,
    SUM(CASE WHEN R.FK_RV_RATING = 8 THEN 1 ELSE 0 END) AS RATING8,
    SUM(CASE WHEN R.FK_RV_RATING = 10 THEN 1 ELSE 0 END) AS RATING10,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM TBL_REVIEW) * 100, 1) AS RATING_PCT
    )V
FROM TBL_REVIEW R
JOIN TBL_RATING RA ON R.FK_RV_RATING = RA.RV_RATING
GROUP BY R.FK_RV_RATING, RA.RV_RATING_DESC;

-- 전체평균, 총 이용후기 개수
SELECT ROUND(AVG(FK_RV_RATING), 1), COUNT(FK_RV_RATING)
FROM TBL_REVIEW;
