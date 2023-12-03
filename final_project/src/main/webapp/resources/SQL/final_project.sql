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

alter table tbl_park
add park_content Nvarchar2(20);

-- 데이터 행 삭제
delete from tbl_park
where park_type >= 0


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


------------------ >>> 숙박시설등록 테이블 만들기 시작 <<< ------------------------  
        
         -------- >> 숙박시설 << --------
-- 숙박시설유형 테이블
create table tbl_lodge_type
(lodge_type     nvarchar2(1)   not null  -- 숙박시설유형 0,1,2,3,4,5
,lodge_content  nvarchar2(10)  not null  -- 숙박시설유형유형내용 
                                             -- 0:호텔 
                                             -- 1:모텔
                                             -- 2:아파트식호텔
                                             -- 3:콘도
                                             -- 4:호텔리조트
                                             -- 5:아파트
,constraint PK_tbl_lodge_type_lodge_type primary key(lodge_type)
)
-- Table TBL_LODGE_TYPE이(가) 생성되었습니다.
insert into tbl_lodge_type(lodge_type, lodge_content) values('0', '호텔');
insert into tbl_lodge_type(lodge_type, lodge_content) values('1', '모텔');
insert into tbl_lodge_type(lodge_type, lodge_content) values('2', '아파트식호텔');
insert into tbl_lodge_type(lodge_type, lodge_content) values('3', '콘도');
insert into tbl_lodge_type(lodge_type, lodge_content) values('4', '호텔리조트');
insert into tbl_lodge_type(lodge_type, lodge_content) values('5', '아파트');


-- 취소정책옵션_번호 테이블 
create table tbl_cancel
(cancel_opt             Nvarchar2(2)    not null  -- 취소정책옵션번호 / 0,1,2,3
,cancel_opt_content     Nvarchar2(30)   not null  -- 취소정책옵션내용
                                                     -- 0: 환불불가
                                                     -- 1: 24시간 이내 환불 불가 이전 50%
                                                     -- 2: 48시간 이내 환불 불가 이전 75%
                                                     -- 3: 72시간 이내 환불 불가 이전 100%
,constraint PK_tbl_cancel_cancel_opt primary key(cancel_opt)
)
-- Table TBL_CANCEL이(가) 생성되었습니다.
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('0', '환불불가');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('1', '24시간 이내 환불 불가 이전 50%');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('2', '48시간 이내 환불 불가 이전 75%');
insert into tbl_cancel(cancel_opt, cancel_opt_content) values('3', '72시간 이내 환불 불가 이전 100%');


-- 셀프체크인방법 테이블
create table tbl_checkin
(self_checkin           Nvarchar2(2)   not null  -- 셀프체크인방법 / 0,1,2,3,4,5
,self_checkin_content   Nvarchar2(20)  not null  -- 출입방법
                                                    -- 0: 셀프체크인불가
                                                    -- 1: 엑세스코드
                                                    -- 2: 키 수령 안내
                                                    -- 3: 록박스 이용 안내
                                                    -- 4: 스마트 록 코드
                                                    -- 5: 익스프레스 체크인
,self_checkin_info      Nvarchar2(30)  not null  -- 방법설명
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


-- 주차장 테이블
create table tbl_park
(park_type      Nvarchar2(1)    not null  -- 주차장타입 / 0,1,2
,park_content   Nvarchar2(10)    not null  -- 주차장내용 / 0:없음, 1:시설 내 외부 주차장, 2:시설 내 내부 주차장
,constraint PK_tbl_park_park_type primary key(park_type)
)
-- Table TBL_PARK이(가) 생성되었습니다.
insert into tbl_park(park_type, park_content) values('0', '없음');
insert into tbl_park(park_type, park_content) values('1', '시설 내 외부 주차장');
insert into tbl_park(park_type, park_content) values('2', '시설 내 내부 주차장');



-- 수영장 테이블
create table tbl_pool
(pool_type      Nvarchar2(1)   not null  -- 수영장타입 / 0,1,2
,pool_content   Nvarchar2(15)   not null  -- 수영장종류내용 / 0:없음, 1:야외, 2:실내
,constraint PK_tbl_pool_pool_type primary key(pool_type)
)
-- Table TBL_POOL이(가) 생성되었습니다.
insert into tbl_pool(pool_type, pool_content) values('0', '없음');
insert into tbl_pool(pool_type, pool_content) values('1', '야외 수영장');
insert into tbl_pool(pool_type, pool_content) values('2', '실내 수영장');



-- 다이닝장소종류 테이블
create table tbl_dining
(dine_place         Nvarchar2(1)   not null  -- 다이닝장소 / 0,1,2,3
,dine_place_name    Nvarchar2(15)  not null  -- 다이닝장소명 / 0:없음,  1: 레스토랑, 2:바, 3:커피숍 또는 카페
,constraint PK_tbl_dining_dine_place primary key(dine_place)
)
-- Table TBL_DINING이(가) 생성되었습니다.
insert into tbl_dining(dine_place, dine_place_name) values('0', '없음');
insert into tbl_dining(dine_place, dine_place_name) values('1', '레스토랑');
insert into tbl_dining(dine_place, dine_place_name) values('2', '바');
insert into tbl_dining(dine_place, dine_place_name) values('3', '커피숍 또는 카페');



-- 장애인 편의시설 테이블 tbl_facility fac_type
create table tbl_facility
(fac_type       Nvarchar2(1)   not null  -- 편의시설타입 0,1,2,3
,fac_content    Nvarchar2(40)  not null  -- 편의시설내용 
                                            -- 0: 없음
                                            -- 1: 휠체어만 있다.
                                            -- 2: 엘리베이터만 있다.
                                            -- 3: 둘 다 있다.
,constraint PK_tbl_facility_fac_type primary key(fac_type)
)
-- Table TBL_FACILITY이(가) 생성되었습니다.
insert into tbl_facility(fac_type, fac_content) values('0', '없음');
insert into tbl_facility(fac_type, fac_content) values('1', '휠체어만 있다');
insert into tbl_facility(fac_type, fac_content) values('2', '엘리베이터만 있다.');
insert into tbl_facility(fac_type, fac_content) values('3', '둘다 있다.');


desc tbl_pool;

select *
from tbl_pool

alter table tbl_pool
drop column pool_content;

alter table tbl_pool
add pool_content Nvarchar2(15);


-- 숙박시설등록 테이블
create table tbl_lodge
(lodge_id               Nvarchar2(10)       not null            -- 숙박시설ID / ex) SIRA0001, WTWQ1235
,host_userid            Nvarchar2(20)       not null            -- 사업자아이디 / 참조키를 넣어야함! 어디에? 숙박업자 판매자에 
,lg_name                Nvarchar2(20)       not null            -- 숙박시설 이름 / 
,lg_postcode            Nvarchar2(5)        not null            -- 우편번호 / 12345 02134 
,lg_address             Nvarchar2(50)       not null            -- 주소 
,lg_detailaddress       Nvarchar2(30)                           -- 상세주소
,lg_extraaddress        Nvarchar2(30)                           -- 참고항목 
,lg_latitude            Nvarchar2(20)       not null            -- 지역위도 / 123.41235521251
,lg_longitude           Nvarchar2(20)       not null            -- 지역경도 / 55.2315234124
,lg_area                Nvarchar2(10)       not null            -- 지역명 / 서울
,fk_lodge_type          Nvarchar2(1)        not null            -- 숙박시설유형 / 0,1,2,3,4,5
,lg_qty                 Nvarchar2(2)        not null            -- 객실수 / 숫자
,fk_cancel_opt          Nvarchar2(2)        not null            -- 취소정책옵션번호 / 0,1,2,3
,fd_status              Nvarchar2(2)        not null            -- 프런트데스크 / 0:없음, 1:있음
,fd_time                Nvarchar2(20)                           -- 프런트데스크운영시간 / 없음 or 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 or 24시간
,fk_self_checkin        Nvarchar2(2)        not null            -- 셀프체크인방법 / 0,1,2,3,4,5
,lg_checkin_time        Nvarchar2(10)       not null            -- 체크인시간(가능) / 시작시간 ~ 마감시간 예) 09:00 ~ 18:00
,lg_checkout_time       Nvarchar2(20)       not null            -- 체크아웃 (가능)시간 / 01:00 24:00 / 1시간 간격
,lg_age_limit           Nvarchar2(4)        not null            -- 제한나이 / <select>15~25<select> 부터 이용가능 
,lg_wifi                Nvarchar2(1)        not null            -- wifi제공 / 0:아니오, 1:예
,fk_park_type           Nvarchar2(1)        not null            -- 주차장 / 0:없음, 1:외부 주차장, 2:내부 주차장
,lg_breakfast           Nvarchar2(2)        not null            -- 아침식사 / 0:제공안됨, 1:제공됨
,fk_pool_type           Nvarchar2(1)        not null            -- 수영장타입 / 0,1,2
,lg_pool_time           Nvarchar2(10)       not null            -- 수영장운영시간 / 없음 or 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 or 24시간
,fk_dining_place        Nvarchar2(1)        not null            -- 다이닝 장소 / 0,1,2,3
,lg_spa_service         Nvarchar2(1)        not null            -- 스파 서비스 / 0:없음, 1:있음
,lg_pet_status          Nvarchar2(1)        not null            -- 반려동물 / 0:불가, 1:허용
,lg_pet_fare            Nvarchar2(10)       not null            -- 반려동물 요금 / 없음, 1마리당 요금 <input> ex) 30000
,fk_fac_type            Nvarchar2(1)        not null            -- 편의시설타입 / 0,1,2,3
,lg_smoke               Nvarchar2(1)        not null            -- 흡연구역 / 0:없음, 1:있음
,lg_baggage             Nvarchar2(1)        not null            -- 짐 보관 서비스 / 0:없음, 1:있음
,lg_locker              Nvarchar2(1)        not null            -- 사물함 이용 가능 / 0:없음, 1:있음
,lg_laundry             Nvarchar2(1)        not null            -- 세탁 시설 유무 / 0:없음, 1:있음
,lg_housekeep           Nvarchar2(1)        not null            -- 하우스키핑 서비스 유무 / 0:없음, 1:있음
-- 기본키 --
,constraint PK_tbl_lodge_lodge_id primary key(lodge_id)
-- 참조 제약 --
,constraint FK_tbl_lodge_fk_lodge_type foreign key(fk_lodge_type) references tbl_lodge_type(lodge_type)         -- 숙박시설유형 참조제약
,constraint FK_tbl_lodge_fk_cancel_opt foreign key(fk_cancel_opt) references tbl_cancel(cancel_opt)             -- 취소정책옵션_번호 참조제약
,constraint FK_tbl_lodge_fk_self_checkin foreign key(fk_self_checkin) references tbl_checkin(self_checkin)      -- 셀프체크인방법 참조제약
,constraint FK_tbl_lodge_fk_park_type foreign key(fk_park_type) references tbl_park(park_type)                  -- 주차장 참조제약
,constraint FK_tbl_lodge_fk_pool_type foreign key(fk_pool_type) references tbl_pool(pool_type)                  -- 수영장 참조제약
,constraint FK_tbl_lodge_fk_dining_place foreign key(fk_dining_place) references tbl_dining(dine_place)         -- 다이닝 장소 참조제약
,constraint FK_tbl_lodge_fk_fac_type foreign key(fk_fac_type) references tbl_facility(fac_type)                 -- 편의시설 참조제약
-- 체크 제약 -- 
,constraint CK_tbl_lodge_fd_status check( fd_status in('0','1') )               -- 프론트데스크 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_wifi check( lg_wifi in('0','1') )                   -- wifi제공 (0:아니오, 1:예) 체크제약
,constraint CK_tbl_lodge_fk_park_type check( fk_park_type in('0','1','2') )     -- 주차장 (0:없음, 1:외부 주차장, 2:내부 주차장) 체크제약
,constraint CK_tbl_lodge_lg_breakfast check( lg_breakfast in('0','1') )         -- 아침식사 (0:제공안됨, 1:제공됨) 체크제약
,constraint CK_tbl_lodge_lg_spa_service check( lg_spa_service in('0','1') )     -- 스파 서비스 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_pet_status check( lg_pet_status in('0','1') )       -- 반려동물 (0:불가, 1:허용) 체크제약
,constraint CK_tbl_lodge_lg_smoke check( lg_smoke in('0','1') )                 -- 흡연구역 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_baggage check( lg_baggage in('0','1') )             -- 짐 보관 서비스 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_locker check( lg_locker in('0','1') )               -- 사물함 이용 가능 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_laundry check( lg_laundry in('0','1') )             -- 세탁 시설 유무 (0:없음, 1:있음) 체크제약
,constraint CK_tbl_lodge_lg_housekeep check( lg_housekeep in('0','1') )         -- 하우스키핑 서비스 유무 (0:없음, 1:있음) 체크제약
-- 유니크 -- 
,constraint UQ_tbl_lodge_lg_name  unique(lg_name)  -- 숙박시설 이름 유니크 제약
)
-- Table TBL_LODGE이(가) 생성되었습니다.


-- 10 , 10 , 8, 6 / 5,5,7,7,8,2
insert into tbl_lodge(lodge_id, host_userid, lg_name, lg_postcode, lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area
                      , lg_area, fk_lodge_type, lg_qty, fk_cancel_opt, fd_status, fd_time, fk_self_checkin, lg_checkin_time, lg_age_limit, lg_wifi
                      , fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place, lg_spa_service, lg_pet_status, lg_pet_fare
                      , fk_fac_type, lg_smoke, lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('숙박시설ID-SIRA0001', '사업자아이디-123456789123', '숙박시설 이름-신라호텔', '우편번호-48266', '주소-부산광역시 수영구'
      , '상세주소-수영로 690-4', '참고항목-(광안동)', '지역위도-123.41235521251', '지역경도-55.2315234124', '지역명-부산광역시'
      , '숙박시설유형-0', '객실수-20', '취소정책옵션번호-0', '프런트데스크-1', '프런트데스크운영시간-09:00~18:00', '셀프체크인방법-2', '체크인시간-09:00 ~ 18:00'
      , '체크아웃-12:00', '제한나이-20', 'wifi제공-1', '주차장-2', '아침식사-0', '수영장타입-2', '수영장운영시간-09:00 ~ 18:00'
      , '다이닝 장소-3', '스파 서비스-0', '반려동물-1', '반려동물 요금-30000','편의시설타입-0' ,'흡연구역-1', '짐 보관 서비스-1', '사물함 이용 가능-0',
      , '세탁 시설 유무-0', '하우스키핑 서비스 유무-0');

'lodge_id-숙박시설ID-SIRA0001', 'host_userid-사업자아이디-123456789123(참조)', 'lg_name-숙박시설 이름-신라호텔(유니크)', 'lg_postcode-우편번호-02134'
,'lg_address-주소', 'lg_detailaddress-상세주소', 'lg_extraaddress-참고항목','lg_latitude-지역위도-123.41235521251','lg_longitude-지역경도-55.2315234124'
,'lg_area-지역명-서울'/* 10 */,'fk_lodge_type-숙박시설유형-0~5','lg_qty-객실수-숫자' ,'fk_cancel_opt-취소정책옵션번호-0,1,2,3', 'fd_status-프런트데스크-0,1'
,'fd_time-프런트데스크운영시간-없음 or 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 or 24시간', 'fk_self_checkin-셀프체크인방법-0,1,2,3,4,5'
,'lg_checkin_time-체크인시간-시작시간 ~ 마감시간 예) 09:00 ~ 18:00', 'lg_checkout_time-체크아웃-01:00 24:00 / 1시간 간격'
,'lg_age_limit-제한나이-15~20', 'lg_wifi-wifi제공-0,1'/*10*/, 'fk_park_type-주차장-0,1,2', 'lg_breakfast-아침식사-0,1', 'fk_pool_type-수영장타입-0,1,2'
,'lg_pool_time-수영장운영시간-없음 or 시작시간 ~ 마감시간 예) 09:00 ~ 18:00 or 24시간', 'fk_dining_place-다이닝 장소-0,1,2,3'
,'lg_spa_service-스파 서비스-0,1', 'lg_pet_status-반려동물-0,1', 'lg_pet_fare-반려동물 요금-없음, 1마리당 요금 <input> ex) 30000', 'fk_fac_type-편의시설타입-0,1,2,3'
,'lg_smoke-흡연구역-0,1'/*10*/, 'lg_baggage-짐 보관 서비스-0,1', 'lg_locker-사물함 이용 가능-0,1', 'lg_laundry-세탁 시설 유무-0,1', 'lg_housekeep-하우스키핑 서비스 유무-0,1'/*4*/


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
-- Table TBL_LG_IMG_CATE이(가) 생성되었습니다.
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('0', '시설외부');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('1', '공용구역');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('2', '수영장');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('3', '다이닝');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('4', '편의시설/서비스');
insert into tbl_lg_img_cate(img_cate_no, img_cate_name) values('5', '전망');



-- 숙박시설사진 테이블
create table tbl_lg_img
(lg_img_seq         number(9)      not null  -- 숙소이미지seq / seq
,fk_lodge_seq       Nvarchar2(10)  not null  -- 숙박시설ID / YDWW1102
,lg_img             Nvarchar2(50)  not null  -- 숙소이미지 / galsdkkalf.png
,fk_img_ca_id       Nvarchar2(1)             -- 숙소 카테고리 0,1,2,3,4,5
                                                 -- 0:시설외부
                                                 -- 1:공용구역
                                                 -- 2:수영장
                                                 -- 3:다이닝
                                                 -- 4:편의시설/서비스
                                                 -- 5:전망
,constraint PK_tbl_lg_img_lg_img_seq primary key(lg_img_seq)
,constraint FK_tbl_lg_img_fk_userid foreign key(fk_lodge_seq) references tbl_lodge(lodge_id) on delete cascade
,constraint FK_tbl_lg_img_cate_fk_img_caid foreign key(fk_img_ca_id) references tbl_lg_img_cate(img_cate_no)
)
-- Table TBL_LG_IMG이(가) 생성되었습니다.




        -------- >> 객실 << --------
-- 객실유형 테이블
create table tbl_room_type
(room_type          nvarchar2(2)   not null  -- 객실유형 / 0,1,2,3,4,5,6,7   
,room_type_name     nvarchar2(15)  not null  -- 객실유형명
                                                 -- 0: 이코노미
                                                 -- 1: 스탠다드
                                                 -- 2: 비즈니스
                                                 -- 3: 슈피리어
                                                 -- 4: 디럭스
                                                 -- 5: 패밀리
                                                 -- 6: 익스클루시브
                                                 -- 7: 이그제큐티브
,constraint PK_tbl_room_type_room_type primary key(room_type)
)
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



-- 객실정보 테이블
create table tbl_room
(room_seq               nvarchar2(15)       not null        -- 객실고유번호 / 시설번호 + 방호수(101)
,fk_lodge_num           nvarchar2(10)       not null        -- 시설번호 / tbl_lodge lodge_id 값 참조
,room_num               nvarchar2(5)        not null        -- 객실번호 / ex) 101호
,fk_room_type           nvarchar2(2)        not null        -- 객실유형 / 0,1,2,3,4,5,6,7
,fk_room_class          nvarchar2(2)        not null        -- 객실등급 / 0,1,2,3,4,5,6,7
,smoke_status           nvarchar2(1)        not null        -- 흡연유무 / 0:불가능, 1:가능
,sameroom_type_count    nvarchar2(2)        not null        -- 같은유형객실 개수 / 1 ~
,roomsize_feet          nvarchar2(4)        not null        -- 객실크기(제곱피트) / 1 ~
,roomsize_meter         nvarchar2(4)        not null        -- 객실크기(제곱미터) / 1 ~
,roomsize_pyug          nvarchar2(3)        not null        -- 객실크기(평) / 1~
,bath_count             nvarchar2(2)        not null        -- 욕실개수 / 1~
,add_bed_status         nvarchar2(1)        not null        -- 침대추가 가능여부 / 0:불가능, 1:가능
,lodge_max_inwon        nvarchar2(2)        not null        -- 숙박가능최대인원 / <select> 1~20
,lodge_price            nvarchar2(10)       not null        -- 숙박가격(1박 당) / ex) 70000
,single_bed             nvarchar2(2) default 0 not null     -- 싱글침대 / 1~
,supersingle_bed        nvarchar2(2) default 0 not null     -- 슈퍼싱글침대 / ~
,double_bed             nvarchar2(2) default 0 not null     -- 더블침대 / 1~
,queen_bed              nvarchar2(2) default 0 not null     -- 퀸사이즈침대 / 1~
,king_bed               nvarchar2(2) default 0 not null     -- 킹사이즈침대 / 1~
-- 기본키
,constraint PK_tbl_room_room_seq primary key(room_seq) -- 객실고유번호 기본키
-- 참조제약
,constraint FK_tbl_room_fk_lodge_num foreign key(fk_lodge_num) references tbl_lodge(lodge_id) on delete cascade -- 시설번호 참조제약
,constraint FK_tbl_room_fk_room_type foreign key(fk_room_type) references tbl_room_type(room_type) -- 객실유형 참조제약
,constraint FK_tbl_room_fk_room_class foreign key(fk_room_class) references tbl_room_class(room_class) -- 객실등급 참조제약
-- 체크제약
,constraint CK_tbl_room_smoke_status check( smoke_status in('0','1')) -- 흡연유무 체크제약
,constraint CK_tbl_room_add_bed_status check( add_bed_status in('0','1')) -- 침대추가 가능여부 체크제약
)
-- Table TBL_ROOM이(가) 생성되었습니다.


-- 객실 사진 테이블
create table tbl_room_img
(ro_img_seq         number(9)       not null    -- 객실이미지seq
,fk_room_seq        nvarchar2(15)   not null    -- 객실고유번호
,ro_img             nvarchar2(20)   not null    -- 객실이미지
,constraint PK_tbl_room_img_ro_img_seq primary key(ro_img_seq) -- ro_img_seq 기본키
,constraint FK_tbl_room_img_fk_room_seq foreign key(fk_room_seq) references tbl_room(room_seq) on delete cascade -- 참조제약
)
-- Table TBL_ROOM_IMG이(가) 생성되었습니다.


        ------ >>> 숙박시설등록 테이블 만들기 끝 <<< ------