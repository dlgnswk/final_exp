show user;

select * from tab;

insert into name(name) 
values('임채혁');

commit;

select *
from name;

create table tbl_tripboard
(tb_seq           number                not null    -- 글번호
,fk_userid      varchar2(20)           not null    -- 사용자ID
,tb_name          varchar2(20)          not null    -- 글쓴이 
,tb_subject       Nvarchar2(200)        not null    -- 글제목
,tb_city        varchar2(20)          not null     -- 지역
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


create sequence tb_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


create table tbl_tripbd_like
(fk_userid   varchar2(40) not null 
,fk_tb_seq     number(8) not null
,constraint  PK_tbl_tripbd_like primary key(fk_userid,fk_pnum)
,constraint  FK_tbl_tripbd_like_userid foreign key(fk_userid) references tbl_member(userid)
,constraint  FK_tbl_tripbd_like_t_seq foreign key(fk_t_seq) references tbl_tripboard(tb_seq) on delete cascade
);

create table tbl_review (
    rv_seq           number                not null,    -- 글번호
    fk_rs_seq        number(5)             not null,    -- 예약번호
    rv_name          varchar2(20)          not null,    -- 글쓴이 
    rv_subject       Nvarchar2(200)        not null,    -- 글제목
    rv_content       Nvarchar2(2000)       not null,    -- 글내용
    rv_regDate       date default sysdate  not null,    -- 글쓴시간
    rv_status        number(1) default 1   not null,    -- 글삭제여부   1:사용가능한 글,  0:삭제된글
    rv_rating        NUMBER(2,0)
                     CHECK (rv_rating IN (2, 4, 6, 8, 10)), -- 평점 제약조건
    constraint PK_tbl_review_rv_seq primary key(rv_seq),
    constraint FK_tbl_review_fk_rs_seq foreign key(fk_rs_seq) references tbl_rs_buyer(rs_seq),
    constraint CK_tbl_review_rv_status check(rv_status in (0,1))
);

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

-- 전망



------------------------------------------------숙소 세부 테이블 (끝) ------------------------------------------------------





