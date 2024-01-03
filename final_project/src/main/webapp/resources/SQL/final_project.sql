show user;

select * from tab;

select * 
from tbl_user;

select count(*) 
from tbl_user;

select count(*)
		from tbl_user
		where 1=1	


select userid, name, email, mobile, point, user_lvl, role, registerDate, idle
from
(
select row_number() over (order by registerDate desc) as rno,
       userid, name, email, user_lvl, mobile, role, point, idle,
       to_char(registerDate,'yyyy-mm-dd') as registerDate
from tbl_user
where 1=1
  and user_lvl = 0
and lower(userid) like '%'||lower('@')||'%'
)
WHERE rno between 1 and 5;








select userid
from tbl_user
where 1=1
and lower(userid) like '%'||lower('te')||'%'
order by registerDate asc

select *
from tbl_host


create table tbl_host
(h_userid   varchar2(100)
,h_pw   varchar2(100)   not null
,h_name   varchar2(100)  
,h_mobile    varchar2(30)
,h_postcode   varchar2(5)
,h_address   varchar2(100)
,h_detailAddress   varchar2(100)
,h_extraAddress   varchar2(100)
,h_registerDate       date default sysdate not null
,h_lastpwdchangedate  date default sysdate
,h_status             number(1)   not null
,h_propType   varchar2(20)
,h_roomCnt   NUMBER(3)
,h_legalName   varchar2(100) not null
,h_businessNo   number(10)  not null
,h_chainStatus   varchar2(20) 
,constraint PK_tbl_host_h_userid primary key(h_userid)
);



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

create table tbl_review
(rv_seq  NVARCHAR2(10) -- 이용후기 글 번호
,fk_lodge_id NVARCHAR2(10) not null -- 숙박시설 id
,fk_rs_seq  VARCHAR2(30) -- 예약번호
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
,constraint FK_tbl_review_fk_lodge_id foreign key (fk_lodge_id) references tbl_lodge(lodge_id)
,constraint FK_tbl_review_fk_rs_seq foreign key (fk_rs_seq) references tbl_reservation(rs_seq)
,constraint FK_tbl_review_fk_rv_rating foreign key (fk_rv_rating) references tbl_rating(rv_rating)
);



create table tbl_host
(h_userid   varchar2(100) -- 판매자아이디 
,h_pw   varchar2(100)   not null -- 비밀번호
,h_name   varchar2(100)  not null -- 판매자명
,h_lodgename   varchar2(100) not null -- 사업장명       
,h_email    varchar2(100) not null -- 이메일
,h_mobile    varchar2(30) not null -- 연락처
,h_postcode   varchar2(5) not null -- 사업자 우편번호
,h_address   varchar2(100) not null -- 사업자 주소
,h_detailAddress   varchar2(100)     -- 사업자상세주소
,h_extraAddress   varchar2(100)      -- 사업자참고주소
,h_registerDate       date default sysdate not null -- 계정가입일자
,h_lastpwdchangedate  date default sysdate -- 마지막으로 암호를 변경한 날짜
,h_status             number(1) default 0 not null -- 사업자승인유무  0 : 관리자승인 x // 1 : 관리자승인 o // 2 : 관리자승인x
,h_legalName   varchar2(100) not null -- 사업자법인명
,h_businessNo   varchar2(12)  not null -- 사업자번호
,constraint PK_tbl_host_h_userid primary key(h_userid)
);


 -- h_userid     h_name  h_legalName        h_businessNo
select *
		from tbl_host
		where 1=1	
        and lower(h_lodgename) like '%'||lower('파라다이스')||'%'


insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('paradise743@gmail.com','18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '최종환', '파라다이스 시티 호텔', 'paradise743@gmail.com', '010-4564-7897', '22382', '인천광역시 중구','영종해안남로 321번길','186',default,default,0,'㈜파라다이스','121-86-18441')


commit;


select rno, h_userid, h_name, h_mobile, h_legalName, h_lodgename, h_address, h_detailAddress, h_extraAddress, h_businessNo,h_status
		from
		(
		select row_number() over (order by h_registerDate desc) as rno,
		       h_userid, h_name, h_mobile, h_legalName, h_lodgename,
               h_address, h_detailAddress, h_extraAddress, h_businessNo, h_status
		from tbl_host
		where 1=1
		and lower(h_userid) like '%'||lower('paradise')||'%'
		)
		WHERE rno between 1 and 10
        
        
        
        
 -------------------------------------------- 숙소등록 insert 문 시작
 
 
-- 숙박시설등록 테이블
create table tbl_lodge
(lodge_id               Nvarchar2(10)       not null            -- 숙박시설ID / ex) SIRA0001, WTWQ1234
,fk_h_userid            varchar2(100)       not null            -- 사업자아이디 / 참조키를 넣어야함! 어디에? 숙박업자 판매자에 
,lg_name                Nvarchar2(40)       not null            -- 숙박시설 이름 / 
,lg_en_name             Nvarchar2(80)       not null            -- 호텔영문명 / sin hotel busan
,lg_postcode            Nvarchar2(5)        not null            -- 우편번호 / 12345 02134 

,lg_address             Nvarchar2(50)       not null            -- 주소 
,lg_detailaddress       Nvarchar2(30)                           -- 상세주소
,lg_extraaddress        Nvarchar2(30)                           -- 참고항목 
,lg_latitude            Nvarchar2(20)       not null            -- 지역위도 / 123.41235521251
,lg_longitude           Nvarchar2(20)       not null            -- 지역경도 / 55.2315234124

,lg_hotel_star          Nvarchar2(10)                           -- 호텔등급 (몇성급) / lg_hotel_star
,lg_area                Nvarchar2(10)       not null            -- 지역명 / 서울
,lg_area_2              Nvarchar2(10)       not null            -- 지역명2 / 서대문구
,fk_lodge_type          Nvarchar2(2)        not null            -- 숙박시설유형 / 0,1,2,3,4,5
                                                                     -- 0:호텔
                                                                     -- 1:모텔
                                                                     -- 2:아파트식호텔(레지던스)
                                                                     -- 3:리조트
                                                                     -- 4:펜션
,lg_qty                 Nvarchar2(2)        not null            -- 객실수 / 숫자

,fk_cancel_opt          Nvarchar2(2)        not null            -- 취소정책옵션번호 / 0,1,2,4
                                                                      -- 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
                                                                      -- 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
                                                                      -- 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
                                                                      -- 3 : 체크인 1시간 이전 : 100% 환불가능
,fd_status              Nvarchar2(2)        not null            -- 프런트데스크 / 0:없음, 1:있음
,fd_time                Nvarchar2(30)                           -- 프런트데스크운영시간 / '없음' or '09:00 AM ~ 09:00 PM' or '24시간'
,FK_S_CHECKIN_TYPE     Nvarchar2(2)        not null            -- 셀프체크인방법 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_checkin_start_time  Nvarchar2(30)       not null            -- 체크인시간_시작 / 09:00 AM

,lg_checkin_end_time    Nvarchar2(30)       not null            -- 체크인시간_마감 / 09:00 PM
,lg_checkout_time       Nvarchar2(20)       not null            -- 체크아웃 (가능)시간 / 01:00 AM ~ 11:00 PM / 1시간 간격
,lg_age_limit           Nvarchar2(4)        not null            -- 제한나이 / 15~25
,lg_internet_yn         Nvarchar2(2)        not null            -- 인터넷제공 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_park_yn             Nvarchar2(2)        not null            -- 주차장 / 0:없음, 1:있음 --> 이후 체크박스 선택

,lg_breakfast_yn        Nvarchar2(2)        not null            -- 아침식사 / 0:제공안됨, 1:제공됨
,lg_dining_place_yn     Nvarchar2(2)        not null            -- 다이닝 장소 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_pool_yn             Nvarchar2(2)        not null            -- 수영장타입 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_pet_yn              Nvarchar2(2)        not null            -- 반려동물 / 0:불가, 1:허용
,lg_pet_fare            Nvarchar2(10)                           -- 반려동물 요금 / null, 1마리당 요금 <input> ex) 30000

,lg_fac_yn              Nvarchar2(2)        not null            -- 장애인 편의시설타입 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_service_yn          Nvarchar2(2)        not null            -- 고객서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_rm_service_yn       Nvarchar2(2)        not null            -- 객실 용품 및 서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_beach_yn            Nvarchar2(2)        not null            -- 해변 / 0:없음,1:있음 -- 없음 / 근처해변 이용
,lg_business_yn         Nvarchar2(2)        not null            -- 비즈니스 / 0:없음,1:있음 --> 이후 체크박스 선택

,lg_fa_travel_yn        Nvarchar2(2)        not null            -- 가족여행 / 0:없음,1:있음 --> 이후 체크박스 선택
,fk_spa_type            Nvarchar2(2)        not null            -- 스파 / 0:없음, 1:풀서비스 스파, 2:시설 내 스파서피스
,lg_smoke_yn            Nvarchar2(2)        not null            -- 흡연구역 / 0:없음, 1:있음
,lg_baggage_yn          Nvarchar2(2)        not null            -- 짐 보관 서비스 / 0:없음, 1:있음
,lg_locker_yn           Nvarchar2(2)        not null            -- 사물함 이용 가능 / 0:없음, 1:있음

,lg_laundry_yn          Nvarchar2(2)        not null            -- 세탁 시설 유무 / 0:없음, 1:있음
,lg_housekeep_yn        Nvarchar2(2)        not null            -- 하우스키핑 서비스 유무 / 0:없음, 1:있음
,lg_status              NVARCHAR2(2)        default 0;          -- 
-- 기본키 --
,constraint PK_tbl_lodge_lodge_id primary key(lodge_id)
-- 참조 제약 --
,constraint FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)                         -- 아이디 참조제약
,constraint FK_tbl_lodge_fk_lodge_type foreign key(fk_lodge_type) references tbl_lodge_type(lodge_type)             -- 숙박시설유형 참조제약
,constraint FK_tbl_lodge_fk_cancel_opt foreign key(fk_cancel_opt) references tbl_cancel(cancel_opt)                 -- 취소정책옵션_번호 참조제약
,constraint FK_TBL_LODGE_FK_S_CHECKIN_TYPE foreign key(fk_self_checkin_yn) references tbl_checkin(self_checkin)       -- 셀프체크인방법 참조제약 (30글자초과)
)
-- Table TBL_LODGE이(가) 생성되었습니다.


-- 42개
insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('숙박시설ID--SIRA0001, WTWQ1234', '사업자아이디--dodoh@naver.com?', '숙박시설--신라호텔부평점', '호텔영문명--sin hotel busan', '우편번호--02134'
     , '주소--부산진구 가야대로 772','상세주소--null ', '참고항목--null', '지역위도--123.41235521251', '지역경도--55.2315234124'
     , '호텔등급--4성급','지역명--부산진구 ', '지역명2--가야대로', '숙박시설유형--4', '객실수--120'
     , '취소정책옵션번호--0','프런트데스크--0 ', '프런트데스크운영시간--없음', '셀프체크인방법--0', '체크인시간_시작--09:00 AM'
     , '체크인시간_마감--09:00 PM', '체크아웃 (가능)시간--10:00PM', '제한나이--2', '인터넷제공--0', '주차장--1'
     , '아침식사--1', '다이닝 장소--1', '수영장타입--1', '반려동물--1','반려동물 요금--30000'
     , '장애인 편의시설타입--1', '고객서비스--1', '객실 용품 및 서비스--0', '해변--1' ,'비즈니스--1'
     , '가족여행--1', '스파--1','흡연구역--0', '짐 보관 서비스--0', '사물함 이용 가능--0'
     , '세탁 시설 유무--0', '하우스키핑 서비스 유무--0', '시설승인상태-default')
 
 

 
 select *
 from tbl_lodge
 
 
 insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('PARA0001', 'p-city@paradian.com', '파라다이스시티', 'PARADICE CITY', '22382', '인천광역시 중구 영종해안남로 321번길 186',
     '','(운서동)', '37.43719327778538', '126.45573891343707', '5', '인천광역시', '중구', '0', '711'
     ,'0', '1', '24시간', '0', '3:00 PM'
     , '자정', '11:00 AM', '19', '1', '1'
     , '1', '1', '1', '0',''
     , '1', '1', '1', '0' ,'1'
     , '1', '2','1', '1', '0'
     , '1', '1', default);
 
 COMMIT;
 
 
 
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'PARA0001', '0');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'PARA0001', '1');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'PARA0001', '2');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'PARA0001', '3');

insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '0');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '1');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '2');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '4');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '5');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '6');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '7');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'PARA0001', '8');

commit;


insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'PARA0001', '1');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'PARA0001', '2');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'PARA0001', '3');

commit;

insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'PARA0001', '3');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'PARA0001', '4');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'PARA0001', '5');

commit;
 
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'PARA0001','0'); 
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'PARA0001','1'); 
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'PARA0001','2'); 
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'PARA0001','3'); 

select *
from tbl_inet

commit; 

insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'PARA0001','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'PARA0001','3');

 commit; 
 
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'PARA0001','0');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'PARA0001','1');

commit;

insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'PARA0001','0');
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'PARA0001','1');

commit;


insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'PARA0001','0');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'PARA0001','1');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'PARA0001','2');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'PARA0001','3');

commit;


insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_cnt,rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval<--이건 고정으로 건들지 말기!!, 'fk_시설id', '객실이름', '객실수', '침실개수', '흡연유무'
       , '객실크기(제곱미터)-숫자만', '객실크기(평)-소수점1자리까지', '침대 추가 가능여부'
       , '싱글침대 개수-없으면 공백(null)', '슈퍼싱글침대 개수', '더블침대 개수', '퀸사이즈침대 개수', '킹사이즈침대 개수'
       , '휠체어이용가능 유무', '전용욕실갯수-없으면0', '공용욕실유무', '주방(조리시설)유무', 'fk_전망옵션'
       , '객실 내 다과 유무', '객실 내 엔터테인먼트 유무', '온도조절기 유무', '투숙가능인원', '숙박요금', '조식포함 유무');

rollback
select *
from tbl_room
begin       
    for i in 1..10 loop
        insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
               , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
               , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                        , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
               , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
        values('rm-'||seq_tbl_room.nextval, 'PARA0001', '디럭스 트윈룸', 객실수, '1', '0'
               , '45', '13.6', '0'
               , '', '', '2', '', ''
               , '1', '1', '0', '0', '2' -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망 / 6 : 호수 전망
               , '0', '1', '1', '2', '610000', '0')
    end loop;
end;

       insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
               , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
               , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                        , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
               , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
        values('rm-'||seq_tbl_room.nextval, 'PARA0001', '디럭스 더블룸', 객실수, '1', '0'
               , '45', '13.6', '0'
               , '', '', '', '', '1'
               , '1', '1', '0', '0', '2' -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망 / 6 : 호수 전망
               , '0', '1', '1', '3', '610000', '0')
               
               
        insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
               , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
               , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                        , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
               , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
        values('rm-'||seq_tbl_room.nextval, 'PARA0001', '디럭스 스위트 더블룸', 객실수, '1', '0'
               , '90', '27.2', '0'
               , '', '', '', '', '1'
               , '1', '1', '0', '0', '2' -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망 / 6 : 호수 전망
               , '0', '1', '1', '2', '710000', '1')
               
        insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
               , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
               , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                        , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
               , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
        values('rm-'||seq_tbl_room.nextval, 'PARA0001', '그랜드 프리미어 디럭스 더블룸', 객실수, '1', '0'
               , '60', '18.2', '0'
               , '', '', '', '', '1'
               , '1', '1', '0', '0', '2' -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망 / 6 : 호수 전망
               , '0', '1', '1', '2', '490000', '0')

commit;

insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '2');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-32', '5');

insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '2');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-33', '5');

insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '2');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-34', '5');

insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '2');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-35', '5');


commit;


select *
from tbl_snack
 

insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-32', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-32', '2');

insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-33', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-33', '2');

insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-34', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-34', '2');

insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-35', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-35', '2');

commit;

insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-32', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-33', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-34', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-35', '0');

commit;


insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-32', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-33', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-34', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-35', '0');

commit;

 <인터넷> tbl_inet
0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'GWGN0001','0');

<주차장> tbl_park
0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'GWGN0001','0');

<다이닝> tbl_din
0 : 레스토랑 / 1 : 카페 / 2 : 바
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'GWGN0001','0');

<수영장> tbl_pool
0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no,pool_use_time)values(seq_tbl_pool.nextval, 'GWGN0001','0','');

<장애인편의시설> tbl_fac
0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','0');

<고객서비스> tbl_cs
0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '0');

<객실서비스> tbl_rmsvc
0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '2');

<비즈니스> tbl_bsns
0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'GWGN0001', '1');

<가족여행> tbl_fasvc
0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'GWGN0001', '1');


<<< 객실테이블(tbl_room) INSERT 문 예시 >>>
객실테이블(tbl_room) insert 문 // 유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''

insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('객실고유번호', 'fk_시설id', '객실이름', '침실개수', '흡연유무'
       , '객실크기(제곱미터)-숫자만', '객실크기(평)-소수점1자리까지', '침대 추가 가능여부'
       , '싱글침대 개수-없으면 공백(null)', '슈퍼싱글침대 개수', '더블침대 개수', '퀸사이즈침대 개수', '킹사이즈침대 개수'
       , '휠체어이용가능 유무', '전용욕실갯수-없으면0', '공용욕실유무', '주방(조리시설)유무', 'fk_전망옵션'
       , '객실 내 다과 유무', '객실 내 엔터테인먼트 유무', '온도조절기 유무', '투숙가능인원', '숙박요금', '조식포함 유무');




<<< 객실테이블(tbl_room) 입력 후 옵션테이블 입력 예시 >>>

<욕실> tbl_bath
0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-2', '0');

<주방> tbl_kitchen
0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
insert into tbl_kitchen(kt_seq, fk_rm_seq, fk_kt_opt_no) values(seq_tbl_kitchen.nextval, rm-2, '0');

<객실내다과> tbl_snack
0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-2', '0');

<객실내엔터> tbl_ent
0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-2', '0');

<온도조절기> tbl_tmp
0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-2', '0');
 
 
 -------------------------------------------- 숙소등록 insert 문 끝 


-- ※주의 : tbl_host에 있는 법인명, 대표자명, 사업자번호와 같도록 작성해주세요.
create table tbl_irs (
    i_legalName     varchar2(100)   not null,    -- 국세청에 등록된 법인명
    i_name          varchar2(100)   not null,    -- 국세청에 등록된 대표자명
    i_businessNo    Nvarchar2(12)   not null,   -- 국세청에 등록된 사업자번호  '000-00-00000' 형식으로 입력
    constraint PK_tbl_irs_i_legalName primary key(i_legalName)
);

 -- ㈜파라다이스 121-86-18441
 -- lotte 123-45-78901 최우현
 
 insert into tbl_irs(i_legalName, i_name, i_businessNo)
 values('㈜파라다이스','최종환','121-86-18441');
 
 
 commit;
 
 
 select count(*)
 from tbl_irs
 where i_legalName = '㈜파라다이스' and i_name = '최종환' and i_businessNo = '121-86-18441'

-------- ***** >>>> 객실(room) 관련 테이블 & 시퀀스 생성 시작!! <<<< ***** --------

create table tbl_view
(view_no nvarchar2(2)    not null -- 전망_옵션
,view_desc nvarchar2(30) not null -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망 / 6 : 호수 전망
,constraint PK_tbl_view_view_no primary key(view_no)
);

create table tbl_room
(rm_seq           nvarchar2(15) not null -- 객실고유번호
,fk_lodge_id      nvarchar2(10) not null -- fk_시설id
,rm_type          nvarchar2(30) not null -- 객실이름(type)
,rm_bedrm_cnt     nvarchar2(2)  not null -- 침실개수
,rm_smoke_yn      nvarchar2(1) -- 흡연유무 (0: 불가 / 1: 가능)
,rm_size_feet     nvarchar2(4) -- 객실크기(제곱피트)
,rm_size_meter    nvarchar2(4) -- 객실크기(제곱미터)
,rm_size_pyug     nvarchar2(3) -- 객실크기(평)
,rm_extra_bed_yn  nvarchar2(1) -- 침대 추가 가능여부 (0: 불가 / 1: 가능)
,rm_single_bed    nvarchar2(2) -- 싱글침대 개수
,rm_ss_bed        nvarchar2(2) -- 슈퍼싱글침대 개수
,rm_double_bed    nvarchar2(2) -- 더블침대 개수
,rm_queen_bed     nvarchar2(2) -- 퀸사이즈침대 개수
,rm_king_bed      nvarchar2(2) -- 킹사이즈침대 개수
,rm_wheelchair_yn nvarchar2(1) -- 휠체어이용가능 유무 (0: 무 / 1: 유)
,rm_bathroom_cnt  nvarchar2(1) not null -- 전용욕실갯수
,rm_p_bathroom_yn nvarchar2(1) -- 공용욕실유무
,rm_kitchen_yn    nvarchar2(1) -- 주방(조리시설)유무 (0: 무 / 1: 유)
,fk_view_no       nvarchar2(2) -- fk_전망옵션
,rm_snack_yn      nvarchar2(1) -- 객실 내 다과
,rm_ent_yn        nvarchar2(1) -- 객실 내 엔터테인먼트
,rm_tmp_ctrl_yn   nvarchar2(1) -- 온도조절기
,rm_guest_cnt     nvarchar2(2)  not null -- 투숙가능인원
,rm_price         nvarchar2(10) not null -- 숙박요금
,rm_breakfast_yn  nvarchar2(1) -- 조식포함 유무(불포함시 금액지불) / 호텔에서 조식서비스를 제공할때만 선택가능 (0: 무 / 1: 유)
,constraint PK_tbl_room_rm_seq      primary key(rm_seq) 
,constraint FK_tbl_room_fk_lodge_id foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_room_fk_view_no  foreign key(fk_view_no) REFERENCES tbl_view(view_no)
);




create table tbl_bath_opt
(bath_opt_no   nvarchar2(2)  not null
,bath_opt_desc nvarchar2(30) not null -- 0 : 타월제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
,constraint PK_tbl_bath_opt_bath_opt_no primary key(bath_opt_no) 
);

create table tbl_kt_opt
(kt_opt_no   nvarchar2(2)  not null
,kt_opt_desc nvarchar2(30) not null-- 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
,constraint PK_tbl_kt_opt_kt_opt_no primary key(kt_opt_no) 
);

create table tbl_snk_opt
(snk_opt_no   nvarchar2(2)   not null
,snk_opt_desc nvarchar2(30)  not null-- 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바(라운지 이용일때 선택)
,constraint PK_tbl_snk_opt_snk_opt_no primary key(snk_opt_no) 
);

create table tbl_ent_opt
(ent_opt_no   nvarchar2(2) not null
,ent_opt_desc nvarchar2(30)  not null-- 0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
,constraint PK_tbl_ent_opt_ent_opt_no primary key(ent_opt_no) 
);

create table tbl_tmp_opt
(tmp_opt_no nvarchar2(2)    not null
,tmp_opt_desc nvarchar2(30) not null -- 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
,constraint PK_tbl_tmp_opt_tmp_opt_no primary key(tmp_opt_no)
);


create table tbl_tmp
(tmp_seq number(10)          not null
,fk_rm_seq nvarchar2(15)     not null
,fk_tmp_opt_no nvarchar2(30) not null-- 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
,constraint PK_tbl_tmp_tmp_seq       primary key(tmp_seq)
,constraint FK_tbl_tmp_fk_rm_seq      foreign key(fk_rm_seq) REFERENCES tbl_room(rm_seq)
,constraint FK_tbl_tmp_fk_tmp_opt_no  foreign key(fk_tmp_opt_no) REFERENCES tbl_tmp_opt(tmp_opt_no)
);

create table tbl_ent
(ent_seq       number(10)     not null
,fk_rm_seq     nvarchar2(15)  not null
,fk_ent_opt_no nvarchar2(2)   not null
,constraint PK_tbl_ent_ent_seq        primary key(ent_seq)
,constraint FK_tbl_ent_fk_rm_seq      foreign key(fk_rm_seq) REFERENCES tbl_room(rm_seq)
,constraint FK_tbl_ent_fk_ent_opt_no  foreign key(fk_ent_opt_no) REFERENCES tbl_ent_opt(ent_opt_no)
);

create table tbl_snack
(snack_seq     number(10)      not null
,fk_rm_seq     nvarchar2(15)   not null
,fk_snk_opt_no nvarchar2(2)    not null
,constraint PK_tbl_snack_snack_seq      primary key(snack_seq)
,constraint FK_tbl_snack_fk_rm_seq      foreign key(fk_rm_seq) REFERENCES tbl_room(rm_seq)
,constraint FK_tbl_snack_fk_snk_opt_no  foreign key(fk_snk_opt_no) REFERENCES tbl_snk_opt(snk_opt_no)
);

create table tbl_kitchen
(kt_seq        number(10)    not null
,fk_rm_seq     nvarchar2(15) not null
,fk_kt_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_kitchen_kt_seq        primary key(kt_seq)
,constraint FK_tbl_kitchen_fk_rm_seq     foreign key(fk_rm_seq) REFERENCES tbl_room(rm_seq)
,constraint FK_tbl_kitchen_fk_kt_opt_no  foreign key(fk_kt_opt_no) REFERENCES tbl_kt_opt(kt_opt_no)
);

create table tbl_bath
(bath_seq       number(10)    not null
,fk_rm_seq      nvarchar2(15) not null
,fk_bath_opt_no nvarchar2(2)  not null
,constraint PK_tbl_bath_bath_seq       primary key(bath_seq)
,constraint FK_tbl_bath_fk_rm_seq      foreign key(fk_rm_seq) REFERENCES tbl_room(rm_seq)
,constraint FK_tbl_bath_fk_bath_opt_no foreign key(fk_bath_opt_no) REFERENCES tbl_bath_opt(bath_opt_no)
);

create sequence seq_tbl_bath
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_kitchen
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_snack
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_ent
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_tmp
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-------- ***** >>>> 숙소(lodge) 관련 테이블 & 시퀀스 생성 시작!! <<<< ***** --------
create table tbl_inet_opt
(inet_opt_no   nvarchar2(2)  not null
,inet_opt_desc nvarchar2(30) not null -- 0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
,constraint PK_tbl_inet_opt_inet_opt_no primary key(inet_opt_no) 
);

create table tbl_park_opt
(park_opt_no   nvarchar2(2)  not null
,park_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
,constraint PK_tbl_park_opt_park_opt_no primary key(park_opt_no) 
);

create table tbl_din_opt
(din_opt_no   nvarchar2(2)   not null
,din_opt_desc nvarchar2(30)  not null-- 0 : 레스토랑 / 1 : 카페 / 2 : 바
,constraint PK_tbl_din_opt_din_opt_no primary key(din_opt_no) 
);

create table tbl_pool_opt
(pool_opt_no   nvarchar2(2) not null
,pool_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
,constraint PK_tbl_pool_opt_pool_opt_no primary key(pool_opt_no) 
);

create table tbl_fac_opt
(fac_opt_no   nvarchar2(2)  not null
,fac_opt_desc nvarchar2(30) not null -- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
,constraint PK_tbl_fac_opt_fac_opt_no primary key(fac_opt_no) 
);

create table tbl_cs_opt
(cs_opt_no   nvarchar2(2)  not null
,cs_opt_desc nvarchar2(30) not null -- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 
                                    -- 5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
,constraint PK_tbl_cs_opt_cs_opt_no primary key(cs_opt_no) 
);

create table tbl_rmsvc_opt
(rmsvc_opt_no   nvarchar2(2)  not null
,rmsvc_opt_desc nvarchar2(30) not null -- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터
                                       -- 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
,constraint PK_tbl_rmsvc_opt_rmsvc_opt_no primary key(rmsvc_opt_no) 
);

create table tbl_bsns_opt
(bsns_opt_no   nvarchar2(2)  not null
,bsns_opt_desc nvarchar2(30) not null-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
,constraint PK_tbl_bsns_opt_bsns_opt_no primary key(bsns_opt_no)
);

create table tbl_fasvc_opt
(fasvc_opt_no   nvarchar2(2)  not null
,fasvc_opt_desc nvarchar2(30) not null-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
,constraint PK_tbl_fasvc_opt_fasvc_opt_no primary key(fasvc_opt_no) 
);

create table tbl_inet
(inet_seq       number(10)    not null
,fk_lodge_id    nvarchar2(10) not null
,fk_inet_opt_no nvarchar2(2)  not null
,constraint PK_tbl_inet_inet_seq       primary key(inet_seq)
,constraint FK_tbl_inet_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_inet_fk_inet_opt_no  foreign key(fk_inet_opt_no) REFERENCES tbl_inet_opt(inet_opt_no)
);

create table tbl_park
(park_seq       number(10)     not null
,fk_lodge_id     nvarchar2(15) not null
,fk_park_opt_no nvarchar2(2)   not null
,constraint PK_tbl_park_park_seq        primary key(park_seq)
,constraint FK_tbl_park_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_park_fk_park_opt_no  foreign key(fk_park_opt_no) REFERENCES tbl_park_opt(park_opt_no)
);

create table tbl_din
(din_seq        number(10)    not null
,fk_lodge_id    nvarchar2(10) not null
,fk_din_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_din_din_seq         primary key(din_seq)
,constraint FK_tbl_din_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_din_fk_din_opt_no   foreign key(fk_din_opt_no) REFERENCES tbl_din_opt(din_opt_no)
);

create table tbl_pool
(pool_seq        number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_pool_opt_no  nvarchar2(2)  not null
,pool_use_time   nvarchar2(30)
,constraint PK_tbl_pool_pool_seq        primary key(pool_seq)
,constraint FK_tbl_pool_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_pool_fk_pool_opt_no  foreign key(fk_pool_opt_no) REFERENCES tbl_pool_opt(pool_opt_no)
);

create table tbl_fac
(fac_seq       number(10)    not null
,fk_lodge_id   nvarchar2(10) not null
,fk_fac_opt_no nvarchar2(2)  not null
,constraint PK_tbl_fac_fac_seq         primary key(fac_seq)
,constraint FK_tbl_fac_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_fac_fk_fac_opt_no   foreign key(fk_fac_opt_no) REFERENCES tbl_fac_opt(fac_opt_no)
);

create table tbl_cs
(cs_seq        number(10)    not null
,fk_lodge_id   nvarchar2(10) not null
,fk_cs_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_cs_cs_seq         primary key(cs_seq)
,constraint FK_tbl_cs_fk_lodge_id    foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_cs_fk_cs_opt_no   foreign key(fk_cs_opt_no) REFERENCES tbl_cs_opt(cs_opt_no)
);

create table tbl_rmsvc
(rmsvc_seq       number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_rmsvc_opt_no nvarchar2(2)  not null
,constraint PK_tbl_rmsvc_rmsvc_seq        primary key(rmsvc_seq)
,constraint FK_tbl_rmsvc_fk_lodge_id      foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_rmsvc_fk_rmsvc_opt_no  foreign key(fk_rmsvc_opt_no) REFERENCES tbl_rmsvc_opt(rmsvc_opt_no)
);

create table tbl_bsns
(bsns_seq        number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_bsns_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_bsns_bsns_seq        primary key(bsns_seq)
,constraint FK_tbl_bsns_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_bsns_fk_bsns_opt_no  foreign key(fk_bsns_opt_no) REFERENCES tbl_bsns_opt(bsns_opt_no)
);

create table tbl_fasvc
(fascvc_seq      number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_fasvc_opt_no nvarchar2(2)  not null
,constraint PK_tbl_fasvc_fascvc_seq      primary key(fascvc_seq)
,constraint FK_tbl_fasvc_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_fasvc_fk_fasvc_opt_no foreign key(fk_fasvc_opt_no) REFERENCES tbl_fasvc_opt(fasvc_opt_no)
);

create sequence seq_tbl_inet
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_park
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_din
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_pool
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_fac
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_cs
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_rmsvc
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_bsns
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_fasvc
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


create table tbl_checkin
(S_CHECKIN_TYPE           Nvarchar2(2)   not null  -- 셀프체크인방법 / 0,1,2,3,4,5
,S_CHECKIN_CONTENT   Nvarchar2(20)  not null  -- 출입방법
                                                    -- 0: 셀프체크인불가
                                                    -- 1: 엑세스코드
                                                    -- 2: 키 수령 안내
                                                    -- 3: 록박스 이용 안내
                                                    -- 4: 스마트 록 코드
                                                    -- 5: 익스프레스 체크인
,S_CHECKIN_INFO      Nvarchar2(30)  not null  -- 방법설명
                                                    -- 0: 셀프체크인불가
                                                    -- 1: 엑세스코드         -- 비밀번호 패드 도어록
                                                    -- 2: 키 수령 안내       -- 키를 숨긴 장소 등
                                                    -- 3: 록박스 이용 안내    -- 키가 있는 잠금 보관함
                                                    -- 4: 스마트 록 코드     -- WiFi 스마트 도어록
                                                    -- 5: 익스프레스 체크인   -- 고객이 키오스크를 사용하여 체크인 가능
,constraint PK_tbl_checkin_self_checkin primary key(self_checkin)
)

/*

<<< 숙박시설(tbl_lodge) 입력 후 옵션테이블 입력 예시 >>>
맨윗줄 -> <제목> 테이블명
2번째줄 -> 옵션번호 : 설명
3번째줄 -> insert 문 예시

<인터넷> tbl_inet
0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'GWGN0001','0');

<주차장> tbl_park
0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'GWGN0001','0');

<다이닝> tbl_din
0 : 레스토랑 / 1 : 카페 / 2 : 바
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'GWGN0001','0');

<수영장> tbl_pool
0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'GWGN0001','0');

<장애인편의시설> tbl_fac
0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','0');

<고객서비스> tbl_ cs
0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '0');

<객실서비스> tbl_rmsvc
0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '2');

<비즈니스> tbl_bsns
0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'GWGN0001', '1');

<가족여행> tbl_fasvc
0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'GWGN0001', '1');


<<< 객실테이블(tbl_room) INSERT 문 예시 >>>
객실테이블(tbl_room) insert 문 // 유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''

insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('객실고유번호', 'fk_시설id', '객실이름', '침실개수', '흡연유무'
       , '객실크기(제곱미터)-숫자만', '객실크기(평)-소수점1자리까지', '침대 추가 가능여부'
       , '싱글침대 개수-없으면 공백(null)', '슈퍼싱글침대 개수', '더블침대 개수', '퀸사이즈침대 개수', '킹사이즈침대 개수'
       , '휠체어이용가능 유무', '전용욕실갯수-없으면0', '공용욕실유무', '주방(조리시설)유무', 'fk_전망옵션'
       , '객실 내 다과 유무', '객실 내 엔터테인먼트 유무', '온도조절기 유무', '투숙가능인원', '숙박요금', '조식포함 유무');




<<< 객실테이블(tbl_room) 입력 후 옵션테이블 입력 예시 >>>

<욕실> tbl_bath
0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-2', '0');

<주방> tbl_kitchen
0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
insert into tbl_kitchen(kt_seq, fk_rm_seq, fk_kt_opt_no) values(seq_tbl_kitchen.nextval, rm-2, '0');

<객실내다과> tbl_snack
0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-2', '0');

<객실내엔터> tbl_ent
0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-2', '0');

<온도조절기> tbl_tmp
0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-2', '0');



-- <메인이미지>
-- 숙박시설사진 테이블    저장위치 src="<%= ctxPath%>/resources/image/${requestScope.img}"
create table tbl_lg_img
(lg_img_seq         number(9)      not null  -- 숙소이미지seq           / seq
,fk_lodge_id        Nvarchar2(10)  not null  -- 숙박시설ID              / PARA0001, GWGN0001, JESH0001
,lg_img_save_name   Nvarchar2(50)  not null  -- 저장된 이미지파일명  / 나노초.png, JESH0001_6_view.png (숙박시설 이미지 등록시에는 view.png로 등록)
,lg_img_name        Nvarchar2(50)  not null  -- WAS에 저장된 이미지파일명 /  한글 이름
,fk_img_cano        Nvarchar2(1)             -- 숙소 카테고리 0,1,2,3,4,5,6
                                                 -- 0:시설외부
                                                 -- 1:공용구역
                                                 -- 2:수영장
                                                 -- 3:다이닝
                                                 -- 4:편의시설/서비스
                                                 -- 5:전망
                                                 -- 6:메인이미지
,constraint PK_tbl_lg_img_lg_img_seq primary key(lg_img_seq)
,constraint FK_tbl_lg_img_fk_lodge_id foreign key(fk_lodge_id) references tbl_lodge(lodge_id) on delete cascade
,constraint FK_tbl_lg_img_cate_fk_img_cano foreign key(fk_img_cano) references tbl_lg_img_cate(img_cate_no)
)
-- Table TBL_LG_IMG이(가) 생성되었습니다.

-- 16자리 (년월일 시분초)  || 15자리
2023061212400259 243254235235234
2023112409291535 243254235235234

create sequence seq_tbl_lg_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', 'JESH0001_6_01.png', '6');




-------- ***** 객실 사진 테이블 생성 ***** --------
create table tbl_rm_img
(rm_img_seq NVARCHAR2(15) -- 객실 이미지 seq
,fk_rm_seq NVARCHAR2(15) not null-- 객실고유번호
,rm_img_main NVARCHAR2(1) not null -- 메인이미지 여부(0: 메인이미지 아님 / 1: 메인이미지)
,rm_img_name Nvarchar2(20) not null -- 객실이미지명
,rm_img_save_name Nvarchar2(35) not null -- 실제저장이미지파일명
,constraint PK_tbl_rm_img_rm_img_seq primary key(rm_img_seq)
,constraint FK_tbl_rm_img_fk_room_seq foreign key (fk_rm_seq) references tbl_room(rm_seq)
);

create sequence seq_tbl_rm_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

commit;



create table tbl_rating
(rv_rating number(2) -- 평점
,rv_rating_desc nvarchar2(20) -- 평점 설명 (10: 훌륭해요 / 8: 좋아요 / 6: 괜찮아요 / 4: 별로에요 / 2: 너무 별로에요
,constraint PK_tbl_rating_rv_rating primary key(rv_rating)
);
insert into tbl_rating(rv_rating, rv_rating_desc) values (10, '훌륭해요');
insert into tbl_rating(rv_rating, rv_rating_desc) values (8, '좋아요');
insert into tbl_rating(rv_rating, rv_rating_desc) values (6, '괜찮아요');
insert into tbl_rating(rv_rating, rv_rating_desc) values (4, '별로에요');
insert into tbl_rating(rv_rating, rv_rating_desc) values (2, '너무 별로에요');

create table tbl_review
(rv_seq  NVARCHAR2(10) -- 글 번호
,fk_lodge_id NVARCHAR2(10) not null -- 숙박시설 id
,fk_rs_seq  VARCHAR2(30) -- 예약번호
,rv_subject NVARCHAR2(200) -- 글제목
,rv_content NVARCHAR2(2000) -- 후기내용
,rv_regDate date default sysdate not null --작성일자
,rv_status NVARCHAR2(1) -- 글 삭제여부 (0: 삭제 / 1:삭제X)
,fk_rv_rating number(2) -- 평점
,constraint PK_tbl_review_rv_seq primary key(rv_seq)
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





create table tbl_reservation
(rs_seq             varchar2(30)  not null -- 예약번호
,fk_userid          varchar2(30)  not null -- 예약자 회원아이디
,fK_h_userid        varchar2(30)  not null -- 사업자 아이디  
,rs_date            date default sysdate not null -- 예약일자
,rs_checkinDate     date          not null  -- 체크인날짜
,rs_checkoutDate    date          not null  -- 체크아웃날짜
,rs_price           varchar2(30)  not null  -- 결제금액
,rs_payType         number(1)     not null  -- 결제방식(0:현장 결제/ 1:예약 할 때 결제)
,rs_name            varchar2(30)  not null  -- 예약자 성명
,rs_mobile          varchar2(30)  not null  -- 예약자 연락처
,rs_email           varchar2(30)  not null  -- 예약자이메일
,rs_guest_cnt       nvarchar2(2)  not null  -- 투숙 인원
,fk_rm_seq          NVARCHAR2(15)           -- 객실 고유번호
,rs_cancel          Nvarchar2(1) default '0' not null  -- 0 : 일반 예약  1 : 취소된 예약
,constraint PK_tbl_reservation_rs_seq primary key(rs_seq)
,constraint FK_tbl_user_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_host_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)
,constraint FK_tbl_reservation_fk_rm_seq foreign key(fk_rm_seq) references tbl_room(rm_seq)
);






create table tbl_user
(userid             varchar2(20) not null
,name               varchar2(30)
,email              varchar2(20) not null
,pw                 varchar2(200) not null
,birth              varchar2(30)
,mobile             varchar2(30)
,gender             varchar2(1)
,postcode           varchar2(5)
,address            varchar2(20)
,detailAddress      varchar2(20)
,extraAddress       varchar2(20)
,role               number(1)   not null
,registerDate       date default sysdate not null
,lastpwdchangedate  date default sysdate
,idle               number(1)   not null
,user_lvl           number(2)   not null
,point              number(10)  not null
,emer_name          varchar2(20)
,emer_phone         varchar2(30)
,pt_num             varchar2(20)
,pt_nation          varchar2(20)
,pt_endDate         date
,constraint PK_tbl_user_userid primary key(userid)
);

select *
from tbl_loginhistory

create table tbl_loginhistory
(HISTORYNO NUMBER       NOT NULL 
,FK_USERID VARCHAR2(40) NOT NULL 
,LOGINDATE DATE DEFAULT SYSDATE NOT NULL
,CLIENTIP  VARCHAR2(20) NOT NULL 
,CONSTRAINT FK_tbl_loginhistory_fk_userid foreign key (fk_userid) references tbl_user(userid)
);

create table tbl_rs_buyer
(rs_seq             number(5)     not null
,fk_userid          varchar2(20)  not null
,fK_lodge_id        NVARCHAR2(10) not null
,rs_date            date default sysdate not null
,rs_checkinDate     date          not null
,rs_checkoutDate    date          not null
,rs_price           number(10)    not null
,rs_payType         number(1)     not null
,rs_point           number(10)
,rs_name            varchar2(30)  not null
,rs_mobile          varchar2(30)
,rs_email           varchar2(20)  not null
,constraint PK_tbl_rs_buyer_rs_seq primary key(rs_seq)
,constraint FK_tbl_user_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_lodge_fK_lodge_id foreign key(fK_lodge_id) references tbl_lodge(lodge_id)
);

create table tbl_rs_seller
(fk_h_userid     varchar2(20) not null
,fk_rs_seq       number(5)    not null
,rs_remaining    number(3)    not null
,rs_roomCnt      number(3)    not null
,constraint FK_tbl_host_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)
,constraint FK_tbl_rs_buyer_rs_seq foreign key(fk_rs_seq) references tbl_rs_buyer(rs_seq)
);
*/




select *
from tbl_lodge

update tbl_host set h_status = 0
where h_name='최종환'

commit;





select *
from tbl_lodge

select count(*)
from tbl_lodge
where 1=1
and lg_hotel_star = '5'
and lower(fk_h_userid) like '%' || lower('p') || '%'

select lg_img_name,fk_lodge_id, lg_img_name as rno 
from tbl_lg_img
order by lg_img_name




select count(*) from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id where lodge_id=''



select lodge_id, fk_h_userid, lg_name, lg_en_name, lg_address, lg_extraaddress
      ,lg_postcode, lg_hotel_star, fk_lodge_type, lg_qty
      ,rm_type, rm_size_meter, rm_size_pyug, rm_price, rm_guest_cnt
      ,lg_img_name, rno, lg_status
from
(
select L.lodge_id, L.fk_h_userid, L.lg_name, L.lg_en_name, L.lg_address, L.lg_extraaddress
      ,L.lg_postcode, L.lg_hotel_star, L.fk_lodge_type, L.lg_qty, L.lg_status
      ,R.rm_type, R.rm_size_meter, R.rm_size_pyug, R.rm_price, R.rm_guest_cnt
      ,I.lg_img_name, row_number() over (order by I.lg_img_name asc) as rno,
     (select count(*) from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id where 1=1) as length
from tbl_lodge L
left join tbl_room R
on L.lodge_id = R.fk_lodge_id
left join tbl_lg_img I
on L.lodge_id = I.fk_lodge_id
where 1=1 and L.lodge_id = 'PARA0001'
order by R.rm_type asc, I.lg_img_name asc
) V
where 1=1 and rno between 1 and length


insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'PARA0001', '2023121417164612451682495524536.png','01_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'PARA0001', '2023121417174612451681213456121.png','02_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'PARA0001', '2023121417183412789456123158468.png','03_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'PARA0001', '2023121417190112548679123154657.png','04_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'PARA0001', '2023121417205512451454542369012.png','05_메인.png', '6');

commit;

select * 
from tbl_lg_img



select lodge_id, total_address, lg_hotel_star, fk_lodge_type, fk_h_userid, lg_name
from
(
select lodge_id, lg_address || ' ' || lg_extraaddress as total_address
      ,lg_hotel_star, fk_lodge_type, fk_h_userid, lg_name
from tbl_lodge
)
where 1=1
and lower(total_address) like '%'||lower('서울')||'%'




select *
from tbl_lodge


select lodge_id, total_address, lg_hotel_star, fk_lodge_type, fk_h_userid, lg_name
from
(
    select lodge_id, lg_address as total_address
          ,lg_hotel_star, fk_lodge_type, fk_h_userid, lg_name
          ,row_number() over (order by lg_area asc) as rno
    from tbl_lodge
)
where 1=1
orderby


select total_address
from
		(
		    select lodge_id, lg_address as total_address
		          ,lg_hotel_star, fk_lodge_type, fk_h_userid, lg_name
		          ,row_number() over (order by lg_area asc) as rno
		    from tbl_lodge
		)
		where 1=1
        	order by lg_name asc


select *
from tbl_user

-- 년 별 성별 등록 회원수 (월, 일도 넣을지 고민)
select decode(gender,'F','여','M','남',null) as gender,
       sum(decode(extract(year from registerdate),2016,1,0) ) as "Y2016",  
       sum(decode(extract(year from registerdate),2017,1,0) ) as "Y2017",
       sum(decode(extract(year from registerdate),2018,1,0) ) as "Y2018",
       sum(decode(extract(year from registerdate),2019,1,0) ) as "Y2019",
       sum(decode(extract(year from registerdate),2020,1,0) ) as "Y2020",
       sum(decode(extract(year from registerdate),2021,1,0) ) as "Y2021",
       sum(decode(extract(year from registerdate),2022,1,0) ) as "Y2022",
       sum(decode(extract(year from registerdate),2023,1,0) ) as "Y2023"
from tbl_user
where gender IN('F','M')
group by gender
order by 1


-- 지역별 숙박시설 점유율
select lg_area, count(*) as cnt
      ,round(count(*)/(select count(*) from tbl_lodge)*100,2) as percentage
from tbl_lodge
group by lg_area

-- 숙박시설 객실수수와 퍼센트
select lg_name, sum(lg_qty) as cnt ,round(sum(lg_qty)/(select sum(lg_qty) from tbl_lodge where lg_area = '제주특별자치도')*100,2) as percentage
from
(
select lg_area, lg_name, lg_qty
from tbl_lodge
order by lg_area
)
where lg_area = '제주특별자치도'
group by lg_name
order by lg_name;



-- 페이지 빈도수

-- 분기별 예약 건수
select quator,count(*) as cnt
from
(
select case when extract(month from rs_date) > 0  and extract(month from rs_date) < 4  then '1분기'
            when extract(month from rs_date) > 3  and extract(month from rs_date) < 7  then '2분기'
            when extract(month from rs_date) > 6  and extract(month from rs_date) < 10 then '3분기'
            else '4분기' end as quator
from tbl_reservation R
join tbl_lodge L
on R.fk_h_userid = L.fk_h_userid
)
group by quator



-- 월별 예약 건수
select months,count(*)
from
(
select case when extract(month from rs_date) = 1  then '1'
            when extract(month from rs_date) = 2  then '2'
            when extract(month from rs_date) = 3  then '3'
            when extract(month from rs_date) = 4  then '4'
            when extract(month from rs_date) = 5  then '5'
            when extract(month from rs_date) = 6  then '6'
            when extract(month from rs_date) = 7  then '7'
            when extract(month from rs_date) = 8  then '8'
            when extract(month from rs_date) = 9  then '9'
            when extract(month from rs_date) = 10  then '10'
            when extract(month from rs_date) = 11  then '11'
            else '12' end as months ,(select 1+0 from dual) as cnt     
from tbl_reservation R
join tbl_lodge L
on R.fk_h_userid = L.fk_h_userid
)
group by months
ORDER BY TO_NUMBER(months) ASC



--제주신라호텔	2       1
--제주신라호텔	6       1
--제주신라호텔	12      1
--롯데호텔 서울	12      2
--제주신라호텔	7       1
select lg_name ,months,cnt
from
(
select case when extract(month from rs_date) = 1  then 1
            when extract(month from rs_date) = 2  then 2
            when extract(month from rs_date) = 3  then 3
            when extract(month from rs_date) = 4  then 4
            when extract(month from rs_date) = 5  then 5
            when extract(month from rs_date) = 6  then 6
            when extract(month from rs_date) = 7  then 7
            when extract(month from rs_date) = 8  then 8
            when extract(month from rs_date) = 9  then 9
            when extract(month from rs_date) = 10  then 10
            when extract(month from rs_date) = 11  then 11
            else 12 end as months,(select 1+0 from dual) as cnt,
            lg_name
from tbl_reservation R
join tbl_lodge L
on R.fk_h_userid = L.fk_h_userid
where lg_name = '롯데호텔 서울'
)
group by months


select months,count(*)
from
(
select case when extract(month from rs_date) = 1  then '1'
            when extract(month from rs_date) = 2  then '2'
            when extract(month from rs_date) = 3  then '3'
            when extract(month from rs_date) = 4  then '4'
            when extract(month from rs_date) = 5  then '5'
            when extract(month from rs_date) = 6  then '6'
            when extract(month from rs_date) = 7  then '7'
            when extract(month from rs_date) = 8  then '8'
            when extract(month from rs_date) = 9  then '9'
            when extract(month from rs_date) = 10  then '10'
            when extract(month from rs_date) = 11  then '11'
            else '12' end as months ,(select 1+0 from dual) as cnt     
from tbl_reservation R
join tbl_lodge L
on R.fk_h_userid = L.fk_h_userid
)
group by months
ORDER BY TO_NUMBER(months) ASC


select *
from tbl_reservation R
join tbl_lodge L
on R.fk_h_userid = L.fk_h_userid

select *
from tbl_lodge
select *
from tbl_reservation -- (0:현장 결제/ 1:예약 할 때 결제)


 -- 일수 차이
select rs_checkindate, rs_checkoutdate, to_date('24/01/05','yy/mm/dd')-trunc(rs_checkindate) as gap_days
from tbl_reservation

select name, email, user_lvl, point, mobile
from tbl_user
where userid = 'arcnet5@naver.com'

--// 몇박인지, 취소정책, 객실요금, 객실정보(인원,침대,개수,흡연유무), 객실이름

select rm_type, rm_price, rm_guest_cnt, rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed, rm_smoke_yn
from tbl_room
where rm_seq = 'rm-33'

select fk_cancel_opt, lg_park_yn, lg_internet_yn, lg_name, lg_checkin_start_time, fk_h_userid
from tbl_lodge
where fk_h_userid = 'p-city@paradian.com'

select *
from tbl_inet

select *
from tbl_reservation

select to_date('2023-12-31','yyyy-mm-dd') as rs_checkindate , to_date('2024-01-02','yyyy-mm-dd') as rs_checkoutdate,
       to_date('2024-01-02','yyyy-mm-dd')-trunc(to_date('2023-12-31','yyyy-mm-dd')) as gap_days
from dual;





 --- *** 취소정책 날짜 계산 *** ---    
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') As currentTiem
      ,to_char(to_date('2023-01-31' ||' '|| checkin_time,'yyyy-mm-dd hh24:mi:ss') - 1 + 0 + 0 + 0,'yyyy-mm-dd hh24:mi:ss') As B_24
      ,to_char(to_date('2023-01-31' ||' '|| checkin_time,'yyyy-mm-dd hh24:mi:ss') - 2 + 0 + 0 + 0,'yyyy-mm-dd hh24:mi:ss') As B_48
      ,to_char(to_date('2023-01-31' ||' '|| checkin_time,'yyyy-mm-dd hh24:mi:ss') - 3 + 0 + 0 + 0,'yyyy-mm-dd hh24:mi:ss') As B_72
      ,to_char(to_date('2023-01-31' ||' '|| checkin_time,'yyyy-mm-dd hh24:mi:ss') + 0 - 1/24 + 0 + 0,'yyyy-mm-dd hh24:mi:ss') As B_1
      ,checkout_time
 from
 (
    select fk_h_userid
          ,case when substr(lg_checkin_start_time,7,8) = 'PM' then substr(lg_checkin_start_time,1,2) + 12 || ':00:00' else substr(lg_checkin_start_time,1,2) + 0 ||':00:00' end as checkin_time
          ,case when substr(lg_checkout_time,7,8) = 'PM' then substr(lg_checkout_time,1,2) + 12 || ':00' else substr(lg_checkout_time,1,2) + 0 ||':00' end as checkout_time
    from tbl_lodge
 )    
    where 1=1
    and fk_h_userid = 'p-city@paradian.com'


 -- 시퀀스 조회
SELECT *
FROM all_sequences

select *
from tbl_reservation

select *
from tbl_review

select

Desc tbl_review


insert into tbl_review(rv_seq, FK_LODGE_ID, fk_rs_seq, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS, FK_RV_RATING, RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_USERID)
values(SEQ_TBL_REVIEW.nextval, 'PARA0001', 28, '12/31-01/02일 파라다이스시티 디럭스 더블룸 후기', '숙소가 정말 깨끗했쥐! 서비스도 훌륭했쥐! 다음에 다시올거쥐!',SYSDATE, 1, 10, 22, 0, 0,'arcnet5@naver.com')

insert into tbl_review(rv_seq, FK_LODGE_ID, fk_rs_seq, RV_SUBJECT, RV_CONTENT, RV_REGDATE, RV_STATUS, FK_RV_RATING, RV_GROUPNO, RV_ORG_SEQ, RV_DEPTHNO, FK_USERID)
values(SEQ_TBL_REVIEW.nextval, 'PARA0001', 25, '12/31-01/02일 파라다이스시티 디럭스 더블룸 후기', '숙소가 정말 깨끗해용! 서비스도 훌륭했어용! 다음에 다시올거에용!',SYSDATE, 1, 8, 11,0, 0,'arcnet5@naver.com')


select round(sum(fk_rv_rating)/count(*),1) as rating
       ,count(*) as rv_cnt
from tbl_review
where fk_lodge_id = 'PARA0001'


select lodge_id
from tbl_lodge
where fk_h_userid = 'p-city@paradian.com'



update tbl_user set point = point - 5 + 100
where userid = 'arcnet5@naver.com'

select point
from tbl_user
where userid = 'arcnet5@naver.com'



/*
create table tbl_point(
 pt_seq    VARCHAR2(30) -- 포인트 seq
,fk_userid VARCHAR2(20) not null -- userid
,fk_rs_seq VARCHAR2(30) not null -- 예약번호
,pt_change_date date default sysdate not null -- 포인트 적립 혹은 사용일(시간까지)
,pt_amount NUMBER(10) not null -- 포인트 적립 혹은 사용액 / 사용시 - 적립시 +
,constraint PK_pt_seq_tbl_point primary key(pt_seq)
,constraint FK_fk_userid_tbl_point foreign key (fk_userid) references tbl_user(userid)
,constraint FK_fk_rs_seq_tbl_point foreign key(fk_rs_seq) REFERENCES tbl_reservation(rs_seq)
);
*/
