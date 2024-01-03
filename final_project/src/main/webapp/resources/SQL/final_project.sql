show user;
-- USER이(가) "FINAL_ORAUSER3"입니다.

select * from tab;

select *
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