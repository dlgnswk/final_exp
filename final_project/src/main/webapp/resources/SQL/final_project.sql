show user;
-- USER이(가) "FINAL_ORAUSER3"입니다.


select * from tab;

insert into name(name) values('최우현');
commit;


desc tbl_user

--동빈이 테이블

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
,fk_self_checkin_yn     Nvarchar2(2)        not null            -- 셀프체크인방법 / 0:없음, 1:있음 --> 이후 체크박스 선택
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
-- 기본키 --
,constraint PK_tbl_lodge_lodge_id primary key(lodge_id)
-- 참조 제약 --
,constraint FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)                         -- 아이디 참조제약
,constraint FK_tbl_lodge_fk_lodge_type foreign key(fk_lodge_type) references tbl_lodge_type(lodge_type)             -- 숙박시설유형 참조제약
,constraint FK_tbl_lodge_fk_cancel_opt foreign key(fk_cancel_opt) references tbl_cancel(cancel_opt)                 -- 취소정책옵션_번호 참조제약
,constraint FK_tbl_lodge_fk_self_checkin foreign key(fk_self_checkin_yn) references tbl_checkin(self_checkin)       -- 셀프체크인방법 참조제약 (30글자초과)
)
-- Table TBL_LODGE이(가) 생성되었습니다.

---------------------------------------------------------------------------------------
-- 42개
insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_self_checkin_yn, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn)
values('숙박시설ID--SIRA0001, WTWQ1234', '사업자아이디--dodoh@naver.com?', '숙박시설--신라호텔부평점', '호텔영문명--sin hotel busan', '우편번호--02134'
     , '주소--부산진구 가야대로 772','상세주소--null ', '참고항목--null', '지역위도--123.41235521251', '지역경도--55.2315234124'
     , '호텔등급--4성급','지역명--부산진구 ', '지역명2--가야대로', '숙박시설유형--4', '객실수--120'
     , '취소정책옵션번호--0','프런트데스크--0 ', '프런트데스크운영시간--없음', '셀프체크인방법--0', '체크인시간_시작--09:00 AM'
     , '체크인시간_마감--09:00 PM', '체크아웃 (가능)시간--10:00PM', '제한나이--2', '인터넷제공--0', '주차장--1'
     , '아침식사--1', '다이닝 장소--1', '수영장타입--1', '반려동물--1','반려동물 요금--30000'
     , '장애인 편의시설타입--1', '고객서비스--1', '객실 용품 및 서비스--0', '해변--1' ,'비즈니스--1'
     , '가족여행--1', '스파--1','흡연구역--0', '짐 보관 서비스--0', '사물함 이용 가능--0'
     , '세탁 시설 유무--0', '하우스키핑 서비스 유무--0')
------------------------------------------------------------------------------------------------------

---------------------------------------------------객실정보 tbl_room----------------------------------------------------
-------- ***** >>>> 객실(room) 관련 테이블 & 시퀀스 생성 시작!! <<<< ***** --------

create table tbl_view
(view_no nvarchar2(2)    not null -- 전망_옵션
,view_desc nvarchar2(30) not null -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망
,constraint PK_tbl_view_view_no primary key(view_no)
);

create table tbl_room
(rm_seq           nvarchar2(15) not null -- 객실고유번호
,fk_lodge_id      nvarchar2(10) not null -- fk_시설id
,rm_type          nvarchar2(30) not null -- 객실이름(type)
,rm_cnt           nvarchar2(4)  not null -- 객실 수 
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

alter table tbl_room
add rm_cnt Nvarchar2(4);
commit;

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
,snk_opt_desc nvarchar2(30)  not null-- 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바
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
insert into tbl_park_opt (park_opt_no, park_opt_desc) values('0','실내');
insert into tbl_park_opt (park_opt_no, park_opt_desc) values('1','실외');
insert into tbl_park_opt (park_opt_no, park_opt_desc) values('2','주차대행');
insert into tbl_park_opt (park_opt_no, park_opt_desc) values('3','셀프주차');
commit;

create table tbl_din_opt
(din_opt_no   nvarchar2(2)   not null
,din_opt_desc nvarchar2(30)  not null-- 0 : 레스토랑 / 1 : 카페 / 2 : 바
,constraint PK_tbl_din_opt_din_opt_no primary key(din_opt_no) 
);

insert into tbl_din_opt (din_opt_no, din_opt_desc) values('0','레스토랑');
insert into tbl_din_opt (din_opt_no, din_opt_desc) values('1','카페');
insert into tbl_din_opt (din_opt_no, din_opt_desc) values('2','바');



create table tbl_pool_opt
(pool_opt_no   nvarchar2(2) not null
,pool_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
,constraint PK_tbl_pool_opt_pool_opt_no primary key(pool_opt_no) 
);
insert into tbl_pool_opt (pool_opt_no, pool_opt_desc) values('0','실내');
insert into tbl_pool_opt (pool_opt_no, pool_opt_desc) values('1','야외(1년 내내)');
insert into tbl_pool_opt (pool_opt_no, pool_opt_desc) values('2','야외(시즌 운영)');
commit;


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
---------------------------------------------------------------------------------------------------------




------------- >>>>>>>> 일정관리(풀캘린더) 시작 <<<<<<<< -------------

-- *** 캘린더 대분류(내캘린더, 사내캘린더  분류) ***
create table tbl_calendar_large_category 
(lgcatgono   number(3) not null      -- 캘린더 대분류 번호
,lgcatgoname varchar2(50) not null   -- 캘린더 대분류 명
,constraint PK_tbl_calendar_large_category primary key(lgcatgono)
);
-- Table TBL_CALENDAR_LARGE_CATEGORY이(가) 생성되었습니다.





insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(1, '내캘린더');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(2, '사내캘린더');

commit;
-- 커밋 완료.

select * 
from tbl_calendar_large_category;


-- *** 캘린더 소분류 *** 
-- (예: 내캘린더중 점심약속, 내캘린더중 저녁약속, 내캘린더중 운동, 내캘린더중 휴가, 내캘린더중 여행, 내캘린더중 출장 등등) 
-- (예: 사내캘린더중 플젝주제선정, 사내캘린더중 플젝요구사항, 사내캘린더중 DB모델링, 사내캘린더중 플젝코딩, 사내캘린더중 PPT작성, 사내캘린더중 플젝발표 등등) 
create table tbl_calendar_small_category 
(smcatgono    number(8) not null      -- 캘린더 소분류 번호
,fk_lgcatgono number(3) not null      -- 캘린더 대분류 번호
,smcatgoname  varchar2(400) not null  -- 캘린더 소분류 명
,fk_userid    varchar2(40) not null   -- 캘린더 소분류 작성자 유저아이디
,constraint PK_tbl_calendar_small_category primary key(smcatgono)
,constraint FK_small_category_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade
,constraint FK_small_category_fk_userid foreign key(fk_userid) references tbl_member(userid)            
);
-- Table TBL_CALENDAR_SMALL_CATEGORY이(가) 생성되었습니다.


create sequence seq_smcatgono
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SMCATGONO이(가) 생성되었습니다.


select *
from tbl_calendar_small_category
order by smcatgono desc;


-- *** 캘린더 일정 *** 
create table tbl_calendar_schedule 
(scheduleno    number                 -- 일정관리 번호
,startdate     date                   -- 시작일자
,enddate       date                   -- 종료일자
,subject       varchar2(400)          -- 제목
,color         varchar2(50)           -- 색상
,place         varchar2(200)          -- 장소
,joinuser      varchar2(4000)         -- 공유자   
,content       varchar2(4000)         -- 내용   
,fk_smcatgono  number(8)              -- 캘린더 소분류 번호
,fk_lgcatgono  number(3)              -- 캘린더 대분류 번호
,fk_userid     varchar2(40) not null  -- 캘린더 일정 작성자 유저아이디
,constraint PK_schedule_scheduleno primary key(scheduleno)
,constraint FK_schedule_fk_smcatgono foreign key(fk_smcatgono) 
            references tbl_calendar_small_category(smcatgono) on delete cascade
,constraint FK_schedule_fk_lgcatgono foreign key(fk_lgcatgono) 
            references tbl_calendar_large_category(lgcatgono) on delete cascade   
,constraint FK_schedule_fk_userid foreign key(fk_userid) references tbl_member(userid) 
);
-- Table TBL_CALENDAR_SCHEDULE이(가) 생성되었습니다.

create sequence seq_scheduleno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SCHEDULENO이(가) 생성되었습니다.

select *
from tbl_calendar_schedule 
order by scheduleno desc;


-- 일정 상세 보기
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.name
     , SC.smcatgoname
from tbl_calendar_schedule SD 
JOIN tbl_member M
ON SD.fk_userid = M.userid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = 21;

                   
insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday, coin, point, registerday, lastpwdchangedate, status, idle, gradelevel)  
values('leesunsin', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '이순신', '2IjrnBPpI++CfWQ7CQhjIw==', 'mFJBr/IdAdlb9ViZVTl5TA==', '03415', '서울 은평구 역말로 5', '2332', '(역촌동)', '1', '2023-10-17', '0', '0', default, default, default, default, default)

commit;

select *
from tbl_member
where name = '이순신';                    
                          
                          
------------- >>>>>>>> 일정관리(풀캘린더) 끝 <<<<<<<< -------------

---------------------- 숙소 세부 테이블 시작 ---------------------------
---------------------------tbl_lodge 시작 -------------------------


insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values( 'lote0001', 'lotte', '롯데호텔 서울', 'LOTTEHOTEL SEOUL', '04533'
     , '서울 중구 을지로 30','null ', ' (소공동)', '37.56533795', '126.98098153'
     , '5성급','서울특별시', '중구', '0', '1015'
     , '0','1', '24시간', '0', '15:00 PM'
     , '17:00 PM', '정오', '만19세', '1', '1'
     , '1', '1', '1', '0', null
     , '1', '1', '1', '0' ,'1'
     , '1', '1','0', '1', '1'
     , '0', '1', default)
commit;

select *
from user_sequences;

insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'lote0001','0');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'lote0001','1');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'lote0001','2');
commit;

insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'lote0001','0');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'lote0001','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'lote0001','2');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'lote0001','3');
commit;


insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'lote0001','0');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'lote0001','1');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'lote0001','2');
commit;


insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'lote0001','0');
commit;

insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'lote0001','1');
commit;

insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'lote0001', '8');

insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'lote0001', '7');
commit;

insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'lote0001', '3');

insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'lote0001', '1');



---------------------------tbl_lodge 끝 -------------------------

-------------------------tbl_room-------------------------------------------------
insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval, 'lote0001', '슈페리얼', '1', '0'
       , '30', '9.1', '0'
       , null, null, '1', null, null
       , '0', '1', '0', '0', '4'
       , '1', '1', '1', '2', '363000', '0');
commit;

insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval, 'lote0001', '이그제큐티브 프리미어', '1', '0'
       , '63 ', '19', '0'
       , null, null, null, null, '1'
       , '0', '1', '0', '0', '4'
       , '1', '1', '1', '2', '1016400', '1');

update tbl_room set rm_extra_bed_yn = '1'
where rm_seq = 'rm-15'

commit;
select *
from tbl_room
---------------------------tbl_room 끝 -------------------------

---------------------------tbl_room 옵션 --------------------------
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-15', '6');
commit;

insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-15', '3');
commit;

insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-15', '0');
commit;

insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-15', '2');
commit;




---------------------------tbl_room 옵션 끝 --------------------------




---------------------- 숙소 세부 테이블 끝 ---------------------------

select *
from tbl_host;

delete from tbl_host
where h_name = '최우현'

select fk_h_userid
from tbl_lodge



drop table tbl_host purge;

commit;
create table tbl_host
(h_userid   varchar2(100) -- 판매자아이디 r
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
-- Table TBL_HOST이(가) 생성되었습니다.

insert into tbl_host(h_userid, h_pw, h_name, h_lodgename, h_email, h_mobile, h_postcode, h_address, h_detailAddress, h_extraAddress, h_registerDate, h_lastpwdchangedate, h_status, h_legalName, h_businessNo)
values ('lotte1', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '롯데 호텔 서울', '02-771-1000', 04533, '서울특별시 중구 을지로 30', '롯데호텔', '(소공동)', default, default, 1, '롯데호텔', 123-12-31231);

select *
from tbl_host

commit;

insert into tbl_host(h_userid, h_pw, h_name, h_lodgename, h_email, h_mobile, h_postcode, h_address, h_detailAddress, h_extraAddress, h_registerDate, h_lastpwdchangedate, h_status,  h_legalName, h_businessNo)
		values('cwh1218', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '최우현', '롯데호텔', 'chlaudehdwkd@naver.com', '010-5558-7623', '11111', '서울', '특별시', '강남', default, default, default, 'lotte', '123-45-78901')

		
select h_userid, h_name, h_mobile, h_postcode, h_address, h_detailAddress,
       h_extraAddress, to_char(h_registerDate, 'yyyy-mm-dd') AS h_registerday,
       trunc(months_between(sysdate, h_lastpwdchangedate)) AS pwdchangegap,
       h_propType, h_roomCnt, h_legalName, h_businessNo,
       h_businessNo, h_chainStatus
from tbl_host
where h_status = 1 and h_userid = 'lotte1' and h_pw = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
		

select h_userid, h_name, h_lodgename, h_email, h_mobile, h_postcode, h_address, h_detailAddress,
               h_extraAddress, to_char(h_registerDate, 'yyyy-mm-dd') AS h_registerday,
               trunc(months_between(sysdate, h_lastpwdchangedate)) AS pwdchangegap,
               h_legalName, h_businessNo, h_status
from tbl_host
where h_status = 0 and h_userid = 'lotte' and h_pw = 'TrSb73UGPEDCdnX1cd16wg=='





create table tbl_user
(userid     varchar2(20) not null
,name       varchar2(30)
,email      varchar2(20) not null
,pw         varchar2(200) not null
,birth      varchar2(30)
,mobile     varchar2(30)
,gender     varchar2(1)
,postcode   varchar2(5)
,address    varchar2(20)
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

create table tbl_loginhistory
(HISTORYNO NUMBER       NOT NULL 
,FK_USERID VARCHAR2(40) NOT NULL 
,LOGINDATE DATE DEFAULT SYSDATE NOT NULL
,CLIENTIP  VARCHAR2(20) NOT NULL 
,CONSTRAINT FK_tbl_loginhistory_fk_userid foreign key (fk_userid) references tbl_user(userid)
);


insert into tbl_reservation()

desc tbl_reservation

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
,rs_mobile          varchar2(30)  not null          -- 예약자 연락처
,rs_email           varchar2(30)  not null  -- 예약자이메일
,rs_guest_cnt       nvarchar2(2)  not null  -- 투숙 인원
,fk_rm_seq          NVARCHAR2(15)           -- 객실 고유번호
,constraint PK_tbl_reservation_rs_seq primary key(rs_seq)
,constraint FK_tbl_user_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_host_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)
,constraint FK_tbl_reservation_fk_rm_seq foreign key(fk_rm_seq) references tbl_room(rm_seq)
);


drop table tbl_reservation purge;





create sequence seq_reservation
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop sequence seq_reservation;
commit;

select *
from tbl_lodge


insert into tbl_reservation(rs_seq, fk_userid, fK_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_payType, rs_name, rs_mobile, rs_email, rs_guest_cnt)
values(seq_reservation.nextval, 'test2@naver.com', 'lotte', default, to_date('2023-12-24', 'yyyy-mm-dd'), to_date('2023-12-25', 'yyyy-mm-dd'), 500000, 0, '우현', '010-1234-5678', 'chlaudehdwkd@naver.com', 2)

commit;




select *
from tbl_host
where h_userid = 'lotte'

update tbl_host set h_pw = '86fdff24aec78a01391e48e30b29bfdc0c47abdbbc6a0b9b833c5bc464a4cdbe'
where h_userid = 'p-city@paradian.com'

commit;

select *
from tbl_reservation


delete from tbl_host
where h_userid = 'cwh1218'

commit;

select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_name, rs_mobile, rs_email, lg_name, rm_type  
		from
			(
			select R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_name, R.rs_mobile, R.rs_email, L.lg_name, M.rm_type, M.rm_price  
			from tbl_reservation R join tbl_lodge L
			on L.fk_h_userid = R.fk_h_userid
			join tbl_room M
			on L.lodge_id = M.fk_lodge_id
			) V
		where fk_h_userid = 'lotte'


select *
from tbl_room

select *
from tbl_host

select *
from tbl_user

select rm_seq, fk_lodge_id, rm_type, rm_price, fk_h_userid
		from
			(
			select rm_seq, fk_lodge_id, rm_type, L.fk_h_userid, rm_price 
			from tbl_room R Join tbl_lodge L
			on R.fk_lodge_id = L.lodge_id
			) V
		where fk_h_userid = 'lotte'
		order by rm_seq asc

select *
from tbl_reservation

select *
from tbl_lodge

select *
from tbl_room

update tbl_room set rm_cnt = 10
where fk_lodge_id = 'lote0001'
commit;

select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_payType, rs_name, rs_mobile, rs_email 
from tbl_reservation
where fk_h_userid = 'lotte'

-- tbl join 결과
select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_name, rs_mobile, rs_email, name, lg_name, rm_type, rm_price  
from
(
select R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_name, R.rs_mobile, R.rs_email, U.name, L.lg_name, M.rm_type, M.rm_price  
from tbl_reservation R join tbl_user U
on R.fK_userid = U.userid
join tbl_lodge L
on L.fk_h_userid = R.fk_h_userid
join tbl_room M
on L.lodge_id = M.fk_lodge_id
) V
where fk_h_userid = 'lotte' 


select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_name, rs_mobile, rs_email, lodge_id, rm_seq 
		from
			(
			select R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_name, R.rs_mobile, R.rs_email, L.lodge_id, M.rm_seq  
			from tbl_reservation R join tbl_lodge L
			on L.fk_h_userid = R.fk_h_userid
			join tbl_room M
			on L.lodge_id = M.fk_lodge_id
			) V
		where fk_h_userid = 'lotte'

select rm_seq, fk_lodge_id, rm_type, fk_h_userid
from
(
select rm_seq, fk_lodge_id, rm_type, L.fk_h_userid
from tbl_room R Join tbl_lodge L
on R.fk_lodge_id = L.lodge_id
) V
where fk_h_userid = 'lotte' 
order by rm_seq asc
		
select rm_seq, rm_type, fk_h_userid
		from tbl_room
		where fk_h_userid= 'lotte'
		order by rm_seq asc


select rm_seq, fk_lodge_id, rm_type, fk_h_userid, row_number() over(order by rm_seq asc) AS RNO
from
    (
    select rm_seq, fk_lodge_id, rm_type, L.fk_h_userid
    from tbl_room R Join tbl_lodge L
    on R.fk_lodge_id = L.lodge_id
    ) V
where fk_h_userid = 'lotte' 
order by rm_seq asc
 
 

select R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_guest_cnt, R.rs_name, R.rs_mobile, R.rs_email, L.lodge_id, M.rm_seq  
from tbl_reservation R join tbl_lodge L
on L.fk_h_userid = R.fk_h_userid
join tbl_room M
on L.lodge_id = M.fk_lodge_id
where R.rs_seq = '13'     
group by M.rm_seq, R.fk_rm_seq, L.lodge_id          
        
select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_guest_cnt, rs_name, rs_mobile, rs_email, lodge_id, fk_rm_seq        
from
(        
SELECT R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_guest_cnt, R.rs_name, R.rs_mobile, R.rs_email, L.lodge_id, R.fk_rm_seq  
FROM tbl_reservation R 
JOIN tbl_lodge L ON L.fk_h_userid = R.fk_h_userid
JOIN tbl_room M ON L.lodge_id = M.fk_lodge_id
)V
where rs_seq = '13' 
group by rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_guest_cnt, rs_name, rs_mobile, rs_email, lodge_id, fk_rm_seq       
       
        
        
        
select *        
from tbl_reservation        
where fk_h_userid = 'lotte'

select *
from tbl_lodge
where fk_h_userid = 'lotte'

select *
from tbl_room
where fk_lodge_id = 'lote0001'


select *
from tbl_reservation
where fk_h_userid = 'lotte' and fk_rm_seq = 'rm-14'


select rs_seq 
     , rs_checkinDate, rs_checkoutDate
     , rs_name, rs_mobile
     , rs_price, fk_rm_seq 
from 
(
    select  row_number() over(order by R.rs_seq desc) as rno 
          , R.rs_seq
          , to_char(R.rs_checkinDate, 'yyyy-mm-dd hh24:mi') as rs_checkinDate
          , to_char(R.rs_checkoutDate, 'yyyy-mm-dd hh24:mi') as rs_checkoutDate
          , R.rs_name, R.rs_mobile, M.rm_type 
          , R.rs_price, R.fk_rm_seq 
    from tbl_reservation R 
    JOIN tbl_host H 
    ON R.fk_h_userid = H.h_userid
    JOIN tbl_lodge L 
    ON H.h_userid = L.fk_h_userid
    join tbl_room M
    on R.fk_rm_seq = M.rm_seq
    where ( to_char(R.rs_checkinDate,'YYYY-MM-DD') between '2023-11-19' and '2024-01-19' )
    AND   ( to_char(R.rs_checkoutDate,'YYYY-MM-DD') between '2023-11-19' and '2024-01-19' ) 
    and ( R.fk_h_userid = 'lotte' )
) V 
where V.rno between #{startRno} and #{endRno}
group by rs_seq, rs_checkinDate, rs_checkoutDate, rs_name, rs_mobile, rm_type, rs_price, fk_rm_seq











-------------------------------  차트 sql문 시작 ----------------------------------
    select count(*) as cnt
                  , rm_type 
                  , to_char(R.rs_checkinDate, 'yyyy-MM') as rs_checkinDate
    from tbl_reservation R 
    join tbl_room M
    on R.fk_rm_seq = M.rm_seq
    where R.fk_h_userid = 'lotte'
    group by rm_type, rs_checkinDate 


select count(*) as cnt
	                  , rm_type
	                  , to_char(R.rs_checkinDate, 'yyyy-MM') as rs_checkinDate 
	    from tbl_reservation R 
	    join tbl_room M
	    on R.fk_rm_seq = M.rm_seq
	    where R.fk_h_userid = 'lotte'
	    and to_char(R.rs_checkinDate, 'yyyy-MM') = '2023-12'
	    group by rm_type, rs_checkinDate

select nvl(sum(count(*)) , 0) as cnt
from
(
select rm_type, R.rs_checkinDate
from tbl_reservation R 
join tbl_room M
on R.fk_rm_seq = M.rm_seq
) V
where rm_type = '슈페리얼'
and to_char(rs_checkinDate,'YYYY-MM') = '2023-01'
group by rm_type, rs_checkinDate;




select rm_type
     , SUM( decode( to_char(rs_checkindate, 'mm'), '01', 1, 0) ) AS MON01
     , SUM( decode( to_char(rs_checkindate, 'mm'), '02', 1, 0) ) AS MON02
     , SUM( decode( to_char(rs_checkindate, 'mm'), '03', 1, 0) ) AS MON03
     , SUM( decode( to_char(rs_checkindate, 'mm'), '04', 1, 0) ) AS MON04
     , SUM( decode( to_char(rs_checkindate, 'mm'), '05', 1, 0) ) AS MON05
     , SUM( decode( to_char(rs_checkindate, 'mm'), '06', 1, 0) ) AS MON06
     , SUM( decode( to_char(rs_checkindate, 'mm'), '07', 1, 0) ) AS MON07
     , SUM( decode( to_char(rs_checkindate, 'mm'), '08', 1, 0) ) AS MON08
     , SUM( decode( to_char(rs_checkindate, 'mm'), '09', 1, 0) ) AS MON09
     , SUM( decode( to_char(rs_checkindate, 'mm'), '10', 1, 0) ) AS MON10
     , SUM( decode( to_char(rs_checkindate, 'mm'), '11', 1, 0) ) AS MON11
     , SUM( decode( to_char(rs_checkindate, 'mm'), '12', 1, 0) ) AS MON12 
FROM 
(
    SELECT *     
    FROM tbl_room RM LEFT JOIN tbl_reservation RS  
    ON RM.rm_seq = RS.fk_rm_seq  
    LEFT JOIN tbl_lodge L
    ON RS.fk_h_userid = L.fk_h_userid   
    WHERE to_char(rs_checkindate, 'yyyy') = to_char( add_months(sysdate, -12*(to_number(to_char(sysdate,'yyyy')) - to_number('2022') )  ) , 'yyyy')
    AND RS.fk_h_userid = 'lotte'
    UNION ALL 
    SELECT *     
    FROM tbl_room RM LEFT JOIN tbl_reservation RS  
    ON RM.rm_seq = RS.fk_rm_seq  
    LEFT JOIN tbl_lodge L
    ON RM.fk_lodge_id = L.lodge_id 
    WHERE RS.rs_date IS NULL
    AND L.fk_h_userid = 'lotte'
) V
GROUP BY rm_type; 
-------------------------------  차트 sql문 끝 ----------------------------------

select h_userid, h_pw, h_name, h_lodgename, h_email, h_mobile, h_postcode, h_address, h_detailAddress,
               h_extraAddress, to_char(h_registerDate, 'yyyy-mm-dd') AS h_registerday,
               trunc(months_between(sysdate, h_lastpwdchangedate)) AS h_pwdchangegap,
               h_legalName, h_businessNo, h_status
		from tbl_host
		where h_userid = 'lotte' and h_pw = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'

update tbl_host set h_pw = #{pw}, h_name = #{name}, h_lodgename = #{lodgename}, h_email = #{email}, h_mobile = #{mobile}
                  , h_postcode = #{postcode}, h_address = #{address}, h_detailAddress = #{detailAddress}, h_extraAddress = #{extraAddress}
                  , h_legalName = #{legalName}, h_businessNo = #{h_businessNo}
where h_userid = #{userid}  

update tbl_host set h_pw = '86fdff24aec78a01391e48e30b29bfdc0c47abdbbc6a0b9b833c5bc464a4cdbe'
where h_userid = 'lotte'
commit;

select *
from tbl_user;

select *
from tbl_reservation

select *
from tbl_host
where h_userid = 'lotte'






select row_number() over(order by fk_rm_seq desc) AS RNO,
       rm_type, rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_guest_cnt, rs_name, rs_mobile, rs_email, lodge_id, fk_rm_seq 
FROM 
(
    SELECT RS.rs_seq, RS.fk_userid, RS.fk_h_userid, RS.rs_date, RS.rs_checkinDate, RS.rs_checkoutDate, RS.rs_price, RS.rs_paytype, RS.rs_guest_cnt, RS.rs_name, RS.rs_mobile, RS.rs_email, L.lodge_id, RS.fk_rm_seq, RM.rm_type  
    FROM tbl_room RM LEFT JOIN tbl_reservation RS  
    ON RM.rm_seq = RS.fk_rm_seq  
    LEFT JOIN tbl_lodge L
    ON RS.fk_h_userid = L.fk_h_userid   
    WHERE RS.fk_h_userid = 'lotte'
    UNION ALL 
    SELECT RS.rs_seq, RS.fk_userid, RS.fk_h_userid, RS.rs_date, RS.rs_checkinDate, RS.rs_checkoutDate, RS.rs_price, RS.rs_paytype, RS.rs_guest_cnt, RS.rs_name, RS.rs_mobile, RS.rs_email, L.lodge_id, RS.fk_rm_seq, RM.rm_type       
    FROM tbl_room RM LEFT JOIN tbl_reservation RS  
    ON RM.rm_seq = RS.fk_rm_seq  
    LEFT JOIN tbl_lodge L
    ON RM.fk_lodge_id = L.lodge_id 
    WHERE RS.rs_date IS NULL
    AND L.fk_h_userid = 'lotte'
) V



-- rno 나오긴 하는데 실패작
select rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_guest_cnt, rs_name, rs_mobile, rs_email, lodge_id, fk_rm_seq        
		from
		(        
		SELECT R.rs_seq, R.fk_userid, R.fk_h_userid, R.rs_date, R.rs_checkinDate, R.rs_checkoutDate, R.rs_price, R.rs_paytype, R.rs_guest_cnt, R.rs_name, R.rs_mobile, R.rs_email, L.lodge_id, R.fk_rm_seq  
		FROM tbl_reservation R 
		JOIN tbl_lodge L ON L.fk_h_userid = R.fk_h_userid
		JOIN tbl_room M ON L.lodge_id = M.fk_lodge_id
		)V
		WHERE fk_h_userid = 'lotte'
		group by rs_seq, fk_userid, fk_h_userid, rs_date, rs_checkinDate, rs_checkoutDate, rs_price, rs_paytype, rs_guest_cnt, rs_name, rs_mobile, rs_email, lodge_id, fk_rm_seq 




select *
from tbl_host

commit;



----------------------------------- 채팅 관련 테이블 시작 --------------------------------------------


create sequence seq_tbl_chat
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_tbl_reply
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

COMMIT;




create table tbl_chat (
 chat_no	    varchar2(20)	    PRIMARY KEY        -- 채팅방 번호(게시글)
,fk_userid      varchar2(20)          not null         -- 사용자ID
,fk_h_userid    varchar2(100)        not null          -- 판매자 ID
,chat_date      date default sysdate  not null         -- 작성시간
,m_status       number(1) default 1   not null         -- 채팅방 삭제여부   1:사용가능한 글,  0:삭제된글
,constraint PK_tbl_chat_chat_no primary key(chat_no)
,constraint FK_tbl_chat_fk_userid foreign key(fk_userid) references tbl_user(userid)
,constraint FK_tbl_chat_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)
);


create table tbl_reply
(reply_no      varchar2(20)	    PRIMARY KEY    -- 답글 번호
,reply         varchar2(1000)       not null   -- 답글내용
,reply_date    date default sysdate not null   -- 작성일자
,fk_chat_no    varchar2(20)         not null   -- 원게시물 글번호                                        
,constraint PK_tbl_reply_reply_no primary key(reply_no)
,constraint FK_tbl_reply_fk_chat_no foreign key(fk_chat_no) references tbl_chat(chat_no) on delete cascade
);




----------------------------------- 채팅 관련 테이블 끝 ----------------------------------------------













