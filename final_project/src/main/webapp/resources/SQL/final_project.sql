show user;
-- USER이(가) "FINAL_ORAUSER3"입니다.

select * from tab;

select *
from tbl_user;

drop table tbl_rs_seller purge;
drop table tbl_rs_buyer purge;
drop table tbl_user purge;
drop table tbl_loginhistory purge;

select *
from user_recyclebin;


create table tbl_user
(userid     varchar2(20) not null
,name       varchar2(30)
,email      varchar2(20) not null
,pw         varchar2(200) not null
,birth      varchar2(30)
,mobile     varchar2(30)
,gender     varchar2(1) -- 여자: F / 남자: M / 특정안함: N
,postcode   varchar2(5)
,address    varchar2(200)
,detailAddress      varchar2(200)
,extraAddress       varchar2(200)
,role               number(1)   not null -- 0: 관리자, 1: 일반회원(구매자)
,registerDate       date default sysdate not null
,lastpwdchangedate  date default sysdate
,idle               number(1)   not null -- 0: 휴면, 1: 활동중, -1: 탈퇴
,user_lvl           number(2)   not null -- 회원등급 ( 0: blue, 1: silver, 2: gold)
,point              number(10)  not null
,emer_name          varchar2(20)
,emer_phone         varchar2(30)
,pt_num             varchar2(20)
,pt_nation          varchar2(20)
,pt_endDate         date
,constraint PK_tbl_user_userid primary key(userid)
);

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

insert into tbl_user(userid, name, email, pw, role, registerDate, idle, user_lvl, point)
values('test1@naver.com', 'test1', 'test1@naver.com', '18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '1', default, 1, 0, 0);

update tbl_user set lastpwdchangedate = sysdate;
commit;

select *
from tbl_user;

delete tbl_user
where userid='test2@naver.com';

commit;


select userid, name, email, pw, birth, mobile, gender, postcode, address, detailAddress, extraAddress, role, registerDate
, idle, user_lvl, point, emer_name, emer_phone, pt_num, pt_nation, pt_endDate
FROM 
( 
select userid, name, email, pw, birth, mobile, gender, postcode, address, detailAddress, extraAddress, role, to_char(registerDate, 'yyyy-mm-dd') AS registerDate 
     , trunc(months_between(sysdate, lastpwdchangedate)) AS pwdchangegap 
     , idle, user_lvl, point, emer_name, emer_phone, pt_num, pt_nation, pt_endDate
from tbl_user 
where idle != -1 and userid = 'test1@naver.com'
) M 
CROSS JOIN 
( 
select trunc(months_between(sysdate, max(logindate))) AS lastlogingap 
from tbl_loginhistory 
where fk_userid = 'test1@naver.com'
) H

update tbl_user set user_lvl = '1'
where userid = 'test1@naver.com';

select *
from tbl_user;

select *
from tbl_host

desc tbl_host;
desc tbl_user;

create table tbl_accDelete
( accDelete_seq number(10) not null
, fk_userid varchar2(20)  not null 
, tooManyEmail number(1) -- 이메일 또는 알림이 너무 많음
, haveOtherAccount number(1) -- 다른 이메일로 계정이 있음
, endTrip number(1) -- 여행이 끝났으므로 이 계정이 필요 없음 
, badRsvExp number(1) -- 예약 경험이 좋지 않았음
, etc number(1) -- 기타
, constraint PK_tbl_accDelete_accDelete_seq primary key(accDelete_seq)
, constraint FK_tbl_accDelete_fk_userid foreign key(fk_userid) references tbl_user(userid)
)
-- Table TBL_ACCDELETE이(가) 생성되었습니다.

create sequence seq_tbl_accDelete
start with 1  
increment by 1 
nomaxvalue
nominvalue
nocycle           
nocache;
-- Sequence SEQ_TBL_ACCDELETE이(가) 생성되었습니다.

commit;
 
select * from tbl_user;
select * from tbl_accDelete;
select * from tbl_host;


update tbl_user set idle=1
where idle=-1

insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('skybay_hotel@gmail.com','qwer1234!', '심태형', '스카이베이 호텔 경포', 'skybay_hotel@gmail.com', '033-923-2000', '25460', '강원특별자치도 강릉시 해안로 476','','(강문동)',default,default,default,'(주)빌더스개발에이엠씨','604-88-00718');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('stjohns_hotel@gmail.com','qwer1234!', '김헌성', '세인트존스 호텔', 'stjohns_hotel@gmail.com', '033-660-9000', '25467', '강원특별자치도 강릉시 창해로 307','','(강문동)',default,default,default,'주식회사 엘케이매니지먼트','566-81-00381');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('hoteltops10@naver.com','qwer1234!', '김종민', '호텔 탑스텐', 'hoteltops10@naver.com', '033-530-4711', '25633', '강원특별자치도 강릉시 옥계면 헌화로 455-34','','(옥계면 금진리)',default,default,default,'호텔탑스텐','568-85-00750');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('chonpines_ocsuite@gmail.com','qwer1234!', '정기목', '강릉 컨피네스 오션 스위트 호텔', 'chonpines_ocsuite@gmail.com', '033-920-0296', '25435', '강원특별자치도 강릉시 사천면 진리항구2길 5','','(사천면 사천진리)',default,default,default,'컨피네스 오션 스위트','759-85-01904');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('hongc_hotel@google.com','qwer1234!', '홍종표', '더 홍씨호텔 강릉', 'hongc_hotel@google.com', '033-641-8011', '25512', '강원특별자치도 강릉시 교동광장로100번길 8','','(교동)',default,default,default,'주식회사 동주','226-81-51342');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('hotelgangneung@gmail.com','qwer1234!', '김운성', '강릉관광호텔', 'hotelgangneung@gmail.com', '033-648-7750', '25539', '강원특별자치도 강릉시 금성로 62','','(성내동)',default,default,default,'강릉관광호텔','672-22-00199');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('gyeongpoen@gmail.com','qwer1234!', '원경식', '경포엔 펜션', 'gyeongpoen@gmail.com', '010-7390-3811', '25461', '강원특별자치도 강릉시 저동골길 113-6','','(저동)',default,default,default,'경포엔','717-20-00649');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('Sunrise_7984@gmail.com','qwer1234!', '이명옥', '강릉SS펜션', 'Sunrise_7984@gmail.com', '010-4738-7988', '25435', '강원특별자치도 강릉시 사천면 해안로 1073','','(사천면 사천진리)',default,default,default,'강릉펜션-SS펜션','841-57-00216');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('sl_hotel1@google.com','qwer1234!', '최태식', 'SL 호텔 강릉', 'sl_hotel1@google.com', '033-920-1816', '25460', '강원특별자치도 강릉시 주문진읍 주문로 59','','(주문진읍 교항리)',default,default,default,'에스엘강릉(주)','718-86-01856');
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('gangneungCity_hotel@gmail.com','qwer1234!', '최유헌', '강릉씨티호텔', 'gangneungCity_hotel@gmail.com', '033-655-8700 ', '25515', '강원특별자치도 강릉시 교동광장로 112 ','','(교동)',default,default,default,'(주)강릉씨티호텔','792-86-01121');

update tbl_host set h_pw='18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5';

desc tbl_lodge;

select *
from tbl_lodge;

select *
from user_constraints

drop table tbl_lodge;
alter table tbl_lodge
add constraint FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid);

commit;
rollback;

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, LG_EN_NAME, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area, lg_area_2,
                      fk_lodge_type, LG_HOTEL_STAR, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('GWGN0001', 'skybay_hotel@gmail.com', '스카이베이 호텔 경포', 'Skybay Hotel Gyeongpo', '25460', '강원특별자치도 강릉시 해안로 476',
       '','(강문동)', '37.8040142', '128.9080643', '강원특별자치도', '강릉시',
       '0', '4' , '100', '1', '1', '24시간',
       '0', '15:00 ~ 24:00','11:00', '20','1',
       '1', '1', '1', '07:00 ~ 22:00','2',
       '1', '0', ' ','3' ,'0',
       '1', '0','1', '1');
       
alter table tbl_lodge modify lg_qty NVARCHAR2(5);
commit;


select * from user_tables;


-------- ***** >>>> === 객실(room) 관련 테이블 & 시퀀스 생성 시작!! === <<<< ***** --------

create table tbl_view
(view_no nvarchar2(2)    not null -- 전망_옵션
,view_desc nvarchar2(30) not null -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망
,constraint PK_tbl_view_view_no primary key(view_no)
);

insert into tbl_view (view_no, view_desc) values('0','전망없음');
insert into tbl_view (view_no, view_desc) values('1','해변 전망');
insert into tbl_view (view_no, view_desc) values('2','산 전망');
insert into tbl_view (view_no, view_desc) values('3','강 전망');
insert into tbl_view (view_no, view_desc) values('4','시내 전망');
insert into tbl_view (view_no, view_desc) values('5','공원 전망');
commit;
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
,bath_opt_desc nvarchar2(30) not null -- 0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
,constraint PK_tbl_bath_opt_bath_opt_no primary key(bath_opt_no) 
);
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('0','타월 제공');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('1','목욕가운');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('2','바닥 난방/온돌');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('3','욕실 용품');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('4','헤어드라이어');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('5','비데');
insert into tbl_bath_opt (bath_opt_no, bath_opt_desc) values('6','욕조');
commit;

create table tbl_kt_opt
(kt_opt_no   nvarchar2(2)  not null
,kt_opt_desc nvarchar2(30) not null-- 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
,constraint PK_tbl_kt_opt_kt_opt_no primary key(kt_opt_no) 
);
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('0','조리도구, 접시, 주방 기구');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('1','식기세척기');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('2','냉장고');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('3','오븐');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('4','전자레인지');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('5','밥솥');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('6','토스터');
insert into tbl_kt_opt (kt_opt_no, kt_opt_desc) values('7','양념/향신료');
commit;

create table tbl_snk_opt
(snk_opt_no   nvarchar2(2)   not null
,snk_opt_desc nvarchar2(30)  not null-- 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바
,constraint PK_tbl_snk_opt_snk_opt_no primary key(snk_opt_no) 
);
insert into tbl_snk_opt (snk_opt_no, snk_opt_desc) values('0','무료 생수');
insert into tbl_snk_opt (snk_opt_no, snk_opt_desc) values('1','커피/티/에스프레소 메이커');
insert into tbl_snk_opt (snk_opt_no, snk_opt_desc) values('2','미니바');
insert into tbl_snk_opt (snk_opt_no, snk_opt_desc) values('3','바');
commit;

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
-------- ***** >>>> === 객실(room) 관련 테이블 & 시퀀스 생성 끝!! === <<<< ***** --------

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
,din_opt_desc nvarchar2(30)  not null -- 0 : 레스토랑 / 1 : 카페 / 2 : 바
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
,bsns_opt_desc nvarchar2(30) not null -- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
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
,fk_inet_opt_no nvarchar2(2)  not null -- 0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
,constraint PK_tbl_inet_inet_seq       primary key(inet_seq)
,constraint FK_tbl_inet_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_inet_fk_inet_opt_no  foreign key(fk_inet_opt_no) REFERENCES tbl_inet_opt(inet_opt_no)
);
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'GWGN0001','0');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'GWGN0001','1');

create table tbl_park
(park_seq       number(10)     not null
,fk_lodge_id     nvarchar2(15) not null
,fk_park_opt_no nvarchar2(2)   not null -- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
,constraint PK_tbl_park_park_seq        primary key(park_seq)
,constraint FK_tbl_park_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_park_fk_park_opt_no  foreign key(fk_park_opt_no) REFERENCES tbl_park_opt(park_opt_no)
);
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'GWGN0001','0');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'GWGN0001','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'GWGN0001','3');

create table tbl_din
(din_seq        number(10)    not null
,fk_lodge_id    nvarchar2(10) not null
,fk_din_opt_no  nvarchar2(2)  not null -- 0 : 레스토랑 / 1 : 카페 / 2 : 바
,constraint PK_tbl_din_din_seq         primary key(din_seq)
,constraint FK_tbl_din_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_din_fk_din_opt_no   foreign key(fk_din_opt_no) REFERENCES tbl_din_opt(din_opt_no)
);
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'GWGN0001','0');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'GWGN0001','1');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'GWGN0001','2');

create table tbl_pool
(pool_seq        number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_pool_opt_no  nvarchar2(2)  not null -- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
,constraint PK_tbl_pool_pool_seq        primary key(pool_seq)
,constraint FK_tbl_pool_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_pool_fk_pool_opt_no  foreign key(fk_pool_opt_no) REFERENCES tbl_pool_opt(pool_opt_no)
);
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'GWGN0001','0');
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'GWGN0001','1');

create table tbl_fac
(fac_seq       number(10)    not null
,fk_lodge_id   nvarchar2(10) not null
,fk_fac_opt_no nvarchar2(2)  not null -- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
,constraint PK_tbl_fac_fac_seq         primary key(fac_seq)
,constraint FK_tbl_fac_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_fac_fk_fac_opt_no   foreign key(fk_fac_opt_no) REFERENCES tbl_fac_opt(fac_opt_no)
);
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','0');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','1');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','2');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'GWGN0001','3');

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

commit;
desc tbl_lodge;
desc tbl_reservation;
-------- ***** >>>> 숙소(lodge) 관련 테이블 & 시퀀스 생성 끝!! <<<< ***** --------

-------- ***** 리뷰테이블 & 시퀀스 생성 ***** --------
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

commit;

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

----------------------------------table 수정 ---------------------------------------
alter table tbl_lodge rename COLUMN FK_SELF_CHECKIN_YN to FK_S_CHECKIN_TYPE;

desc tbl_checkin;
alter table tbl_checkin rename COLUMN SELF_CHECKIN to S_CHECKIN_TYPE;
alter table tbl_checkin rename COLUMN SELF_CHECKIN_CONTENT to S_CHECKIN_CONTENT;
alter table tbl_checkin rename COLUMN SELF_CHECKIN_INFO to S_CHECKIN_INFO;

alter table tbl_lodge
rename constraint FK_TBL_LODGE_FK_SELF_CHECKIN to FK_TBL_LODGE_FK_S_CHECKIN_TYPE;

select *
from user_constraints
where table_name='tbl_lodge';

desc tbl_checkin;

desc tbl_lodge;
select * from user_tables;

alter table tbl_lodge modify LG_STATUS NVARCHAR2(2) default 0;
commit;
alter table tbl_lodge modify LG_QTY NVARCHAR2(5);
----------------------------------table 수정 끗---------------------------------------

-------------------------------------------------------------------------------------
-------------- tbl_lodge 테이블에 insert ---------------
insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('GWGN0001', 'skybay_hotel@gmail.com', '스카이베이 호텔 경포', 'Skybay Hotel Gyeongpo', '25460', '강원특별자치도 강릉시 해안로 476',
     '','(강문동)', '37.8040142', '128.9080643', '4', '강원특별자치도', '강릉시', '0', '538'
     ,'1', '1', '24시간', '0', '3:00 PM'
     , '자정', '11:00 AM', '19', '1', '1'
     , '1', '1', '1', '1','35000'
     , '1', '1', '1', '1' ,'1'
     , '1', '0','0', '1', '0'
     , '1', '1', default);

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('GWGN0002', 'stjohns_hotel@gmail.com', '세인트존스 호텔', 'St. Johns Hotel', '25467', '강원특별자치도 강릉시 창해로 307',
     '', '(강문동)', '37.7913073', '128.9210475', '4', '강원특별자치도', '강릉시', '0', '1091'
     ,'1', '1', '24시간', '0', '04:00 PM'
     , '다음날 03:00 AM', '11:00 AM', '19', '1', '1'
     , '1', '1', '1', '1','0'
     , '1', '1', '1', '1' ,'1'
     , '1', '0','0', '1', '0'
     , '1', '1', default);


commit;     




--------------------------------------------------------------------
----- lodge 에 딸린 옵션 insert---------------
--insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no) values(seq_tbl_inet.nextval, 'GWGN0002','1');
--
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0002','0');
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0002','1');
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0002','3');
--
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no) values(seq_tbl_din.nextval, 'GWGN0002','0');
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no) values(seq_tbl_din.nextval, 'GWGN0002','1');
--
--insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no) values(seq_tbl_pool.nextval, 'GWGN0002','1');
--
--insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no) values(seq_tbl_fac.nextval, 'GWGN0002','0');
--
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '0');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '2');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '3');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '4');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '5');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '6');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0002', '8');
--
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no) values(seq_tbl_rmsvc.nextval, 'GWGN0002', '2');
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no) values(seq_tbl_rmsvc.nextval, 'GWGN0002', '3');
--
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no) values(seq_tbl_bsns.nextval, 'GWGN0002', '0');
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no) values(seq_tbl_bsns.nextval, 'GWGN0002', '1');
--
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no) values(seq_tbl_fasvc.nextval, 'GWGN0002', '5');


select *
from tbl_fasvc_opt;

select *
from user_constraints
where TABLE_NAME='TBL_REVIEW';
select *
from TBL_REVIEW;
select *
from user_tables
where table_name ='tbl_review';

select *
from tbl_reservation;

desc tbl_reservation;

WITH V
AS
(
    SELECT *
    FROM TBL_LODGE L
    JOIN tbl_lodge_type LT ON  L.fk_lodge_type = LT.lodge_type
    JOIN tbl_rmsvc RSVC ON RSVC.FK_LODGE_ID = L.LODGE_ID
    JOIN TBL_RMSVC_OPT RSVCO ON RSVC.FK_RMSVC_OPT_NO = RSVCO.RMSVC_OPT_NO
    JOIN tbl_fasvc FSVC ON FSVC.FK_LODGE_ID = L.LODGE_ID
    JOIN TBL_FASVC_OPT FSVCO ON FSVC.FK_FASVC_OPT_NO = FSVCO.FASVC_OPT_NO
)
SELECT *
FROM V
WHERE LODGE_ID = 'PARA0001'
;

update tbl_lodge set lg_fa_travel_yn = 1
where lodge_id = 'GWGN0002';
commit;
-- 기본 숙박 시설 정보 --
WITH V
AS
(
    SELECT  *
    FROM TBL_LODGE L
    JOIN TBL_lodge_type LT ON L.fk_lodge_type = LT.LODGE_TYPE
    JOIN TBL_CANCEL CN ON CN.CANCEL_OPT = L.fk_cancel_opt
    JOIN TBL_CHECKIN CI ON ci.s_checkin_type = L.fk_s_checkin_type
    JOIN TBL_SPA_TYPE ST ON st.spa_type = L.fk_spa_type
)
,
R
as
(
    SELECT FK_lodge_id, avg(FK_RV_RATING) as rv_rating_avg, count(*) as rv_cnt
    FROM
    (
        select FK_lodge_id, FK_RV_RATING, rv_status
        from tbl_review R
        join tbl_lodge L on L.lodge_id = R.fk_lodge_id    
    )v2
    WHERE rv_status = 1
    group by fk_lodge_id

)
,
RC
AS

(
    SELECT LODGE_ID as RC_LODGE_ID, SUM(RM_CNT) AS TTL_RM_CNT
    FROM
    (
        SELECT  *
        FROM TBL_LODGE L
        JOIN TBL_lodge_type LT ON L.fk_lodge_type = LT.LODGE_TYPE
        JOIN TBL_CANCEL CN ON CN.CANCEL_OPT = L.fk_cancel_opt
        JOIN TBL_CHECKIN CI ON ci.s_checkin_type = L.fk_s_checkin_type
        JOIN TBL_SPA_TYPE ST ON st.spa_type = L.fk_spa_type
        join tbl_room R on L.lodge_id = R.fk_lodge_id
     )V1
     GROUP BY LODGE_ID
)

SELECT  lodge_id, lg_name, lg_en_name, lg_postcode, lg_address, lg_detailaddress, lg_extraaddress
       , lg_latitude, lg_longitude, lg_area, fk_lodge_type, lg_hotel_star, lg_qty, fk_cancel_opt
       , fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time, lg_checkin_end_time
       , lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn, lg_breakfast_yn
       , lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare, lg_fac_yn, lg_service_yn
       , lg_rm_service_yn, lg_beach_yn, lg_business_yn, lg_fa_travel_yn, fk_spa_type
       , lg_smoke_yn, lg_status
       , lodge_content
       , cancel_opt_content
       , s_checkin_content
       , spa_desc
       , rv_rating_avg, nvl(rv_cnt, 0) as rv_cnt
       , TTL_RM_CNT
       
 from V 
 LEFT join R on V.lodge_id = R.fk_lodge_id
 LEFT JOIN RC ON V.LODGE_ID = RC.RC_LODGE_ID
 where V.lodge_id = 'GWGN0002';
 
 --- 숙박시설에 달린 총 객실 수 구하기 ---
with V
as
(
    select *
    from tbl_lodge L 
    join tbl_room R on L.lodge_id = R.fk_lodge_id
)
select SUM(RM_CNT)
from v
where lodge_id='GWGN0001';
       
---- === 숙박시설 옵션 - 인터넷 (lg_internet_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_inet I on L.lodge_id = I.fk_lodge_id
    join tbl_inet_opt IO on I.fk_inet_opt_no = IO.inet_opt_no
    where lodge_id = 'GWGN0001';
)
select lodge_id, lg_name, lg_internet_yn, fk_inet_opt_no, inet_opt_desc
from V
where lodge_id = 'GWGN0001';

---- === 숙박시설 옵션 - 주차장 (lg_park_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_park P on L.lodge_id = P.fk_lodge_id
    join tbl_park_opt PO on P.fk_park_opt_no = PO.park_opt_no
)
select lodge_id, lg_name, lg_park_yn, fk_park_opt_no, park_opt_desc
from V
where lodge_id = 'GWGN0001';
select * from tbl_pool_opt;
---- === 숙박시설 옵션 - 다이닝장소 (lg_dining_place_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_din D on L.lodge_id = D.fk_lodge_id
    join tbl_din_opt DO on D.fk_din_opt_no = DO.din_opt_no
)
select lodge_id, lg_name, lg_dining_place_yn, fk_din_opt_no, din_opt_desc
from V
where lodge_id = 'GWGN0001';
---- === 숙박시설 옵션 - 수영장 (lg_pool_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_pool P on L.lodge_id = P.fk_lodge_id
    join tbl_pool_opt PO on P.fk_pool_opt_no = PO.pool_opt_no
)
select lodge_id, lg_name, lg_pool_yn, fk_pool_opt_no, pool_opt_desc
from V
where lodge_id = 'GWGN0001';

---- === 숙박시설 옵션 - 장애인편의시설 (lg_fac_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_fac F on L.lodge_id = F.fk_lodge_id
    join tbl_fac_opt FO on F.fk_fac_opt_no = FO.fac_opt_no
)
select lodge_id, lg_name, lg_fac_yn, fk_fac_opt_no, fac_opt_desc
from V
where lodge_id = 'GWGN0001';

---- === 숙박시설 옵션 - 고객서비스 (lg_service_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_cs C on L.lodge_id = C.fk_lodge_id
    join tbl_cs_opt CO on C.fk_cs_opt_no = CO.cs_opt_no
)
select lodge_id, lg_name, lg_service_yn, fk_cs_opt_no, cs_opt_desc
from V
where lodge_id = 'GWGN0001';

---- === 숙박시설 옵션 - 객실용품및서비스 (lg_rm_service_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_rmsvc R on L.lodge_id = R.fk_lodge_id
    join tbl_rmsvc_opt RO on R.fk_rmsvc_opt_no = RO.rmsvc_opt_no
)
select lodge_id, lg_name, lg_rm_service_yn, fk_rmsvc_opt_no, rmsvc_opt_desc
from V
where lodge_id = 'GWGN0001';


---- === 숙박시설 옵션 - 비즈니스 (lg_business_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_bsns B on L.lodge_id = B.fk_lodge_id
    join tbl_bsns_opt BO on B.fk_bsns_opt_no = BO.bsns_opt_no
)
select lodge_id, lg_name, lg_business_yn, fk_bsns_opt_no, bsns_opt_desc
from V
where lodge_id = 'GWGN0001';

---- === 숙박시설 옵션 - 가족여행 (lg_fa_travel_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_lodge L
    join tbl_fasvc F on L.lodge_id = F.fk_lodge_id
    join tbl_fasvc_opt FO on F.fk_fasvc_opt_no = FO.fasvc_opt_no
)
select lodge_id, lg_name, lg_fa_travel_yn, fk_fasvc_opt_no, fasvc_opt_desc
from V
where lodge_id = 'GWGN0001';

---- **** 숙박시설 사진 가져오기 **** ----
with V
as 
(
    select *
    from tbl_lodge L
    join tbl_lg_img LI on L.lodge_id = LI.fk_lodge_id
    join tbl_lg_img_cate LIC on LI.FK_IMG_CANO = LIC.img_cate_no
)
select lodge_id, lg_name, fk_img_cano, img_cate_name, lg_img_save_name
from V
where lodge_id = 'PARA0001';



---- === 객실 기본 정보 === ----
WITH V
AS
(
    SELECT *
    FROM TBL_ROOM R
    JOIN tbl_LODGE L ON R.fk_lodge_id = L.LODGE_ID
    JOIN tbl_view V ON R.fk_view_no = V.view_no
)
SELECT  rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
      , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
      , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
      , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
      , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn
      , view_desc
FROM V
WHERE fk_lodge_id = 'GWGN0001'; -- RM_SEQ = 'rm-3';rminfo
select * from tbl_view;
---- === 숙박시설 옵션 - 욕실시설 (rm_bathroom_cnt 이 0 이상일때) === ----
with V
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc, ROW_NUMBER() over (partition by bath_opt_no, fk_lodge_id
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_bath B on R.rm_seq = B.fk_rm_seq
        join tbl_bath_opt BO on B.fk_bath_opt_no = BO.bath_opt_no
    )v1
    where fk_lodge_id='GWGN0001' -- and rn='1' <!-- 전체 객실의 경우 -->
)
select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc
from V
where fk_lodge_id = 'GWGN0001'
GROUP BY bath_opt_desc;
---- === 객실 옵션 - 객실내다과 (rm_snack_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_room R
    join tbl_snack S on R.rm_seq = S.fk_rm_seq
    join tbl_snk_opt SO on S.fk_snk_opt_no = SO.snk_opt_no
)
select rm_seq, rm_type, rm_snack_yn, snk_opt_no, snk_opt_desc
from V
where V.FK_LODGE_ID = 'GWGN0001';
---- === 객실 옵션 - 조리시설 (rm_kitchen_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_room R
    join tbl_kitchen K on R.rm_seq = K.fk_rm_seq
    join tbl_kt_opt KO on K.fk_kt_opt_no = KO.kt_opt_no
)
select rm_seq, rm_type, rm_kitchen_yn, kt_opt_no, kt_opt_desc
from V
where rm_seq = 'rm-3';
---- === 객실 옵션 - 객실내엔터테인먼트 (rm_ent_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_room R
    join tbl_ent E on R.rm_seq = E.fk_rm_seq
    join tbl_ent_opt EO on E.fk_ent_opt_no = EO.ent_opt_no
)
select rm_seq, rm_type, rm_ent_yn, ent_opt_no, ent_opt_desc
from V
where rm_seq = 'rm-3';
---- === 객실 옵션 - 온도조절기 (rm_tmp_ctrl_yn 이 '0' 이 아닐때) === ----
with V
as
(
    select *
    from tbl_room R
    join tbl_tmp T on R.rm_seq = T.fk_rm_seq
    join tbl_tmp_opt TMO on T.fk_tmp_opt_no = TMO.tmp_opt_no
)
select rm_seq, rm_type, rm_tmp_ctrl_yn, tmp_opt_no, tmp_opt_desc
from V
where rm_seq = 'rm-3';


---- **** 객실 사진 가져오기 **** ----
with V
as 
(
    select *
    from tbl_rm_img RI
    join tbl_room R on RI.fk_rm_seq = R.rm_seq
)
select rm_seq, rm_img_name, rm_img_main
from v
where rm_seq = 'rm-3';

update tbl_room set rm_cnt=10
where rm_cnt is null;

commit;

desc tbl_lodge;
desc tbl_review;

select *
from user_tables;

---------- 체크인, 체크아웃 일자에 맞는 남은 객실수 ------------

with 
v1 as
(
    select *
    from tbl_room R
    JOIN tbl_view V ON R.fk_view_no = V.view_no
    
)
,
V2 as
(
    select fk_rm_seq, count(*) as rs_room_cnt
    from
        ( 
        select *
        from tbl_reservation RS
        join tbl_room R on R.rm_seq = RS.fk_rm_seq
     )
--    where (rs_checkindate <= to_date('2023-12-16')) and ((to_date('2023-12-16') < rs_checkoutdate) and (rs_checkoutdate <= to_date('2023-12-31')))
--        or ((to_date('2023-12-16') <= rs_checkindate) and ((rs_checkindate <= to_date('2023-12-31')) and (to_date('2023-12-31') <= rs_checkoutdate)))
--        or ((rs_checkindate <= to_date('2023-12-16')) and (to_date('2023-12-31') <= rs_checkoutdate))
--        or ((to_date('2023-12-16') <= rs_checkindate) and (rs_checkoutdate <= to_date('2023-12-31')))
    group by fk_rm_seq
)
select rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
      , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
      , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
      , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
      , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn
      , view_desc
      , rm_cnt , nvl(rs_room_cnt, 0) as  rs_room_cnt
from v1 
left join v2 on v1.rm_seq = v2.fk_rm_seq
where fk_lodge_id = 'GWGN0001' and V1.rm_cnt - nvl(v2.rs_room_cnt,0) > 0 and rm_guest_cnt>=2
order by to_number(rm_price);


---------------------------- 재훈이가 짠 남은 객실 수 sql 문 -----------------------------
select fk_lodge_id, rm_seq, rm_type, rm_cnt, nvl(rs_room_cnt, 0) AS rs_room_cnt
     , to_number(rm_cnt) - to_number(nvl(rs_room_cnt, 0)) AS rest_room_cnt
from
(
    select fk_lodge_id, rm_seq, rm_type, rm_cnt
    from tbl_room
    where fk_lodge_id = 'JESH0001'
) A
left join 
(
    select fk_rm_seq, count(*) as rs_room_cnt
    from
    (   
        select L.lodge_id, L.fk_h_userid, R.rs_name, R.rs_checkindate, R.rs_checkoutdate, R.fk_rm_seq
        from tbl_reservation R join tbl_lodge L
        on R.fk_h_userid = L.fk_h_userid
        where L.lodge_id = 'JESH0001'
        order by R.rs_checkindate, R.rs_checkoutdate
    )
    where (rs_checkindate <= to_date('2023-12-16')) and ((to_date('2023-12-16') < rs_checkoutdate) and (rs_checkoutdate <= to_date('2023-12-31')))
        or ((to_date('2023-12-16') <= rs_checkindate) and ((rs_checkindate <= to_date('2023-12-31')) and (to_date('2023-12-31') <= rs_checkoutdate)))
        or ((rs_checkindate <= to_date('2023-12-16')) and (to_date('2023-12-31') <= rs_checkoutdate))
        or ((to_date('2023-12-16') <= rs_checkindate) and (rs_checkoutdate <= to_date('2023-12-31')))
    group by fk_rm_seq
) B
on A.rm_seq = B.fk_rm_seq







--- 한 숙박 시설에 딸린 전체 옵션 조회 sql 문을 만들어 보자 ---
with 
V1
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc, ROW_NUMBER() over (partition by bath_opt_no, fk_lodge_id, rm_seq
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_bath B on R.rm_seq = B.fk_rm_seq
        join tbl_bath_opt BO on B.fk_bath_opt_no = BO.bath_opt_no
    )v
    where rn='1' and fk_lodge_id='GWGN0001' and rm_seq = 'rm-3'
)
,
V2
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_snack_yn, snk_opt_no, snk_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_snack_yn, snk_opt_no, snk_opt_desc, ROW_NUMBER() over (partition by snk_opt_no, fk_lodge_id
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_snack S on R.rm_seq = S.fk_rm_seq
        join tbl_snk_opt SO on S.fk_snk_opt_no = SO.snk_opt_no
    )v
    where rn='1'
)
,
V3
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_kitchen_yn, kt_opt_no, kt_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_kitchen_yn, kt_opt_no, kt_opt_desc, ROW_NUMBER() over (partition by kt_opt_no, fk_lodge_id, rm_seq
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_kitchen K on R.rm_seq = K.fk_rm_seq
        join tbl_kt_opt KO on K.fk_kt_opt_no = KO.kt_opt_no
    )v
    where rn='1' and rm_seq='rm-3'
)
,
V4
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_ent_yn, ent_opt_no, ent_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_ent_yn, ent_opt_no, ent_opt_desc, ROW_NUMBER() over (partition by ent_opt_no, fk_lodge_id
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_ent E on R.rm_seq = E.fk_rm_seq
        join tbl_ent_opt EO on E.fk_ent_opt_no = EO.ent_opt_no
    )v
    where rn='1'
)
,
V5
as
(
    select fk_lodge_id, rm_seq, rm_type, rm_tmp_ctrl_yn, tmp_opt_no, tmp_opt_desc
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_tmp_ctrl_yn, tmp_opt_no, tmp_opt_desc, ROW_NUMBER() over (partition by tmp_opt_no, fk_lodge_id
                             order by fk_lodge_id) as RN
        from tbl_room R
        join tbl_tmp T on R.rm_seq = T.fk_rm_seq
        join tbl_tmp_opt TMO on T.fk_tmp_opt_no = TMO.tmp_opt_no
    )v
    where rn='1' and fk_lodge_id=''
)
select L.lodge_id, bath_opt_desc, snk_opt_desc, kt_opt_desc, ent_opt_desc, tmp_opt_desc
       , bath_opt_no, snk_opt_no, kt_opt_no, ent_opt_no, tmp_opt_no
from tbl_lodge L
left join tbl_room R on L.lodge_id = R.fk_lodge_id
left join V1 on L.lodge_id = V1.fk_lodge_id
left join V2 on L.lodge_id = V2.fk_lodge_id
left join V3 on L.lodge_id = V3.fk_lodge_id
left join V4 on L.lodge_id = V4.fk_lodge_id
left join V5 on L.lodge_id = V5.fk_lodge_id
where L.lodge_id='GWGN0001';


select * from tbl_room where fk_lodge_id='GWGN0001' and rm_wheelchair_yn='1';

select fk_lodge_id, rm_seq, rm_type, rm_snack_yn, snk_opt_no, snk_opt_desc
from
(
    select fk_lodge_id, rm_seq, rm_type, rm_snack_yn, snk_opt_no, snk_opt_desc, ROW_NUMBER() over (partition by snk_opt_no, rm_seq
                                                                                                    order by fk_lodge_id) as RN
    from tbl_room R
    join tbl_snack S on R.rm_seq = S.fk_rm_seq
    join tbl_snk_opt SO on S.fk_snk_opt_no = SO.snk_opt_no
)v
where rn=1 and rm_seq in ('rm-2', 'rm-3', 'rm-4');


select fk_lodge_id, fk_pool_opt_no, pool_seq
from tbl_pool
order by fk_lodge_id, fk_fac_opt_no;

DELETE FROM tbl_pool WHERE pool_seq='22';

commit;

select *
from tbl_lg_img;

select *
from tbl_room
where fk_lodge_id='JSUN0231';


select fk_lodge_id, rm_seq, rm_type, rm_bathroom_cnt, bath_opt_no, bath_opt_desc
from V
where fk_lodge_id = 'GWGN0001'
GROUP BY bath_opt_desc;


--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '0.시설외부_1.png', '0.시설외부_1.png', '0');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_1.png', '1.공용구역_1.png', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_2.png', '1.공용구역_2.png', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_3.png', '1.공용구역_3.png', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_4.png', '1.공용구역_4.png', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_5.png', '1.공용구역_5.pngg', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '1.공용구역_6.png', '1.공용구역_6.png', '1');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '2.수영장_1.png', '2.수영장_1.png', '2');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '3.다이닝_1.png', '3.다이닝_1.png', '3');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '3.다이닝_2.png', '3.다이닝_2.png', '3');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '3.다이닝_3.png', '3.다이닝_3.png', '3');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '5.전망_1.png', '5.전망_1.png', '5');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '5.전망_2.png', '5.전망_2.png', '5');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '5.전망_3.png', '5.전망_3.png', '5');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', 'lg_img_name', '6.메인_1.png', '6');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '6.메인_2.png', '6.메인_2.png', '6');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '6.메인_3.png', '6.메인_3.png', '6');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '6.메인_4.png', '6.메인_4.png', '6');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '6.메인_5.png', '6.메인_5.png', '6');
--insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
--values(seq_tbl_lg_img.nextval, 'GWGN0002', '4.편의시설_1.png', '4.편의시설_1.png', '4');

--update tbl_lg_img set lg_img_save_name = to_char(SYSTIMESTAMP,'YYYYMMDDHH24MISSFF5')||'.png'
--WHERE lg_img_name='6.메인_5.png';
;
SELECT *
FROM TBL_LG_IMG
WHERE FK_LODGE_ID='GWGN0002';
COMMIT;
desc tbl_rm_img;
select * from tbl_rm_img;

--------- 해당 
with V
as
(
    select fk_lodge_id, lg_img_save_name, img_cate_no, img_cate_name
    from TBL_LG_IMG L
    join TBL_LG_IMG_CATE LC on L.fk_img_cano = LC.img_cate_no
)
select img_cate_no, img_cate_name, count(*) as ca_img_cnt
from v
where fk_lodge_id = 'GWGN0002'
group by img_cate_no, img_cate_name
order by img_cate_no;

select fk_lodge_id, lg_img_save_name, img_cate_no, img_cate_name
from TBL_LG_IMG L
join TBL_LG_IMG_CATE LC on L.fk_img_cano = LC.img_cate_no
where fk_lodge_id = 'GWGN0002' and img_cate_no = '';

select * from user_tables;
select * from TBL_LG_IMG_CATE;

with V
as 
(
    select *
    from tbl_lodge L
    join tbl_lg_img LI on L.lodge_id = LI.fk_lodge_id
    join tbl_lg_img_cate LIC on LI.FK_IMG_CANO = LIC.img_cate_no
)
select lodge_id, lg_name, fk_img_cano, img_cate_name, lg_img_save_name
from V
where lodge_id = 'GWGN0002'
and fk_img_cano = 6;


with V
as
(
    select fk_lodge_id, lg_img_save_name, img_cate_no, img_cate_name
    from TBL_LG_IMG L
    join TBL_LG_IMG_CATE LC on L.fk_img_cano = LC.img_cate_no
)
select img_cate_no, img_cate_name, count(*) as ca_img_cnt
from v
where fk_lodge_id = 'GWGN0002'
group by img_cate_no, img_cate_name
order by img_cate_no
select img_cate_name
from tbl_lg_img_cate
where img_cate_no = 2;

select * from tbl_user;
select * from tbl_lodge;
update tbl_user set idle=1;

select * from tbl_room where rm_seq='rm-8';
select * from tbl_reservation;
select * from tbl_view;
commit;
select * from tbl_wishlist;
--
--insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
--                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
--                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
--                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
--                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
--                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
--                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_status)
--values('GWGN0003', 'hoteltops10@naver.com', '호텔 탑스텐', 'Hotel Tops 10', '25633', '강원특별자치도 강릉시 옥계면 헌화로 455-34',
--       '', '(옥계면 금진리)', '37.6549884', '129.0523859', '4', '강원특별자치도', '강릉시',
--       '0', '333', '2', '1', '24시간',
--       '0', '03:00 PM','언제든지','11:00 AM', '18','1',
--       '1' , '1', '1', '1', '0', '',
--       '1', '1', '1', '1', '1'
--       , '1', '1', '0', default);       
--insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no) values(seq_tbl_inet.nextval, 'GWGN0003','0');
--insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no) values(seq_tbl_inet.nextval, 'GWGN0003','1');      
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0003','0');
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0003','1');
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no) values(seq_tbl_park.nextval, 'GWGN0003','3');
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no) values(seq_tbl_din.nextval, 'GWGN0003','0');
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no) values(seq_tbl_din.nextval, 'GWGN0003','1');
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no) values(seq_tbl_din.nextval, 'GWGN0003','2');
--insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'GWGN0003','0');
--insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'GWGN0003','1');
--insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no) values(seq_tbl_fac.nextval, 'GWGN0003','0');
--insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no) values(seq_tbl_fac.nextval, 'GWGN0003','1');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '0');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '2');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '4');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '5');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '6');
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no) values(seq_tbl_cs.nextval, 'GWGN0003', '7');
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no) values(seq_tbl_rmsvc.nextval, 'GWGN0003', '3');
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no) values(seq_tbl_rmsvc.nextval, 'GWGN0003', '6');
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no) values(seq_tbl_rmsvc.nextval, 'GWGN0003', '7');
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no) values(seq_tbl_bsns.nextval, 'GWGN0003', '0');
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no) values(seq_tbl_bsns.nextval, 'GWGN0003', '1');
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no) values(seq_tbl_bsns.nextval, 'GWGN0003', '3');
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no) values(seq_tbl_fasvc.nextval, 'GWGN0003', '0');
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no) values(seq_tbl_fasvc.nextval, 'GWGN0003', '2');
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no) values(seq_tbl_fasvc.nextval, 'GWGN0003', '3');
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no) values(seq_tbl_fasvc.nextval, 'GWGN0003', '5');
desc tbl_reservation;

--------------------- 포인트 테이블 및 시퀀스 생성 ---------------------

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

create sequence seq_tbl_point
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--------------------- 포인트 테이블 및 시퀀스 생성 끝 ---------------------

select * from tbl_reservation where fk_userid='test1@naver.com' order by rs_seq;
select * from tbl_point;
desc tbl_point;

insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_udpate_date, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '21', to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 7260);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_update_date, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '22', to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 653400*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_update_date, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '23', to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 653400*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_update_date, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '20', to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 653400*0.02);

insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '10', 40656);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq,pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '13', 2468400*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '17', 653400*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '18', 423500*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '20', 423500*0.02);
insert into tbl_point (pt_seq, fk_userid, fk_rs_seq, pt_amount)
values(seq_tbl_point.nextval, 'test1@naver.com', '21', -40000);

update tbl_point set pt_change_date = to_char(add_months(sysdate, -25)) where fk_rs_seq='10';

select to_number(pt_seq) as pt_seq, P.fk_userid as fk_userid, P.fk_rs_seq as rs_seq, to_char(pt_change_date, 'yyyy-mm-dd') as pt_change_date, pt_amount
     , R.rs_checkindate, R.rs_checkoutdate, L.lg_name
from tbl_point P
join tbl_reservation R on R.rs_seq = P.fk_rs_seq
join tbl_room RM on RM.rm_seq = R.fk_rm_seq
join tbl_lodge L on L.lodge_id = RM.fk_lodge_id
where P.fk_userid = 'test1@naver.com' and R.rs_cancel = 0
order by pt_seq;


select *
from tbl_reservation
where rs_cancel = 0 and rs_checkindate-sysdate < 0 and to_char(rs_checkindate,'yyyy')=to_char(sysdate, 'yyyy') and fk_userid= ;


