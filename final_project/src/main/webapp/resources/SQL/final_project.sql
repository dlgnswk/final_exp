show user;
-- USER이(가) "FINAL_ORAUSER3"입니다.

select * from tab;

select *
<<<<<<< HEAD
from name;

desc name;

insert into name(name)
values('박동빈');

commit;


-------------------------------------------------------------------------------
select * from tab;

-- 테이블 삭제
drop table tbl_checkin_time purge;

-- 테이블 컬럼 속성 변경 
alter table tbl_park
drop column park_content;

alter table tbl_lodge
add lg_name Nvarchar2(40) not null;

-- 시쿼스 삭제
drop sequence seq_yeyakno_2;

-- 시퀀스 검색
SELECT *
FROM all_sequences
WHERE sequence_owner = 'FINAL_ORAUSER3'

-- 데이터 행 삭제
delete from tbl_park
where park_type >= 0

-- 제약 추가 방법
alter table tbl_lodge modify LG_STATUS NVARCHAR2(2) default 0;

-- 테이블 생성 포맷
create table tbl_room_type
(room_type          nvarchar2(2)   not null  -- 회원아이디
,room_type_name                nvarchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,birthday           nvarchar2(10)             -- 생년월일
,sh_extraaddress    nvarchar2(200)                   -- 참고항목
,sh_msg             nvarchar2(100)        not null   -- 배송메세지
,constraint PK_tbl_member_userid primary key(userid) 
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_user(userid) on delete cascade
)

-- 제약 조건
select *
from USER_CONSTRAINTS
where table_name = 'EMPLOYEES';

------------------ >>> 숙박시설등록 테이블 만들기 시작 <<< ------------------------  
        
        
        -------- >> 숙박시설 << --------
-- 숙박시설유형 테이블 
create table tbl_lodge_type 
(lodge_type     nvarchar2(1)   not null  -- 숙박시설유형 0,1,2,3,4
,lodge_content  nvarchar2(20)  not null  -- 숙박시설유형유형내용 
                                             -- 0:호텔
                                             -- 1:모텔
                                             -- 2:아파트식호텔(레지던스)
                                             -- 3:리조트
                                             -- 4:펜션
,constraint PK_tbl_lodge_type_lodge_type primary key(lodge_type)
)
-- Table TBL_LODGE_TYPE이(가) 생성되었습니다.
insert into tbl_lodge_type(lodge_type, lodge_content) values('0', '호텔');
insert into tbl_lodge_type(lodge_type, lodge_content) values('1', '모텔');
insert into tbl_lodge_type(lodge_type, lodge_content) values('2', '아파트식호텔(레지던스)');
insert into tbl_lodge_type(lodge_type, lodge_content) values('3', '리조트');
insert into tbl_lodge_type(lodge_type, lodge_content) values('4', '펜션');



-- 취소정책옵션_번호 테이블 
create table tbl_cancel
(cancel_opt             Nvarchar2(2)    not null  -- 취소정책옵션번호 / 0,1,2,3
,cancel_opt_content     Nvarchar2(80)   not null  -- 취소정책옵션내용
                                                      -- 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
                                                      -- 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
                                                      -- 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
                                                      -- 3 : 체크인 1시간 이전 : 100% 환불가능
,constraint PK_tbl_cancel_cancel_opt primary key(cancel_opt)
)
-- Table TBL_CANCEL이(가) 생성되었습니다.
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('0', '24시간 이전 : 50% 환불 가능 / 48시간 이전: 75% 환불 가능 / 72시간 이전: 100% 환불 가능');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('1', '24시간 이전 : 75% 환불 가능 / 48시간 이전: 100% 환불 가능');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('2', '24시간 이전 : 100% 환불 가능 / 그 이후 환불 불가');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('3', '체크인 1시간 이전 : 100% 환불 가능');



-- 셀프체크인방법 테이블
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
-- Table TBL_CHECKIN이(가) 생성되었습니다.
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('0', '셀프체크인불가','셀프체크인불가');
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('1', '엑세스코드','비밀번호 패드 도어록');
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('2', '키 수령 안내','키를 숨긴 장소 등');
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('3', '록박스 이용 안내','키가 있는 잠금 보관함');
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('4', '스마트 록 코드','WiFi 스마트 도어록');
insert into tbl_checkin(self_checkin, self_checkin_content,self_checkin_info) values('5', '익스프레스 체크인','고객이 키오스크를 사용하여 체크인 가능');



-- 숙박시설등록 테이블
create table tbl_lodge
(lodge_id               Nvarchar2(10)                   not null            -- 숙박시설ID / ex) SIRA0001, WTWQ1234
,fk_h_userid            varchar2(100)                   not null            -- 사업자아이디 / 참조키를 넣어야함! 어디에? 숙박업자 판매자에 
,lg_name                Nvarchar2(40)                   not null            -- 숙박시설 이름 / 
,lg_en_name             Nvarchar2(80)                   not null            -- 호텔영문명 / sin hotel busan
,lg_postcode            Nvarchar2(5)                    not null            -- 우편번호 / 12345 02134 

,lg_address             Nvarchar2(50)                   not null            -- 주소 
,lg_detailaddress       Nvarchar2(30)                                       -- 상세주소
,lg_extraaddress        Nvarchar2(30)                                       -- 참고항목 
,lg_latitude            Nvarchar2(20)                   not null            -- 지역위도 / 123.41235521251
,lg_longitude           Nvarchar2(20)                   not null            -- 지역경도 / 55.2315234124

,lg_hotel_star          Nvarchar2(10)                                       -- 호텔등급 (몇성급) / lg_hotel_star
,lg_area                Nvarchar2(10)                   not null            -- 지역명 / 서울
,lg_area_2              Nvarchar2(10)                   not null            -- 지역명2 / 서대문구
,fk_lodge_type          Nvarchar2(2)                    not null            -- 숙박시설유형 / 0,1,2,3,4,5
                                                                                 -- 0:호텔
                                                                                 -- 1:모텔
                                                                                 -- 2:아파트식호텔(레지던스)
                                                                                 -- 3:리조트
                                                                                 -- 4:펜션
,lg_qty                 Nvarchar2(5)                    not null            -- 객실수 / 숫자

,fk_cancel_opt          Nvarchar2(2)                    not null            -- 취소정책옵션번호 / 0,1,2,4
                                                                                  -- 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
                                                                                  -- 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
                                                                                  -- 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
                                                                                  -- 3 : 체크인 1시간 이전 : 100% 환불가능
,fd_status              Nvarchar2(2)                    not null            -- 프런트데스크 / 0:없음, 1:있음
,fd_time                Nvarchar2(30)                                       -- 프런트데스크운영시간 / '없음' or '09:00 AM ~ 09:00 PM' or '24시간'
,fk_s_checkin_type      Nvarchar2(2)                    not null            -- 셀프체크인방법 / 0,1,2,3,4,5
                                                                                 -- 0: 셀프체크인불가
                                                                                 -- 1: 엑세스코드
                                                                                 -- 2: 키 수령 안내
                                                                                 -- 3: 록박스 이용 안내
                                                                                 -- 4: 스마트 록 코드
                                                                                 -- 5: 익스프레스 체크인
,lg_checkin_start_time  Nvarchar2(30)                   not null            -- 체크인시간_시작 / 09:00 AM
    
,lg_checkin_end_time    Nvarchar2(30)                   not null            -- 체크인시간_마감 / 09:00 PM
,lg_checkout_time       Nvarchar2(20)                   not null            -- 체크아웃 (가능)시간 / 01:00 AM ~ 11:00 PM / 1시간 간격
,lg_age_limit           Nvarchar2(4)                    not null            -- 제한나이 / 15~25
,lg_internet_yn         Nvarchar2(2)                    not null            -- 인터넷제공 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_park_yn             Nvarchar2(2)                    not null            -- 주차장 / 0:없음, 1:있음 --> 이후 체크박스 선택

,lg_breakfast_yn        Nvarchar2(2)                    not null            -- 아침식사 / 0:제공안됨, 1:제공됨
,lg_dining_place_yn     Nvarchar2(2)                    not null            -- 다이닝 장소 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_pool_yn             Nvarchar2(2)                    not null            -- 수영장타입 / 0:없음, 1:있음 --> 이후 체크박스 선택
,lg_pet_yn              Nvarchar2(2)                    not null            -- 반려동물 / 0:불가, 1:허용
,lg_pet_fare            Nvarchar2(10)                                       -- 반려동물 요금 / null, 1마리당 요금 <input> ex) 30000

,lg_fac_yn              Nvarchar2(2)                    not null            -- 장애인 편의시설타입 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_service_yn          Nvarchar2(2)                    not null            -- 고객서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_rm_service_yn       Nvarchar2(2)                    not null            -- 객실 용품 및 서비스 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_beach_yn            Nvarchar2(2)                    not null            -- 해변 / 0:없음,1:있음
,fk_spa_type            Nvarchar2(2)                    not null            -- 스파 / 0:없음, 1:풀서비스 스파, 2:시설 내 스파서피스

,lg_smoke_yn            Nvarchar2(2)                    not null            -- 흡연구역 / 0:없음, 1:있음
,lg_business_yn         Nvarchar2(2)                    not null            -- 비즈니스 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_fa_travel_yn        Nvarchar2(2)                    not null            -- 가족여행 / 0:없음,1:있음 --> 이후 체크박스 선택
,lg_status              Nvarchar2(2)    default 0       not null            -- 시설 승인 상태 / 0:대기, 1:승인, 2:거절
-- 기본키 --
,constraint PK_tbl_lodge_lodge_id primary key(lodge_id)
-- 참조 제약 --
,constraint FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid)                         -- 아이디 참조제약
,constraint FK_tbl_lodge_fk_lodge_type foreign key(fk_lodge_type) references tbl_lodge_type(lodge_type)             -- 숙박시설유형 참조제약
,constraint FK_tbl_lodge_fk_cancel_opt foreign key(fk_cancel_opt) references tbl_cancel(cancel_opt)                 -- 취소정책옵션_번호 참조제약
,constraint FK_TBL_LODGE_FK_S_CHECKIN_TYPE foreign key(FK_S_CHECKIN_TYPE) references tbl_checkin(self_checkin)      -- 셀프체크인방법 참조제약 (30글자초과)
)
-- Table TBL_LODGE이(가) 생성되었습니다.

desc tbl_lodge
-- 42개

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, fk_spa_type
                    , lg_smoke_yn, lg_business_yn, lg_fa_travel_yn, lg_status)
values('숙박시설ID--SIRA0001, WTWQ1234', '사업자아이디--dodoh@naver.com', '숙박시설--신라호텔부평점', '호텔영문명--sin hotel busan', '우편번호--02134'
     , '주소--부산진구 가야대로 772','상세주소--null ', '참고항목--null', '지역위도--123.41235521251', '지역경도--55.2315234124'
     , '호텔등급--4성급','지역명--부산진구 ', '지역명2--가야대로', '숙박시설유형--4', '객실수--120'
     , '취소정책옵션번호--0','프런트데스크--0 ', '프런트데스크운영시간--없음', '셀프체크인방법--0', '체크인시간_시작--09:00 AM'
     , '체크인시간_마감--09:00 PM', '체크아웃 (가능)시간--10:00PM', '제한나이--2', '인터넷제공--0', '주차장--1'
     , '아침식사--1', '다이닝 장소--1', '수영장타입--1', '반려동물--1','반려동물 요금--30000'
     , '장애인 편의시설타입--1', '고객서비스--1', '객실 용품 및 서비스--0', '해변--1' ,'비즈니스--1'
     , '가족여행--1', '스파--1','흡연구역--0', '시설승인상태-default')


-- 숙박시설사진카테고리 테이블   
create table tbl_lg_img_cate
(img_cate_no      Nvarchar2(1)      not null  -- 카테고리 / 0,1,2,3,4,5
,img_cate_name    Nvarchar2(20)     not null  -- 카테고리명칭
                                                  -- 0:시설외부
                                                  -- 1:공용구역
                                                  -- 2:수영장
                                                  -- 3:다이닝
                                                  -- 4:편의시설/서비스
                                                  -- 5:전망
,constraint PK_tbl_lg_img_cate_img_cate_no primary key(img_cate_no)
)



create sequence seq_tbl_lg_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', 'JESH0001_6_01.png', '6');


-- Table TBL_LG_IMG_CATE이(가) 생성되었습니다.
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('0', '시설외부');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('1', '공용구역');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('2', '수영장');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('3', '다이닝');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('4', '편의시설/서비스');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('5', '전망');



-- Table TBL_ROOM_TYPE이(가) 생성되었습니다.
insert into tbl_room_type(room_type, room_type_name) values('0', '이코노미');
insert into tbl_room_type(room_type, room_type_name) values('1', '스탠다드');
insert into tbl_room_type(room_type, room_type_name) values('2', '비즈니스');
insert into tbl_room_type(room_type, room_type_name) values('3', '슈피리어');
insert into tbl_room_type(room_type, room_type_name) values('4', '디럭스');
insert into tbl_room_type(room_type, room_type_name) values('5', '패밀리');
insert into tbl_room_type(room_type, room_type_name) values('6', '익스클루시브');
insert into tbl_room_type(room_type, room_type_name) values('7', '이그제큐티브');



-- 객실등급 테이블
create table tbl_room_class
(room_class          nvarchar2(2)   not null  -- 객실등급 / 0,1,2,3,4,5,6,7
,room_class_name     nvarchar2(15)  not null  -- 객실등급명
                                                  -- 0: 싱글룸
                                                  -- 1: 스위트
                                                  -- 2: 트윈룸
                                                  -- 3: 더블룸
                                                  -- 4: 더블룸 또는 트윈룸
                                                  -- 5: 트리플룸
                                                  -- 6: 쿼드룸
                                                  -- 7: 스튜디오
,constraint PK_tbl_room_class_room_class primary key(room_class)
)
-- Table TBL_ROOM_CLASS이(가) 생성되었습니다.
insert into tbl_room_class(room_class, room_class_name) values('0', '싱글룸');
insert into tbl_room_class(room_class, room_class_name) values('1', '스위트');
insert into tbl_room_class(room_class, room_class_name) values('2', '트윈룸');
insert into tbl_room_class(room_class, room_class_name) values('3', '더블룸');
insert into tbl_room_class(room_class, room_class_name) values('4', '더블룸 또는 트윈룸');
insert into tbl_room_class(room_class, room_class_name) values('5', '트리플룸');
insert into tbl_room_class(room_class, room_class_name) values('6', '쿼드룸');
insert into tbl_room_class(room_class, room_class_name) values('7', '스튜디오');


create table tbl_spa_type
(spa_type       Nvarchar2(2)        not null
,spa_desc       Nvarchar2(30)       not null
,constraint PK_tbl_spa_type_spa_type primary key(spa_type)
)
-- Table TBL_SPA_TYPE이(가) 생성되었습니다.
insert into tbl_spa_type(spa_type, spa_desc) values('0', '없음');
insert into tbl_spa_type(spa_type, spa_desc) values('1', '풀 서비스 스파');
insert into tbl_spa_type(spa_type, spa_desc) values('2', '시설 내 스파 서비스');

commit;
-- 커밋 완료.
select *
from tbl_lodge

-- 객실 사진 테이블
create table tbl_room_img
(ro_img_seq         number(9)       not null    -- 객실이미지seq
,fk_room_seq        nvarchar2(15)   not null    -- 객실고유번호
,ro_img             nvarchar2(20)   not null    -- 객실이미지
,constraint PK_tbl_room_img_ro_img_seq primary key(ro_img_seq) -- ro_img_seq 기본키
,constraint FK_tbl_room_img_fk_room_seq foreign key(fk_room_seq) references tbl_room(room_seq) on delete cascade -- 참조제약
)
-- Table TBL_ROOM_IMG이(가) 생성되었습니다.
select *
from tbl_room_img
select *
from tbl_lodge

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
drop column rm_size_feet;
-- 피트 필요없음
desc tbl_room

-- 
create table tbl_bath_opt
(bath_opt_no   nvarchar2(2)  not null
,bath_opt_desc nvarchar2(30) not null -- 0 : 타월제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
,constraint PK_tbl_bath_opt_bath_opt_no primary key(bath_opt_no) 
);
select *
from tbl_bath_opt

create table tbl_kt_opt
(kt_opt_no   nvarchar2(2)  not null
,kt_opt_desc nvarchar2(30) not null-- 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
,constraint PK_tbl_kt_opt_kt_opt_no primary key(kt_opt_no) 
);

select *
from tbl_kt_opt

create table tbl_snk_opt
(snk_opt_no   nvarchar2(2)   not null
,snk_opt_desc nvarchar2(30)  not null-- 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 바
,constraint PK_tbl_snk_opt_snk_opt_no primary key(snk_opt_no) 
);

select *
from tbl_snk_opt

create table tbl_ent_opt
(ent_opt_no   nvarchar2(2) not null
,ent_opt_desc nvarchar2(30)  not null-- 0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
,constraint PK_tbl_ent_opt_ent_opt_no primary key(ent_opt_no) 
);

select *
from tbl_ent_opt

create table tbl_tmp_opt
(tmp_opt_no nvarchar2(2)    not null
,tmp_opt_desc nvarchar2(30) not null -- 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
,constraint PK_tbl_tmp_opt_tmp_opt_no primary key(tmp_opt_no)
);

select *
from tbl_tmp_opt

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
select *
from tbl_inet_opt

create table tbl_park_opt
(park_opt_no   nvarchar2(2)  not null
,park_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
,constraint PK_tbl_park_opt_park_opt_no primary key(park_opt_no) 
);

select *
from tbl_park_opt


create table tbl_din_opt
(din_opt_no   nvarchar2(2)   not null
,din_opt_desc nvarchar2(30)  not null-- 0 : 레스토랑 / 1 : 카페 / 2 : 바
,constraint PK_tbl_din_opt_din_opt_no primary key(din_opt_no) 
);

select *
from tbl_din_opt

create table tbl_pool_opt
(pool_opt_no   nvarchar2(2) not null
,pool_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
,constraint PK_tbl_pool_opt_pool_opt_no primary key(pool_opt_no) 
);

select *
from tbl_pool_opt

create table tbl_fac_opt
(fac_opt_no   nvarchar2(2)  not null
,fac_opt_desc nvarchar2(30) not null -- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
,constraint PK_tbl_fac_opt_fac_opt_no primary key(fac_opt_no) 
);

select *
from tbl_fac_opt

create table tbl_cs_opt
(cs_opt_no   nvarchar2(2)  not null
,cs_opt_desc nvarchar2(30) not null -- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 
                                    -- 5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
,constraint PK_tbl_cs_opt_cs_opt_no primary key(cs_opt_no) 
);

select *
from tbl_cs_opt

create table tbl_rmsvc_opt
(rmsvc_opt_no   nvarchar2(2)  not null
,rmsvc_opt_desc nvarchar2(30) not null -- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터
                                       -- 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
,constraint PK_tbl_rmsvc_opt_rmsvc_opt_no primary key(rmsvc_opt_no) 
);

select *
from tbl_rmsvc_opt

create table tbl_bsns_opt
(bsns_opt_no   nvarchar2(2)  not null
,bsns_opt_desc nvarchar2(30) not null-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
,constraint PK_tbl_bsns_opt_bsns_opt_no primary key(bsns_opt_no)
);

select *
from tbl_bsns_opt

create table tbl_fasvc_opt
(fasvc_opt_no   nvarchar2(2)  not null
,fasvc_opt_desc nvarchar2(30) not null-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
,constraint PK_tbl_fasvc_opt_fasvc_opt_no primary key(fasvc_opt_no) 
);
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('0', '객실 내 어린이 돌보미(요금 별도)');
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('1', '시설 내 탁아 서비스(요금 별도)');
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('2', '키즈 클럽');
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('3', '어린이용 물품 제공');
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('4', '유모차');
insert into tbl_fasvc_opt(fasvc_opt_no, fasvc_opt_desc) values('5', '시설 내 놀이터');

select *
from tbl_fasvc_opt


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



        ------ >>> 숙박시설등록 테이블 만들기 끝 <<< ------

------- 다른 테이블 ------

create table tbl_host
(h_userid   varchar2(100) -- 판매자아이디 
,h_pw   varchar2(100)   not null -- 비밀번호
,h_name   varchar2(100)  not null -- 판매자명
,h_lodgename   varchar2(100) not null -- 사업장명       
,h_email    varchar2(100) not null -- 이메일
,h_mobile    varchar2(30) not null -- 연락처
,h_postcode   varchar2(5) not null -- 숙박시설우편번호
,h_address   varchar2(100) not null -- 숙박시설주소
,h_detailAddress   varchar2(100) not null -- 숙박시설상세주소
,h_extraAddress   varchar2(100) not null -- 숙박시설참고주소
,h_registerDate       date default sysdate not null -- 숙박시설등록일자
,h_lastpwdchangedate  date default sysdate -- 마지막으로 암호를 변경한 날짜
,h_status             number(1) default 0 not null -- 사업자승인유무  0 : 관리자승인 x / 1 : 관리자승인 o
,h_propType   NUMBER(1) not null -- 숙박시설유형
,h_roomCnt   NUMBER(5)  not null -- 객실개수
,h_legalName   varchar2(100) not null -- 숙박시설법인명
,h_businessNo   varchar2(12)  not null -- 사업자번호
,h_chainStatus   NUMBER(1) -- 0 : 체인 x / 1 : 체인 o
,constraint PK_tbl_host_h_userid primary key(h_userid)
);

insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('grandjusun@gmail.com','18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '박대감', '그랜드 조선 부산',
       'grandjusun@gmail.com', '02-721-1000', '48099', '부산 해운대구 해운대해변로 292','(해운대)',default,default,0,'(주)그랜드 조선 부산','102-83-25980')
commit
-- 객실테이블(tbl_room) insert 문 // 유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''

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
---- 다른 테이블

-- 메인이미지 seq_tbl_lg_img
-- 숙박시설사진 테이블    저장위치 src="<%= ctxPath%>/resources/image/${requestScope.img}"
create table tbl_lg_img
(lg_img_seq         number(9)      not null  -- 숙소이미지seq           / seq
,fk_lodge_id        Nvarchar2(10)  not null  -- 숙박시설ID              / PARA0001, GWGN0001, JESH0001
,lg_img_save_name   Nvarchar2(35)  not null  -- 내부에 저장될 이미지파일명  / -- 16자리 (년월일 시분초)  || 15자리
                                                                        -- 2023061212400259 || 243254235235234.png
                                                                        -- 2023112409291535 || 243254235235234.png
,lg_img_name        Nvarchar2(50)  not null  -- 이미지파일 실제 이름 /  이름(영문,한글도 괜찮음).png
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




create sequence seq_tbl_lg_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_name ,fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', 'JESH0001_6_01.png', '6');


-- <!-- // == 숙박시설 유형 테이블에서 select == // -->
SELECT lodge_type, lodge_content
FROM
(        
    select row_number() over(order by to_number(lodge_type) asc) rno, lodge_type, lodge_content
    from tbl_lodge_type
)
order by rno asc

-- <!-- // == 환불 정책 옵션 select == // -->
SELECT cancel_opt, cancel_opt_content
FROM
(        
    select row_number() over(order by to_number(cancel_opt) asc) rno, cancel_opt, cancel_opt_content
    from tbl_cancel
)
ORDER BY rno asc

-- 	<!-- // == 셀프 체크인 방법 select == // -->
select R.reservationSeq, M.userid, M.name, M.email, 
       to_char(R.reservationDate,'yyyy-mm-dd hh24:mi') as reservationDate
from tbl_member M join tbl_reservation R
on M.userid = R.fk_userid
where R.mailSendCheck = 0
and to_char(reservationDate, 'yyyy-mm-dd') = to_char(sysdate+2, 'yyyy-mm-dd');




-- <!-- // == 인터넷 옵션 체크박스 == // -->
SELECT inet_opt_no, inet_opt_desc
FROM
(        
    select row_number() over(order by to_number(inet_opt_no) asc) rno, inet_opt_no, inet_opt_desc
    from tbl_inet_opt
)
ORDER BY rno asc


-- <!-- // == 주차장 종류 select == // --> 
SELECT park_opt_no, park_opt_desc
FROM
(        
    select row_number() over(order by to_number(park_opt_no) asc) rno, park_opt_no, park_opt_desc
    from tbl_park_opt
)
ORDER BY rno asc




create table tbl_pool
(pool_seq        number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_pool_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_pool_pool_seq        primary key(pool_seq)
,constraint FK_tbl_pool_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_pool_fk_pool_opt_no  foreign key(fk_pool_opt_no) REFERENCES tbl_pool_opt(pool_opt_no)
);
-- <!-- // == 수영장 종류 체크박스 == // -->
SELECT pool_opt_no, pool_opt_desc
FROM
(        
    select row_number() over(order by to_number(pool_opt_no) asc) rno, pool_opt_no, pool_opt_desc
    from tbl_pool_opt
)
ORDER BY rno asc

create table tbl_pool_opt
(pool_opt_no   nvarchar2(2) not null
,pool_opt_desc nvarchar2(30) not null -- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
,constraint PK_tbl_pool_opt_pool_opt_no primary key(pool_opt_no) 
);


-- <!-- // == 스파 서비스 종류 셀렉트 == // -->
SELECT spa_type, spa_desc
FROM
(        
    select row_number() over(order by to_number(spa_type) asc) rno, spa_type, spa_desc
    from tbl_spa_type
)
ORDER BY rno asc



create table tbl_spa_type
(spa_type       Nvarchar2(2)        not null
,spa_desc       Nvarchar2(30)       not null
,constraint PK_tbl_spa_type_spa_type primary key(spa_type)
)



-- <!-- // == 다이닝 장소 select == // -->   
SELECT din_opt_no, din_opt_desc
FROM
(        
    select row_number() over(order by to_number(din_opt_no) asc) rno, din_opt_no, din_opt_desc
    from tbl_din_opt
)
ORDER BY rno asc



create table tbl_fac
(fac_seq       number(10)    not null
,fk_lodge_id   nvarchar2(10) not null
,fk_fac_opt_no nvarchar2(2)  not null
,constraint PK_tbl_fac_fac_seq         primary key(fac_seq)
,constraint FK_tbl_fac_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_fac_fk_fac_opt_no   foreign key(fk_fac_opt_no) REFERENCES tbl_fac_opt(fac_opt_no)
);

-- <!-- // == 장애인 편의 시설 정보 체크박스 == // -->
SELECT fac_opt_no, fac_opt_desc
FROM
(        
    select row_number() over(order by to_number(fac_opt_no) asc) rno, fac_opt_no, fac_opt_desc
    from tbl_fac_opt
)
ORDER BY rno asc
    
create table tbl_fac_opt
(fac_opt_no   nvarchar2(2)  not null
,fac_opt_desc nvarchar2(30) not null -- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
,constraint PK_tbl_fac_opt_fac_opt_no primary key(fac_opt_no) 
);


-- <!-- // == 고객서비스 종류 체크박스 == // -->
SELECT cs_opt_no, cs_opt_desc
FROM
(        
    select row_number() over(order by to_number(cs_opt_no) asc) rno, cs_opt_no, cs_opt_desc
    from tbl_cs_opt
)
ORDER BY rno asc


-- <!-- == 룸 서비스 종류 체크박스  == -->
SELECT rmsvc_opt_no, rmsvc_opt_desc
FROM
(        
    select row_number() over(order by to_number(rmsvc_opt_no) asc) rno, rmsvc_opt_no, rmsvc_opt_desc
    from tbl_rmsvc_opt
)
ORDER BY rno asc


-- <!-- // == 비즈니스 공간 종류 체크박스 == // -->
SELECT bsns_opt_no, bsns_opt_desc
FROM
(        
    select row_number() over(order by to_number(bsns_opt_no) asc) rno, bsns_opt_no, bsns_opt_desc
    from tbl_bsns_opt
)
ORDER BY rno asc



-- <!-- // == 가족서비스 종류 체크박스 == // -->
SELECT fasvc_opt_no, fasvc_opt_desc
FROM
(        
    select row_number() over(order by to_number(fasvc_opt_no) asc) rno, fasvc_opt_no, fasvc_opt_desc
    from tbl_fasvc_opt
)
ORDER BY rno asc


-- <!-- // === 숙박시설 등록 === // -->
insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, fk_spa_type
                    , lg_smoke_yn, lg_business_yn, lg_fa_travel_yn, lg_status)
values('숙박시설ID--SIRA0001, WTWQ1234', '사업자아이디--dodoh@naver.com', '숙박시설--신라호텔부평점', '호텔영문명--sin hotel busan', '우편번호--02134'
     , '주소--부산진구 가야대로 772','상세주소--null ', '참고항목--null', '지역위도--123.41235521251', '지역경도--55.2315234124'
     , '호텔등급--4성급','지역명--부산진구 ', '지역명2--가야대로', '숙박시설유형--4', '객실수--120'
     , '취소정책옵션번호--0','프런트데스크--0 ', '프런트데스크운영시간--없음', '셀프체크인방법--0', '체크인시간_시작--09:00 AM'
     , '체크인시간_마감--09:00 PM', '체크아웃 (가능)시간--10:00PM', '제한나이--2', '인터넷제공--0', '주차장--1'
     , '아침식사--1', '다이닝 장소--1', '수영장타입--1', '반려동물--1','반려동물 요금--30000'
     , '장애인 편의시설타입--1', '고객서비스--1', '객실 용품 및 서비스--0', '해변--1' ,'비즈니스--1'
     , '가족여행--1', '스파--1','흡연구역--0', '시설승인상태-default')
     
     
-- <!-- === tbl_inet에 입력되어 인터넷 옵션 가져오기 === -->
select inet_seq, fk_lodge_id, fk_inet_opt_no
from tbl_inet
where fk_lodge_id = 'JELC0003'


-- // === 등록 또는 수정하려는 fk_lodge_id로 tbl_inet테이블에 입력되어 있는 데이터 삭제하기 === //
delete from tbl_inet
where fk_lodge_id = 'JELC0003'

select *
from tbl_inet

-- <!-- 기존에 입력되어있는 lodge정보 가져오기 -->
select lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
     , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
     , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
     , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
     , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
     , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
     , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, fk_spa_type
     , lg_smoke_yn, lg_business_yn, lg_fa_travel_yn, lg_status
from tbl_lodge
where fk_h_userid ='lotteCityJeju@gmail.com'

-- <!-- Lodge 데이터 수정하기 -->
update tbl_lodge set lodge_id, lg_name, lg_en_name, lg_postcode
     , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
     , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
     , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
     , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
     , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
     , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, fk_spa_type
     , lg_smoke_yn, lg_business_yn, lg_fa_travel_yn, lg_statu
where fk_h_userid = 100;

-- <!-- tbl_park테이블 현재 주차장 옵션 insert -->
insert into tbl_park(park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, #{fk_lodge_id}, #{fk_park_opt_no})


-- <!
-- === tbl_din 테이블에 기존에 입력되어 있는 다이닝 종류 가져오기 === -->
select din_seq, fk_lodge_id, fk_din_opt_no
from tbl_din
where fk_lodge_id = ' '


-- <!-- 기존 tbl_din에 입력된 데이터 제거하기 -->
delete from tbl_din
where fk_lodge_id = #{fk_lodge_id}

-- <!-- 체크한 현재 다이닝 장소 종류 insert -->
insert into tbl_din(din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, #{fk_lodge_id}, #{fk_din_opt_no})


-- <!-- === tbl_pool 테이블에 기존에 입력되어 있는 수영장 정보 가져오기 === -->
select pool_seq, fk_lodge_id, fk_pool_opt_no, pool_use_time
from tbl_pool
where fk_lodge_id = #{fk_lodge_id}

-- <!-- // 기존에 	tbl_pool 테이블에 입력된 수영장 정보 제거하기 -->
delete from tbl_pool
where fk_lodge_id = #{fk_lodge_id}

-- <!-- // 체크한 현재 수영장 종류 insert -->
insert into tbl_pool(pool_seq, fk_lodge_id, fk_pool_opt_no, pool_use_time)
values(seq_tbl_pool.nextval, #{fk_lodge_id}, #{fk_pool_opt_no}, #{pool_use_time})

-- <!-- === tbl_fac 테이블에 기존에 입력되어 있는 장애인 편의시설 종류 가져오기 === -->
select fac_seq, fk_lodge_id, fk_fac_opt_no
from tbl_fac

-- <!-- 기존에 tbl_fac 테이블에 입력된 편의시설 정보 제거하기 -->
delete from tbl_fac
where fk_lodge_id = #{fk_lodge_id}

-- <!-- 현재 체크한 장애인 편의시설 종류 insert -->
insert into tbl_fac(fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, #{fk_lodge_id}, #{fk_fac_opt_no})


-- <!-- === tbl_cs 테이블에 기존에 입력되어 있는 고객서비스 종류 가져오기 === -->
select cs_seq, fk_lodge_id, fk_cs_opt_no
from tbl_cs
where fk_lodge_id = #{fk_lodge_id}

-- <!-- 기존에 tbl_cs 테이블에 입력된 고객서비스 정보 제거하기 -->
delete from tbl_cs
where fk_lodge_id = #{fk_lodge_id}

-- <!-- 현재 체크한 고객서비스 종류 insert -->
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, #{fk_lodge_id}, #{fk_cs_opt_no})


--	<!-- === tbl_rmsvc 테이블에 기존에 입력되어 있는 룸서비스 종류 가져오기 === -->
select rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no
from tbl_rmsvc
where fk_lodge_id = #{fk_lodge_id}

--	<!-- 기존에 tbl_rmsvc 테이블에 입력된 룸서비스 정보 제거하기 -->
delete from tbl_rmsvc
where fk_lodge_id = #{fk_lodge_id}

--	<!-- 현재 체크한 룸서비스 종류 insert -->
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, #{fk_lodge_id}, #{fk_rmsvc_opt_no})

select *
from tbl_fasvc_opt

select fascvc_seq, fk_lodge_id, fk_fasvc_opt_no
from tbl_fasvc

select *
from tbl_lodge
where fk_h_userid = 'JSUN0231'



-- host
select *
from tbl_host
where h_userid = 'grandjusun@gmail.com'

desc tbl_host

select *
from tbl_lodge

desc tbl_lodge


-- 입력 데이터 확인
select *
from tbl_host
where h_userid = 'grandjusun@gmail.com'

select *
from tbl_lodge
where fk_h_userid = 'grandjusun@gmail.com'


select *
from tbl_inet
where fk_lodge_id = 'JSUN0231'

select *
from tbl_park
where fk_lodge_id = 'JSUN0231'

select *
from tbl_din
where fk_lodge_id = 'JSUN0231'

select *
from tbl_pool
where fk_lodge_id = 'JSUN0231'

select *
from tbl_fac
where fk_lodge_id = 'JSUN0231'

select *
from tbl_cs
where fk_lodge_id = 'JSUN0231'

select *
from tbl_rmsvc
where fk_lodge_id = 'JSUN0231'

select *
from tbl_bsns
where fk_lodge_id = 'JSUN0231'

select *
from tbl_fasvc
where fk_lodge_id = 'JSUN0231'


-- <!-- DB에 입력되어 있는 숙박시설 ID 가져오기 -->
select lodge_id
from tbl_lodge
where lodge_id = 'JSUN0231'

select *
from tbl_lg_img_cate


-- <!-- === 이미지 등록하기 === -->
insert into tbl_lg_img(lg_img_seq, fk_lodge_id, fk_img_cano, lg_img_save_name, lg_img_name)
values(seq_tbl_lg_img.nextval, #{fk_lodge_id},#{fk_img_cano},#{lg_img_save_name},#{lg_img_name})

select *
from tbl_lg_img
order by lg_img_seq



--- 객실 등록 --------

-- seq_tbl_room / tbl_room seq


-- <!-- == 욕실 옵션 종류 == -->
SELECT bath_opt_no, bath_opt_desc
FROM
(        
    select row_number() over(order by to_number(bath_opt_no) asc) rno, bath_opt_no, bath_opt_desc
    from tbl_bath_opt
)
ORDER BY rno asc


-- <!-- == 주방(조리시설) 종류 == -->
SELECT kt_opt_no, kt_opt_desc
FROM
(        
    select row_number() over(order by to_number(kt_opt_no) asc) rno, kt_opt_no, kt_opt_desc
    from tbl_kt_opt
)
ORDER BY rno asc



-- <!-- == 객실 내 다과 옵션 종류 == -->
SELECT snk_opt_no, snk_opt_desc
FROM
(        
    select row_number() over(order by to_number(snk_opt_no) asc) rno, snk_opt_no, snk_opt_desc
    from tbl_snk_opt
)
ORDER BY rno asc


select rm_seq, fk_lodge_id, rm_type, rm_cnt, rm_size_feet
from tbl_room

select *
from tbl_room

delete from tbl_room
where fk_lodge_id = 'JSUN0231'
commit

select fk_h_userid, lodge_id
from tbl_lodge

select *
from tbl_room
where fk_lodge_id = 'JSUN0231'

select *
from tbl_bath
where fk_rm_seq = 'rm-44'

-- 채번 	
select seq_tbl_room.nextval AS rm_seq
from dual
	
--    
select lodge_id
from tbl_lodge
where fk_h_userid ='grandjusun@gmail.com';

select rm_seq, rm_type, fk_lodge_id
from tbl_room
where fk_lodge_id = 'JSUN0231';

select *
from tbl_bath
where fk_rm_seq = 'rm-45';

select *
from tbl_snack
where fk_rm_seq = 'rm-44';

select *
from tbl_kitchen
where fk_rm_seq = 'rm-44';

select *
from tbl_ent
where fk_rm_seq = 'rm-44';

select *
from tbl_tmp
where fk_rm_seq = 'rm-44';


select rm_type
from tbl_room
where fk_lodge_id = 'JSUN0231';

desc tbl_room

ALTER TABLE tbl_room MODIFY (RM_SIZE_PYUG nVARCHAR2(15));
ALTER TABLE tbl_room MODIFY (RM_SIZE_METER nVARCHAR2(15));

desc tbl_rm_img

select count(*)
from tbl_rm_img
select

select *
from tbl_rm_img
where fk_rm_seq = 'rm-30';

delete from tbl_rm_img
where fk_rm_seq = 'rm-46'
commit



SELECT V.RV_SEQ, V.FK_LODGE_ID, V.FK_RS_SEQ, V.FK_USERID, V.RV_SUBJECT, V.RV_CONTENT, V.RV_REGDATE, V.RV_STATUS, V.RV_GROUPNO, V.RV_ORG_SEQ, V.RV_DEPTHNO
     , V.FK_RV_RATING, T.RV_RATING_DESC, R.rs_checkinDate, R.rs_checkoutDate, H.h_lodgename
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
order siblings by RV_GROUPNO desc, RV_SEQ asc

select *
from tbl_lodge_type

select *
from tbl_lg_img

desc tbl_lodge
desc tbl_room

select *
from tbl_room

select *
from tbl_rm_img
where fk_rm_seq = 'rm-47'

select rm_img_name, rm_img_save_name, rm_img_main
from tbl_rm_img
where fk_rm_seq = 'rm-45'
order by rm_img_main desc, rm_img_seq 

commit
=======
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


>>>>>>> branch 'main' of https://github.com/dlgnswk/final_exp.git
