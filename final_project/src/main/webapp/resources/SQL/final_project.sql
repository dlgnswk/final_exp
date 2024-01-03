show user;

select * from tab;


create table test_search
(nation     varchar2(10) -- 국가
,city       varchar2(10) -- 도시
,name       varchar2(30) -- 호텔명
);

 ALTER TABLE test_search MODIFY (city VARCHAR2(100));

insert into test_search(nation, city, name)
values('한국', '제주특별자치도 제주시', '제주롯데호텔');

insert into test_search(nation, city, name)
values('서울시', '서울시 송파구', '시그니엘');

update test_search set nation = '서울특별시'
where name = '서울롯데호텔';

commit;

select nation, city, name
from test_search
where lower(nation) like '%' || '신' || '%' OR 
      lower(city) like '%' || '신' || '%' OR 
      lower(name) like '%' || '신' || '%';

-- 전체 select
select *
from test_search;

-- 도시 검색된 갯수
select count(*)
from test_search
where lower(city) like '%' || lower('서') || '%';

-- 호텔 검색된 갯수
select count(*)
from test_search
where lower(name) like '%' || lower('서') || '%';

-- 검색된 도시 목록
select nation, city
from test_search
where lower(city) like '%' || lower('신') || '%';

-- 검색된 호텔 목록
select nation, city, name
from test_search
where lower(name) like '%' || lower('신') || '%';


/*

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
insert into tbl_facility(fac_type, fac_content) values('1', '경사로');
insert into tbl_facility(fac_type, fac_content) values('2', '엘리베이터');
insert into tbl_facility(fac_type, fac_content) values('3', '경사로, 엘리베이터');



-- 숙박시설등록 테이블
create table tbl_lodge
(lodge_id               Nvarchar2(10)       not null            -- 숙박시설ID / ex) SIRA0001, WTWQ1234
,host_userid            Nvarchar2(20)       not null            -- 사업자아이디 / 참조키를 넣어야함! 어디에? 숙박업자 판매자에 
,lg_name                Nvarchar2(40)       not null            -- 숙박시설 이름 / 
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
,lg_pet_fare            Nvarchar2(10)                           -- 반려동물 요금 / null, 1마리당 요금 <input> ex) 30000
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

*/
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

/*
insert into tbl_lg_img(lg_img_seq, fk_lodge_seq, lg_img, fk_img_ca_id) 
values('숙소이미지.1', '숙박시설ID-YDWW1102', '숙소이미지-galsdkkalf.png', '숙소 카테고리-0');

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


메인이미지
-- 숙박시설사진 테이블    저장위치 src="<%= ctxPath%>/resources/image/${requestScope.img}"
create table tbl_lg_img
(lg_img_seq         number(9)      not null  -- 숙소이미지seq / seq
,fk_lodge_seq       Nvarchar2(10)  not null  -- 숙박시설ID    / PARA0001
,lg_img_path        Nvarchar2(50)  not null  -- 숙소이미지    / 
,lg_img_name        Nvarchar2(50)  not null  -- 숙소이미지    / GWGN0001_0_01.png, JESH0001_5_21.png
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

create sequence seq_tbl_bsns
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



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

*/


-- 숙소 등록 insert 문 예시
insert into tbl_lodge(lodge_id, host_userid, lg_name, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area,
                      fk_lodge_type, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('숙박시설ID-SIRA0001', '사업자아이디-123456789123', '숙박시설 이름-신라호텔', '우편번호-48266', '주소-부산광역시 수영구',
       '상세주소-수영로 690-4', '참고항목-(광안동)', '지역위도-123.41235521251', '지역경도-55.2315234124', '지역명-부산광역시',
       '숙박시설유형-0', '객실수-20', '취소정책옵션번호-0', '프런트데스크-1', '프런트데스크운영시간-09:00~18:00',
       '셀프체크인방법-2', '체크인시간-09:00 ~ 18:00','체크아웃-12:00', '제한나이-20','wifi제공-1',
       '주차장-2', '아침식사-0', '수영장타입-2', '수영장운영시간-09:00 ~ 18:00','다이닝 장소-3',
       '스파 서비스-0', '반려동물-1', '반려동물 요금-30000','편의시설타입-0' ,'흡연구역-1',
       '짐 보관 서비스-1', '사물함 이용 가능-0','세탁 시설 유무-0', '하우스키핑 서비스 유무-0');

-- 지역명2 추가
ALTER TABLE tbl_lodge ADD lg_area_2 Nvarchar2(10) not null;
lg_area                Nvarchar2(10)       not null            -- 지역명 / 서울

insert into tbl_lodge(lodge_id, host_userid, lg_name, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area, lg_area_2,
                      fk_lodge_type, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('숙박시설ID-SIRA0001', '사업자아이디-123456789123', '숙박시설 이름-신라호텔', '우편번호-48266', '주소-부산광역시 수영구',
       '상세주소-수영로 690-4', '참고항목-(광안동)', '지역위도-123.41235521251', '지역경도-55.2315234124', '지역명-부산광역시', '지역명2-수영구',
       '숙박시설유형-0', '객실수-20', '취소정책옵션번호-0', '프런트데스크-1', '프런트데스크운영시간-09:00~18:00',
       '셀프체크인방법-2', '체크인시간-09:00 ~ 18:00','체크아웃-12:00', '제한나이-20','wifi제공-1',
       '주차장-2', '아침식사-0', '수영장타입-2', '수영장운영시간-09:00 ~ 18:00','다이닝 장소-3',
       '스파 서비스-0', '반려동물-1', '반려동물 요금-30000','편의시설타입-0' ,'흡연구역-1',
       '짐 보관 서비스-1', '사물함 이용 가능-0','세탁 시설 유무-0', '하우스키핑 서비스 유무-0');

-- 숙박시설 추가
insert into tbl_lodge(lodge_id, host_userid, lg_name, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area, lg_area_2,
                      fk_lodge_type, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('숙박시설ID-SIRA0001', '사업자아이디-123456789123', '숙박시설 이름-신라호텔', '우편번호-48266', '주소-부산광역시 수영구',
       '상세주소-수영로 690-4', '참고항목-(광안동)', '지역위도-123.41235521251', '지역경도-55.2315234124', '지역명-부산광역시', '지역명2-수영구',
       '숙박시설유형-0', '객실수-20', '취소정책옵션번호-0', '프런트데스크-1', '프런트데스크운영시간-09:00~18:00',
       '셀프체크인방법-2', '체크인시간-09:00 ~ 18:00','체크아웃-12:00', '제한나이-20','wifi제공-1',
       '주차장-2', '아침식사-0', '수영장타입-2', '수영장운영시간-09:00 ~ 18:00','다이닝 장소-3',
       '스파 서비스-0', '반려동물-1', '반려동물 요금-30000','편의시설타입-0' ,'흡연구역-1',
       '짐 보관 서비스-1', '사물함 이용 가능-0','세탁 시설 유무-0', '하우스키핑 서비스 유무-0');


select *
from tbl_lodge;

create table tbl_irs (
    i_legalName     varchar2(100)   not null,    -- 국세청에 등록된 법인명
    i_name          varchar2(100)   not null,    -- 국세청에 등록된 대표자명
    i_businessNo    Nvarchar2(12)   not null,   -- 국세청에 등록된 사업자번호  '000-00-00000' 형식으로 입력
    constraint PK_tbl_irs_i_legalName primary key(i_legalName)
);

insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_detailAddress,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_propType,h_roomCnt,h_legalName,h_businessNo,h_chainStatus)
values('paradise743@gmail.com','qwer1234!', '최종환', '파라다이스 시티 호텔', 'host743@gmail.com', '010-4564-7897', '22382', '인천광역시 중구 영종해안남로 321번길 186','파라다이스 시티 호텔','(운서동)',default,default,default,1,711,'㈜파라다이스','121-86-18441',1)

select *
from tbl_lodge

desc tbl_lodge

select *
from tbl_irs

select *
from tbl_host

-------------////////////////////////////// 제주도 호텔 insert 시작 //////////////////////////////-------------
-- 제주신라호텔
-- irs

-- host
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('shillaJeju@gmail.com','18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '이부진', '제주신라호텔', 'shillaJeju@gmail.com', '064-735-5114', '04605', '서울특별시 중구 동호로 249','(장충동2가)',default,default,0,'(주)호텔신라','203-81-43363')

-- lodge
insert into tbl_lodge(lodge_id, fk_host_userid, lg_name, lg_en_name, lg_hotel_star, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area, lg_area_2,
                      fk_lodge_type, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('JESH0001', 'shillaJeju@gmail.com', '제주신라호텔', 'The Shilla Jeju', '5', '63535', '제주특별자치도 서귀포시 중문관광로72번길 75',
       '제주신라호텔', '(색달동)', '33.2477376', '126.4081697', '제주특별자치도', '서귀포시',
       '0', '45', '2', '1', '24시간',
       '0', '14:00 ~ 00:00','11:00', '19','1',
       '1', '1', '1', '09:00 AM ~ 00:00 AM','1',
       '1', '0', '없음', '3','0',
       '1', '0','1', '1');


-- 히든 클리프 호텔&네이쳐
-- irs


-- host
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('hiddenCliff@gmail.com','18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '이병혁', '히든 클리프 호텔&네이쳐', 'hiddenCliff@gmail.com', '064-752-7777', '63536', '제주특별자치도 서귀포시 예래해안로 542','(상예동)',default,default,0,'예래클리프개발(주)','616-81-98536')

-- lodge
insert into tbl_lodge(lodge_id, fk_host_userid, lg_name, lg_en_name, lg_hotel_star, lg_postcode, lg_address,
                      lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude, lg_area, lg_area_2,
                      fk_lodge_type, lg_qty, fk_cancel_opt, fd_status,fd_time,
                      fk_self_checkin, lg_checkin_time, lg_checkout_time, lg_age_limit, lg_wifi,
                      fk_park_type, lg_breakfast, fk_pool_type, lg_pool_time, fk_dining_place,
                      lg_spa_service, lg_pet_status, lg_pet_fare, fk_fac_type, lg_smoke,  
                      lg_baggage, lg_locker, lg_laundry, lg_housekeep)
values('JEHI0001', 'hiddenCliff@gmail.com', '히든 클리프 호텔&네이쳐', 'Hidden Cliff Hotel & Nature', '4', '63536', '제주특별자치도 서귀포시 예래해안로 542',
       '히든 클리프 호텔&네이쳐', '(상예동)', '33.2547291', '126.4024804', '제주특별자치도', '서귀포시',
       '4', '15', '2', '1', '24시간',
       '0', '15:00 ~ 00:00','11:00', '19','1',
       '2', '1', '1', '09:00 AM ~ 22:00 PM','1',
       '0', '0', '없음', '3' ,'0',
       '1', '0','0', '1');


commit;
-------------////////////////////////////// 제주도 호텔 insert  끝 //////////////////////////////-------------

alter table tbl_lodge
add constraint FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid);

ALTER TABLE tbl_lodge ADD CONSTRAINT FK_tbl_lodge_fk_h_userid foreign key(fk_h_userid) references tbl_host(h_userid);

select *
from tbl_host

commit;

------ ///////////////////////// 데이터 넣기 ///////////////////////// -----
/*
** 장애인 편의 시설 - 객실 내 (택1)
옵션0 => 없음
옵션1 => 있음  -- 객실 내 장애인 편의 시설(일부 객실에서 이용 가능)
*/
create table tbl_bf
(bf_type        Nvarchar2(1)    not null  -- 장애인편의시설타입 0,1,2
,bf_content     Nvarchar2(40)   not null  -- 장애인편의시설내용 
                                            -- 0: 없음
                                            -- 1: 있음 => 객실 내 장애인 편의 시설(일부 객실에서 이용 가능)
,constraint PK_tbl_bf_bf_type primary key(bf_type)
);
insert into tbl_bf(bf_type, bf_content) values('0', '없음');
insert into tbl_bf(bf_type, bf_content) values('1', '객실 내 장애인 편의 시설(일부 객실에서 이용 가능)');



/*
** 장애인 편의 시설 - 공용 구역 (없음 외 중복 가능)
옵션0 => 없음
옵션1 => 시설 내 휠체어
옵션2 => 휠체어 이용 가능한 엘리베이터
옵션3 => 장애인 주차 공간
옵션4 => 입구에 경사로 있음
*/
create table tbl_fac
(fac_type       Nvarchar2(1)   not null  -- 편의시설타입 0,1,2,3,4
,fac_content    Nvarchar2(40)  not null  -- 편의시설내용 
                                            -- 0: 없음
                                            -- 1: 시설 내 휠체어
                                            -- 2: 휠체어 이용 가능한 엘리베이터
                                            -- 3: 장애인 주차 공간
                                            -- 3: 입구에 경사로 있음
,constraint PK_tbl_fac_fac_type primary key(fac_type)
)
-- Table TBL_FACILITY이(가) 생성되었습니다.
insert into tbl_fac(fac_type, fac_content) values('0', '없음');
insert into tbl_fac(fac_type, fac_content) values('1', '시설 내 휠체어');
insert into tbl_fac(fac_type, fac_content) values('2', '휠체어 이용 가능한 엘리베이터');
insert into tbl_fac(fac_type, fac_content) values('3', '장애인 주차 공간');
insert into tbl_fac(fac_type, fac_content) values('4', '입구에 경사로 있음');

/*
** 장애인 편의 시설 - 공용 구역 (없음 외 중복 가능) 참조테이블
*/
create table tbl_fac_opt
(facSeq         number(20)    -- PrimaryKey
,fk_lodge_id    Nvarchar2(10)
,fk_fac_type    Nvarchar2(2)
,constraint PK_tbl_fac_opt_facSeq primary key (facSeq)
,constraint FK_tbl_fac_opt_fk_lodge_id foreign key(fk_lodge_id) references tbl_lodge(lodge_id);
,constraint FK_tbl_fac_opt_fk_fac_type foreign key(fk_fac_type) references tbl_fac(fk_fac_type);
);



create table tbl_park_opt
(parkSeq       number(20)    -- PrimaryKey
,fk_lodge_id   Nvarchar2(10)
,park_opt_no  Nvarchar2(2)
,constraint PK_tbl_park_opt_parkSeq primary key (parkSeq)
,constraint FK_tbl_park_opt_fk_lodge_id foreign key(fk_lodge_id) references tbl_lodge(lodge_id);
);

create table tbl_park_opt
(parkSeq       number(20)    -- PrimaryKey
,fk_lodge_id   Nvarchar2(10)
,park_opt_no  Nvarchar2(2)
,constraint PK_tbl_park_opt_parkSeq primary key (parkSeq)
,constraint FK_tbl_park_opt_fk_lodge_id foreign key(fk_lodge_id) references tbl_lodge(lodge_id);
);


------ ///////////////////////// 데이터 넣기 ///////////////////////// -----








-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-------- ***** >>>> 객실(room) 관련 테이블 & 시퀀스 생성 시작!! <<<< ***** --------
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

,fk_cancel_opt          Nvarchar2(2)        not null            -- 취소정책옵션번호 / 0,1,2,3
                                                                      -- 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
                                                                      -- 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
                                                                      -- 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
                                                                      -- 3 : 체크인 1시간 이전 : 100% 환불가능
,fd_status              Nvarchar2(2)        not null            -- 프런트데스크 / 0:없음, 1:있음
,fd_time                Nvarchar2(30)                           -- 프런트데스크운영시간 / '없음' or '09:00 AM ~ 09:00 PM' or '24시간'
,fk_s_checkin_type      Nvarchar2(2)        not null            -- 셀프체크인방법 / 0:없음, 1:있음 --> 이후 체크박스 선택
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


create table tbl_view
(view_no nvarchar2(2)    not null -- 전망_옵션
,view_desc nvarchar2(30) not null -- 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망
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
,snk_opt_desc nvarchar2(30)  not null-- 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 라운지 이용
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

SET ESCAPE ON;
show escape

-- 장애인 편의시설 설명
create table tbl_fac_opt
(fac_opt_no   nvarchar2(2)  not null
,fac_opt_desc nvarchar2(30) not null -- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
,constraint PK_tbl_fac_opt_fac_opt_no primary key(fac_opt_no) 
);
insert into tbl_fac_opt(fac_opt_no, fac_opt_desc) values('0','시설 내 휠체어');
insert into tbl_fac_opt(fac_opt_no, fac_opt_desc) values('1','휠체어 이용 가능한 엘리베이터');
insert into tbl_fac_opt(fac_opt_no, fac_opt_desc) values('2','장애인 주차 공간');
insert into tbl_fac_opt(fac_opt_no, fac_opt_desc) values('3','입구에 경사로 있음');
commit;
-- 커밋 완료.

-- 고객서비스 설명
create table l
(cs_opt_no   nvarchar2(2)  not null
,cs_opt_desc nvarchar2(30) not null -- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 
                                    -- 5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
,constraint PK_tbl_cs_opt_cs_opt_no primary key(cs_opt_no) 
);
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('0','짐 보관 서비스');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('1','사물함 이용가능');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('2','세탁시설 있음');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('3','드라이클리닝/세탁 서비스');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('4','콘시어지 서비스');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('5','24시간 운영 프런트 데스크');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('6','다국어 안내 서비스');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('7','하우스키핑 매일 제공');
insert into tbl_cs_opt(cs_opt_no, cs_opt_desc) values('8','식료품점/편의점');
commit;
-- 커밋 완료.

-- 객실용품 서비스 설명
create table tbl_rmsvc_opt
(rmsvc_opt_no   nvarchar2(2)  not null
,rmsvc_opt_desc nvarchar2(30) not null -- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터
                                       -- 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
,constraint PK_tbl_rmsvc_opt_rmsvc_opt_no primary key(rmsvc_opt_no) 
);
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('0','식사 배달 서비스 이용가능');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('1','객실 내 마사지 서비스');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('2','다리미/다리미판');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('3','객실 금고');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('4','컴퓨터 모니터');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('5','프린터');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('6','전화');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('7','슬리퍼');
insert into tbl_rmsvc_opt(rmsvc_opt_no, rmsvc_opt_desc) values('8','객실 내 세탁시설');
commit;
-- 커밋 완료.

create table tbl_bsns_opt
(bsns_opt_no   nvarchar2(2)  not null
,bsns_opt_desc nvarchar2(30) not null -- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
,constraint PK_tbl_bsns_opt_bsns_opt_no primary key(bsns_opt_no)
);

create table tbl_fasvc_opt
(fasvc_opt_no   nvarchar2(2)  not null
,fasvc_opt_desc nvarchar2(30) not null -- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
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
-- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 
-- 5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '0');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '2');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '3');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '4');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '5');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '7');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'GWGN0001', '8');
commit;
-- 커밋 완료.

create table tbl_rmsvc
(rmsvc_seq       number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_rmsvc_opt_no nvarchar2(2)  not null
,constraint PK_tbl_rmsvc_rmsvc_seq        primary key(rmsvc_seq)
,constraint FK_tbl_rmsvc_fk_lodge_id      foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_rmsvc_fk_rmsvc_opt_no  foreign key(fk_rmsvc_opt_no) REFERENCES tbl_rmsvc_opt(rmsvc_opt_no)
);
-- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터
-- 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '2');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '3');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '6');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'GWGN0001', '7');
commit;
-- 커밋 완료.

create table tbl_bsns
(bsns_seq        number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_bsns_opt_no  nvarchar2(2)  not null
,constraint PK_tbl_bsns_bsns_seq        primary key(bsns_seq)
,constraint FK_tbl_bsns_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_bsns_fk_bsns_opt_no  foreign key(fk_bsns_opt_no) REFERENCES tbl_bsns_opt(bsns_opt_no)
);
-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'GWGN0001', '1');
commit;
-- 커밋 완료.

create table tbl_fasvc
(fascvc_seq      number(10)    not null
,fk_lodge_id     nvarchar2(10) not null
,fk_fasvc_opt_no nvarchar2(2)  not null
,constraint PK_tbl_fasvc_fascvc_seq      primary key(fascvc_seq)
,constraint FK_tbl_fasvc_fk_lodge_id     foreign key(fk_lodge_id) REFERENCES tbl_lodge(lodge_id)
,constraint FK_tbl_fasvc_fk_fasvc_opt_no foreign key(fk_fasvc_opt_no) REFERENCES tbl_fasvc_opt(fasvc_opt_no)
);
-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'GWGN0001', '1');
commit;
-- 커밋 완료.

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

-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--얘들아 tbl_lodge 입력 후 옵션 넣을 때 참고!!!
--맨윗줄 -> <제목> 테이블명
--2번째줄 -> 옵션번호 : 설명
--3번째줄 -> insert 문 예시
--
--<인터넷> tbl_inet
--0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
--insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
--values(seq_tbl_inet.nextval, 'GWGN0001','0');
--
--<주차장> tbl_park
--0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
--insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
--values(seq_tbl_park.nextval, 'GWGN0001','0');
--
--<다이닝> tbl_din
--0 : 레스토랑 / 1 : 카페 / 2 : 바
--insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
--values(seq_tbl_din.nextval, 'GWGN0001','0');
--
--<수영장> tbl_pool
--0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
--insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)values(seq_tbl_pool.nextval, 'GWGN0001','0');
--
--<장애인편의시설> tbl_fac
--0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
--insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
--values(seq_tbl_fac.nextval, 'GWGN0001','0');
--
--<고객서비스> tbl_ cs
--0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
--insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
--values(seq_tbl_cs.nextval, 'GWGN0001', '0');
--
--<객실서비스> tbl_rmsvc
--0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
--insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
--values(seq_tbl_rmsvc.nextval, 'GWGN0001', '2');
--
--<비즈니스> tbl_bsns
--0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
--insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
--values(seq_tbl_bsns.nextval, 'GWGN0001', '1');
--
--<가족여행> tbl_fasvc
--0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
--insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
--values(seq_tbl_fasvc.nextval, 'GWGN0001', '1');


select lg_fa_travel_yn from tbl_lodge

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('숙박시설ID--SIRA0001, WTWQ1234', '사업자아이디--dodoh@naver.com', '숙박시설--신라호텔부평점', '호텔영문명--sin hotel busan', '우편번호--02134'
     , '주소--부산진구 가야대로 772','상세주소--null ', '참고항목--null', '지역위도--123.41235521251', '지역경도--55.2315234124'
     , '호텔등급--4성급','지역명--부산진구 ', '지역명2--가야대로', '숙박시설유형--4', '객실수--120'
     , '취소정책옵션번호--0','프런트데스크--0 ', '프런트데스크운영시간--없음', '셀프체크인방법--0', '체크인시간_시작--09:00 AM'
     , '체크인시간_마감--09:00 PM', '체크아웃 (가능)시간--10:00PM', '제한나이--2', '인터넷제공--0', '주차장--1'
     , '아침식사--1', '다이닝 장소--1', '수영장타입--1', '반려동물--1','반려동물 요금--30000'
     , '장애인 편의시설타입--1', '고객서비스--1', '객실 용품 및 서비스--0', '해변--1' ,'비즈니스--1'
     , '가족여행--1', '스파--1','흡연구역--0', '짐 보관 서비스--0', '사물함 이용 가능--0'
     , '세탁 시설 유무--0', '하우스키핑 서비스 유무--0', '시설승인상태-default')

desc tbl_lodge

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


-- <<< 객실테이블(tbl_room) INSERT 문 예시 >>>
-- 객실테이블(tbl_room) insert 문 // 유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''
insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
                , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval<--이건 고정으로 건들지 말기!!, 'fk_시설id', '객실이름', '침실개수', '흡연유무'
       , '객실크기(제곱미터)-숫자만', '객실크기(평)-소수점1자리까지', '침대 추가 가능여부'
       , '싱글침대 개수-없으면 공백(null)', '슈퍼싱글침대 개수', '더블침대 개수', '퀸사이즈침대 개수', '킹사이즈침대 개수'
       , '휠체어이용가능 유무', '전용욕실갯수-없으면0', '공용욕실유무', '주방(조리시설)유무', 'fk_전망옵션'
       , '객실 내 다과 유무', '객실 내 엔터테인먼트 유무', '온도조절기 유무', '투숙가능인원', '숙박요금', '조식포함 유무');

select * from tbl_room

<<< 객실테이블(tbl_room) 입력 후 옵션테이블 입력 예시 >>>

<욕실> tbl_bath
0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-2', '0');

<주방> tbl_kitchen
0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료
insert into tbl_kitchen(kt_seq, fk_rm_seq, fk_kt_opt_no) values(seq_tbl_kitchen.nextval, rm-2, '0');

<객실내다과> tbl_snack
0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 라운지 이용
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-2', '0');

<객실내엔터> tbl_ent
0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-2', '0');

<온도조절기> tbl_tmp
0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-2', '0');


select * from tbl_lodge

select * from tbl_lg_img_cate

-- 메인이미지
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

-- 16자리 (년월일 시분초)  || 15자리
-- 2023061212400259 243254235235234
-- 2023112409291535 243254235235234
-- Table TBL_LG_IMG이(가) 생성되었습니다.

create sequence seq_tbl_lg_img
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_lg_img

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', '2023121412400259' || '243254235235234.png', '01_메인.png', '6');
insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', '2023121412400259' || '243254235235235.png', '02_메인.png', '6');
insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', '2023121412400259' || '243254235235236.png', '03_메인.png', '6');
insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', '2023121412400259' || '243254235235244.png', '04_메인.png', '6');
insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JESH0001', '2023121412400259' || '243254235235254.png', '05_메인.png', '6');

commit;

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

select lodge_id, fk_h_userid, lg_name, lg_status
from tbl_lodge
where lodge_id = 'JESH0001';

update tbl_lodge set lg_status = '1'
where lodge_id = 'JESH0001';

commit;

select h_userid
from tbl_host

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('JESH0001', 'shillaJeju@gmail.com', '제주신라호텔', 'The Shilla Jeju',  '63535',
       '제주특별자치도 서귀포시 중문관광로72번길 75', '제주신라호텔', '(색달동)', '33.2477376', '126.4081697',
       '5', '제주특별자치도', '서귀포시', '0', '429',
       '0', '1', '24시간', '0', '14:00 PM',
       '00:00 AM', '11:00 AM', '19', '1', '1',
       '1', '1', '1', '0', null,
       '1', '1', '1', '1', '1',
       '1', '1', '0', '1', '0',
       '1', '1', default);
commit;

-- 인터넷:1, 주차장:1, 저녁장소:1, 수영장:1, 장애인:1, 고객:1, 객실:1, 비즈니스:1, 가족:1
-- <인터넷> tbl_inet
-- 0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JESH0001','0');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JESH0001','1');
commit;

-- <주차장> tbl_park
-- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JESH0001','0');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JESH0001','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JESH0001','3');
commit;

-- <다이닝> tbl_din
-- 0 : 레스토랑 / 1 : 카페 / 2 : 라운지
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JESH0001','0');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JESH0001','1');
commit;

-- <수영장> tbl_pool
-- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'JESH0001','0');
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'JESH0001','1');
commit;

-- <장애인편의시설> tbl_fac
-- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JESH0001','0');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JESH0001','1');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JESH0001','2');
commit;

-- <고객서비스> tbl_ cs
-- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '0');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '2');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '3');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '4');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '5');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '6');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JESH0001', '7');
commit;

-- <객실서비스> tbl_rmsvc
-- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JESH0001', '3');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JESH0001', '6');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JESH0001', '7');
commit;

-- <비즈니스> tbl_bsns
-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JESH0001', '0');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JESH0001', '1');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JESH0001', '3');
commit;

-- <가족여행> tbl_fasvc
-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '3');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '4');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '6');
commit;

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
insert into tbl_host(h_userid,h_pw,h_name,h_lodgename,h_email,h_mobile,h_postcode,h_address,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo)
values('lotteCityJeju@gmail.com','18006e2ca1c2129392c66d87334bd2452c572058d406b4e85f43c1f72def10f5', '김태홍', '롯데시티호텔 제주', 'lotteCityJeju@gmail.com', '02-771-1000', '63536', '서울특별시 중구 을지로 30','(소공동)',default,default,0,'(주)호텔롯데','104-81-25980')

commit;
select h_userid,h_mobile,h_postcode,h_address,h_extraAddress,h_registerDate,h_lastpwdchangedate,h_status,h_legalName,h_businessNo
from tbl_host;

desc tbl_lodge;

update tbl_lodge set lg_fa_travel_yn = '0' where lodge_id = 'JELC0003'

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_status)
values('JELC0003', 'lotteCityJeju@gmail.com', '롯데시티호텔 제주', 'Lotte City Hotel Jeju',  '63127',
       '제주특별자치도 제주시 도령로 83', '롯데시티호텔 제주', '(연동)', '33.4905955', '126.4864277',
       '4', '제주특별자치도', '제주시', '0', '255',
       '0', '1', '24시간', '0', '15:00 PM',
       '00:00 AM', '12:00 PM', '19', '1', '1',
       '1', '1', '1', '0', null,
       '1', '1', '1', '0', '1',
       '0', '0', '0', default);
commit;

-- 인터넷:1, 주차장:1, 저녁장소:1, 수영장:1, 장애인:1, 고객:1, 객실:1, 비즈니스:1, 가족:1
-- <인터넷> tbl_inet
-- 0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JELC0003','0');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JELC0003','1');
commit;

-- <주차장> tbl_park
-- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JELC0003','0');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JELC0003','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JELC0003','3');
commit;

-- <다이닝> tbl_din
-- 0 : 레스토랑 / 1 : 카페 / 2 : 라운지
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JELC0003','0');
commit;

-- <수영장> tbl_pool
-- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'JELC0003','2');
commit;

-- <장애인편의시설> tbl_fac
-- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JELC0003','1');
commit;

-- <고객서비스> tbl_ cs
-- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '0');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '2');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '3');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '4');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '5');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '6');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JELC0003', '7');
commit;

-- <객실서비스> tbl_rmsvc
-- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JELC0003', '3');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JELC0003', '6');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JELC0003', '7');
commit;

-- <비즈니스> tbl_bsns
-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JELC0003', '0');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JELC0003', '1');
commit;

-- <가족여행> tbl_fasvc
-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '3');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '4');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JESH0001', '6');
commit;

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

select * from tbl_room;

-- 1. 산전망 스탠다드 더블룸 <유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''><fk_view_no 전망 ==> 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망>
insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
       , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval, 'JESH0001', '산전망 스탠다드 더블 룸', '1', '0'
       , '40', '12', '1'
       , null, null, null, '1', null
       , '0', '1', '0', '0', '2'
       , '1', '1', '1', '4', '550000', '0');
commit;

-- <욕실> tbl_bath ==> 0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '5');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-17', '6');

-- <주방> tbl_kitchen ==> 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료

-- <객실내다과> tbl_snack ==> 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 라운지 이용
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-17', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-17', '1');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-17', '2');

-- <객실내엔터> tbl_ent ==> 0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-17', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-17', '1');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-17', '2');

-- <온도조절기> tbl_tmp ==> 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-17', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-17', '2');

commit;

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
select * from tbl_room;

-- 2. 산전망 디럭스 패밀리 트윈룸 <유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''><fk_view_no 전망 ==> 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망>
insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
       , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval, 'JESH0001', '산전망 디럭스 패밀리 트윈룸', '2', '0'
       , '40', '12', '0'
       , 1, null, '1', null, null
       , '0', '1', '0', '0', '2'
       , '1', '1', '1', '4', '618750', '0');
commit;

-- <욕실> tbl_bath ==> 0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '5');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-18', '6');

-- <주방> tbl_kitchen ==> 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료

-- <객실내다과> tbl_snack ==> 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 라운지 이용
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-18', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-18', '1');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-18', '2');

-- <객실내엔터> tbl_ent ==> 0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-18', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-18', '1');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-18', '2');

-- <온도조절기> tbl_tmp ==> 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-18', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-18', '2');

commit;

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

/*
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

insert into tbl_lodge(lodge_id, fk_h_userid, lg_name, lg_en_name, lg_postcode
                    , lg_address, lg_detailaddress, lg_extraaddress, lg_latitude, lg_longitude
                    , lg_hotel_star, lg_area, lg_area_2, fk_lodge_type, lg_qty
                    , fk_cancel_opt, fd_status, fd_time, fk_s_checkin_type, lg_checkin_start_time
                    , lg_checkin_end_time, lg_checkout_time, lg_age_limit, lg_internet_yn, lg_park_yn
                    , lg_breakfast_yn, lg_dining_place_yn, lg_pool_yn, lg_pet_yn, lg_pet_fare
                    , lg_fac_yn, lg_service_yn, lg_rm_service_yn, lg_beach_yn, lg_business_yn
                    , lg_fa_travel_yn, fk_spa_type, lg_smoke_yn, lg_baggage_yn, lg_locker_yn
                    , lg_laundry_yn, lg_housekeep_yn, lg_status)
values('JEHI0002', 'hiddenCliff@gmail.com', '히든 클리프 호텔\&네이쳐', 'Hidden Cliff Hotel \& Nature',  '63536',
       '제주특별자치도 서귀포시 예래해안로 542', '히든 클리프 호텔\&네이쳐', '(상예동)', '33.2547291', '126.4024804',
       '4', '제주특별자치도', '서귀포시', '0', '250',
       '0', '1', '24시간', '0', '15:00 PM',
       '00:00 AM', '11:00 AM', '19', '1', '1',
       '1', '1', '1', '0', null,
       '1', '1', '1', '0', '1',
       '1', '0', '0', '1', '0',
       '0', '1', default);
commit;

-- 인터넷:1, 주차장:1, 저녁장소:1, 수영장:1, 장애인:1, 고객:1, 객실:1, 비즈니스:1, 가족:1
-- <인터넷> tbl_inet
-- 0 : 객실 내 wifi / 1 : 공용 구역 내 wifi / 2 : 객실 내 유선 인터넷 / 3: 공용 구역 내 유선 인터넷
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JEHI0002','0');
insert into tbl_inet (inet_seq, fk_lodge_id, fk_inet_opt_no)
values(seq_tbl_inet.nextval, 'JEHI0002','1');
commit;

-- <주차장> tbl_park
-- 0 : 실내 / 1 : 실외 / 2 : 주차대행 / 3 : 셀프주차
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JEHI0002','0');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JEHI0002','1');
insert into tbl_park (park_seq, fk_lodge_id, fk_park_opt_no)
values(seq_tbl_park.nextval, 'JEHI0002','3');
commit;

-- <다이닝> tbl_din
-- 0 : 레스토랑 / 1 : 카페 / 2 : 라운지
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JEHI0002','0');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JEHI0002','1');
insert into tbl_din (din_seq, fk_lodge_id, fk_din_opt_no)
values(seq_tbl_din.nextval, 'JEHI0002','2');
commit;

-- <수영장> tbl_pool
-- 0 : 실내 / 1 : 야외(1년 내내) / 2 : 야외(시즌 운영)
insert into tbl_pool (pool_seq, fk_lodge_id, fk_pool_opt_no)
values(seq_tbl_pool.nextval, 'JEHI0002','1');
commit;

-- <장애인편의시설> tbl_fac
-- 0 : 시설 내 휠체어 / 1 : 휠체어 이용 가능한 엘리베이터 / 2 : 장애인 주차 공간 / 3: 입구에 경사로 있음
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JEHI0002','0');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JEHI0002','1');
insert into tbl_fac (fac_seq, fk_lodge_id, fk_fac_opt_no)
values(seq_tbl_fac.nextval, 'JEHI0002','2');
commit;

-- <고객서비스> tbl_ cs
-- 0 : 짐 보관 서비스 / 1 : 사물함 이용가능 / 2 : 세탁시설 있음 / 3 : 드라이클리닝/세탁 서비스 / 4: 콘시어지 서비스 /  5 : 24시간 운영 프런트 데스크(프런트 데스크 운영시간이랑 연결) / 6 : 다국어 안내 서비스 / 7 : 하우스키핑 매일 제공 / 8 : 식료품점/편의점
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JEHI0002', '0');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JEHI0002', '4');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JEHI0002', '5');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JEHI0002', '6');
insert into tbl_cs(cs_seq, fk_lodge_id, fk_cs_opt_no)
values(seq_tbl_cs.nextval, 'JEHI0002', '7');
commit;

select * from tbl_cs

-- <객실서비스> tbl_rmsvc
-- 0 : 식사 배달 서비스 이용가능 / 1 : 객실 내 마사지 서비스 / 2 : 다리미/다리미판 / 3 : 객실 금고 / 4 : 컴퓨터 모니터 / 5 : 프린터 / 6 : 전화 / 7 : 슬리퍼 / 8 : 객실 내 세탁시설
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JEHI0002', '2');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JEHI0002', '3');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JEHI0002', '6');
insert into tbl_rmsvc(rmsvc_seq, fk_lodge_id, fk_rmsvc_opt_no)
values(seq_tbl_rmsvc.nextval, 'JEHI0002', '7');
commit;

-- <비즈니스> tbl_bsns
-- 0 : 비즈니스 센터 / 1 : 회의실 / 2 : 코워킹 스페이스 / 3 : 컨퍼런스 시설
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JEHI0002', '0');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JEHI0002', '1');
insert into tbl_bsns(bsns_seq, fk_lodge_id, fk_bsns_opt_no)
values(seq_tbl_bsns.nextval, 'JEHI0002', '3');
commit;

-- <가족여행> tbl_fasvc
-- 0 : 객실 내 어린이 돌보미(요금 별도) / 1 : 시설 내 탁아 서비스(요금 별도) / 3 : 키즈 클럽 / 4: 어린이용 물품 제공 / 5 : 유모차 / 6 : 시설 내 놀이터
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JEHI0002', '3');
insert into tbl_fasvc(fascvc_seq, fk_lodge_id, fk_fasvc_opt_no)
values(seq_tbl_fasvc.nextval, 'JEHI0002', '6');

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

select * from tbl_room;

-- 1. 디럭스 더블룸 <유무일때 유(가능) : 1 / 무(불가능) : 0, 침대 개수는 없으면 ''><fk_view_no 전망 ==> 0 : 전망없음 / 1 : 해변 전망 / 2 : 산 전망 / 3 : 강 전망 / 4 : 시내 전망 / 5 : 공원 전망>
insert into tbl_room (rm_seq, fk_lodge_id, rm_type, rm_bedrm_cnt, rm_smoke_yn
       , rm_size_meter, rm_size_pyug, rm_extra_bed_yn
       , rm_single_bed, rm_ss_bed, rm_double_bed, rm_queen_bed, rm_king_bed
       , rm_wheelchair_yn, rm_bathroom_cnt, rm_p_bathroom_yn, rm_kitchen_yn, fk_view_no
       , rm_snack_yn, rm_ent_yn, rm_tmp_ctrl_yn, rm_guest_cnt, rm_price, rm_breakfast_yn)
values('rm-'||seq_tbl_room.nextval, 'JEHI0002', '디럭스 더블룸', '1', '0'
       , '30', '9', '1'
       , null, null, '1', null, null
       , '0', '1', '0', '0', '0'
       , '1', '1', '1', '4', '410227', '0');
commit;

select * from tbl_room where fk_lodge_id = 'JEHI0002'

-- <욕실> tbl_bath ==> 0 : 타월 제공 / 1 : 목욕가운 / 2 : 바닥 난방/온돌 / 3 : 욕실 용품 / 4 : 헤어드라이어 / 5 : 비데 / 6 : 욕조
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '0');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '1');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '3');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '4');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '5');
insert into tbl_bath(bath_seq, fk_rm_seq, fk_bath_opt_no) values(seq_tbl_bath.nextval, 'rm-36', '6');

-- <주방> tbl_kitchen ==> 0 : 조리도구, 접시, 주방 기구 / 1 : 식기세척기 / 2 : 냉장고 / 3 : 오븐 / 4 : 전자레인지 / 5 : 밥솥 / 6 : 토스터 / 7 : 양념,향신료

-- <객실내다과> tbl_snack ==> 0 : 무료 생수 / 1 : 커피/티/에스프레소 메이커 / 2 : 미니바 / 3 : 라운지 이용
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-36', '0');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-36', '1');
insert into tbl_snack(snack_seq, fk_rm_seq, fk_snk_opt_no) values(seq_tbl_snack.nextval, 'rm-36', '2');

-- <객실내엔터> tbl_ent ==> 0 : TV / 1 : IPTV / 2 : OTT 이용 가능 / 3 : 컴퓨터 또는 태블릿 / 4 : 음성 인식 스마트 스피커
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-36', '0');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-36', '1');
insert into tbl_ent(ent_seq, fk_rm_seq, fk_ent_opt_no) values(seq_tbl_ent.nextval, 'rm-36', '2');

-- <온도조절기> tbl_tmp ==> 0 : 에어컨 / 1 : 선풍기 / 2 : 난방
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-36', '0');
insert into tbl_tmp(tmp_seq, fk_rm_seq, fk_tmp_opt_no) values(seq_tbl_tmp.nextval, 'rm-36', '2');

commit;

/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

-- lg_area 갯수
select count(*)
from tbl_lodge
where lower(lg_area) like '%' || lower('제') || '%';

-- lg_area_2 갯수
select count(*)
from tbl_lodge
where lower(lg_area_2) like lower('제') || '%';

-- lg_name 갯수
select count(*)
from tbl_lodge
where lower(lg_name) like lower('제') || '%';

-----------------------------------------------

-- lg_area 검색 결과
select lg_area
from tbl_lodge
where lower(lg_area) like lower('제') || '%'
group by lg_area;

-- lg_area_2 검색 결과
select lg_area_2, lg_area
from tbl_lodge
where lower(lg_area_2) like lower('제') || '%'
group by lg_area_2, lg_area;

-- lg_name 검색 결과
select lg_name, lg_area_2, lg_area
from tbl_lodge
where lower(lg_name) like lower('제') || '%';

select * from tbl_room


desc tbl_reservation

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
,user_lvl           number(2)   not null            -- ex: 0 => 블루 / 1 => 실버 / 2 => 골드
,point              number(10)  not null
,emer_name          varchar2(20)
,emer_phone         varchar2(30)
,pt_num             varchar2(20)
,pt_nation          varchar2(20)
,pt_endDate         date
,constraint PK_tbl_user_userid primary key(userid)
);

insert into tbl_user(userid, name, email, pw, role, registerDate, idle, user_lvl, point)
values('wogn0721@naver.com', '이재훈', 'wogn0721@naver.com', '4a04d05a82d9c6fc293fd4f15af1d037757f7f6bd7555cbcc372a303df529eea', 1, default, 1, 0, 0)
commit;

desc tbl_reservation;

select *
from tbl_reservation;

insert into tbl_reservation(RS_SEQ, FK_USERID, FK_H_USERID, RS_DATE, RS_CHECKINDATE, RS_CHECKOUTDATE, RS_PRICE, RS_PAYTYPE, RS_NAME, RS_MOBILE, RS_EMAIL, RS_GUEST_CNT, FK_RM_SEQ)
values(seq_reservation.nextval, 'wogn0721@naver.com', 'shillaJeju@gmail.com', to_date('24/01/02'), to_date('24/02/21'), to_date('24/02/25'), '618750', 0, '이재훈', '010-8380-0271', 'wogn0721@naver.com', '3', 'rm-18');

insert into tbl_reservation(RS_SEQ, FK_USERID, FK_H_USERID, RS_DATE, RS_CHECKINDATE, RS_CHECKOUTDATE, RS_PRICE, RS_PAYTYPE, RS_NAME, RS_MOBILE, RS_EMAIL, RS_GUEST_CNT, FK_RM_SEQ, RS_CANCEL)
values(seq_reservation.nextval, 'wogn0721@naver.com', 'shillaJeju@gmail.com', to_date('24/01/02'), to_date('24/02/21'), to_date('24/02/25'), '618750', 0, '이재훈', '010-8380-0271', 'wogn0721@naver.com', '3', 'rm-18', '1');

commit;

select *
from tbl_user

select fk_rm_seq
from tbl_lodge

select *
from tbl_room

desc tbl_room

update tbl_room set rm_cnt = '5' where fk_lodge_id = 'JESH0001'

commit;




(
select count(*) as room_qty, fk_h_userid
from tbl_reservation
where fk_h_userid = 'shillaJeju@gmail.com'
group by fk_rm_seq, fk_h_userid
)

select * from tbl_reservation


update tbl_reservation set fk_rm_seq = 'rm-15'
where rs_seq = '5'

alter table tbl_reservation add fk_rm_seq Nvarchar2(15);

commit;

alter table tbl_reservation
add constraint FK_tbl_reservation_fk_rm_seq foreign key(fk_rm_seq) references tbl_room(rm_seq);

select *
from tbl_lodge



--  검색결과의 숙소리스트에서 숙박인원수가 최대인원보다 작거나 같은경우
select *
from
(
    -- 검색결과가 있는 경우 숙소 리스트
    select *
    from tbl_lodge
    where 1 = 1
    -- and lg_name = '제주신라호텔'
    -- and lg_area_2 = '제주시'
    and lg_area = '제주특별자치도'
) L 
right join tbl_room R
on L.lodge_id = R.fk_lodge_id
where L.lodge_id = R.fk_lodge_id
and to_number(R.rm_guest_cnt) >= to_number('4')

update tbl_room set rm_cnt = '5' where fk_lodge_id = 'JEHI0002'
commit;

-- <1>
-- hotelSearchController 에서
-- 1. lg_name 이 있을경우 lg_name으로 where절 사용해서 lodge_id list 만들기
-- 2. lg_area_2 이 있을경우 lg_area_2으로 where절 사용해서 lodge_id list 만들기
-- 3. lg_area 이 있을경우 lg_area으로 where절 사용해서 lodge_id list 만들기
select lodge_id, lg_name, lg_area_2, lg_area
from
(
    select L.lodge_id, L.lg_name, L.lg_area_2, L.lg_area, L.lg_hotel_star, L.fk_lodge_type
    from
    (
        select lodge_id, MIN(rm_price) AS min_price, AVG(fk_rv_rating) AS avg_rating
        from
            (select * from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id)
        C
        join tbl_review V
        on C.lodge_id = V.fk_lodge_id
        group by lodge_id
    ) P
    join tbl_lodge L
    on P.lodge_id = L.lodge_id
    order by avg_rating desc, min_price asc, lg_hotel_star desc
)
where 1 = 1
-- and lg_name = '제주신라호텔'
-- and lg_area_2 = '제주시'
and lg_area = '제주특별자치도'
and lg_hotel_star in(4, 5)
and fk_lodge_type = '0'          -- 0:호텔, 1:모텔, 2:아파트식호텔(레지던스), 3:리조트, 4:펜션


-- 추천순(예약많은순, 성급, 낮은가격)
select L.lodge_id, L.lg_name, L.lg_area_2, L.lg_area, L.lg_hotel_star, L.fk_lodge_type
from
(
    select lodge_id, min_price, nvl(resv_cnt, 0) as resv_cnt
    from
        (select lodge_id, MIN(rm_price) AS min_price from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id group by lodge_id)
    C
    left join (select fk_lodge_id, count(*) AS resv_cnt from tbl_review group by fk_lodge_id) V
    on C.lodge_id = V.fk_lodge_id
) P
left join tbl_lodge L
on P.lodge_id = L.lodge_id
order by resv_cnt desc, lg_hotel_star desc, min_price asc

-- 낮은가격순
select L.lodge_id, L.lg_name, L.lg_area_2, L.lg_area, L.lg_hotel_star, L.fk_lodge_type
from
(
    select lodge_id, MIN(rm_price) AS min_price, AVG(fk_rv_rating) AS avg_rating
    from
        (select * from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id)
    C
    join tbl_review V
    on C.lodge_id = V.fk_lodge_id
    group by lodge_id
) P
join tbl_lodge L
on P.lodge_id = L.lodge_id
order by min_price asc

-- 높은가격순
select L.lodge_id, L.lg_name, L.lg_area_2, L.lg_area, L.lg_hotel_star, L.fk_lodge_type
from
(
    select lodge_id, MAX(rm_price) AS max_price, AVG(fk_rv_rating) AS avg_rating
    from
        (select * from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id)
    C
    join tbl_review V
    on C.lodge_id = V.fk_lodge_id
    group by lodge_id
) P
join tbl_lodge L
on P.lodge_id = L.lodge_id
order by max_price desc

-- 평점순
select L.lodge_id, L.lg_name, L.lg_area_2, L.lg_area, L.lg_hotel_star, L.fk_lodge_type
from
(
    select lodge_id, MIN(rm_price) AS min_price, AVG(fk_rv_rating) AS avg_rating
    from
        (select * from tbl_lodge L join tbl_room R on L.lodge_id = R.fk_lodge_id)
    C
    join tbl_review V
    on C.lodge_id = V.fk_lodge_id
    group by lodge_id
) P
join tbl_lodge L
on P.lodge_id = L.lodge_id
order by avg_rating desc



-- <2-1>
-- 1. 검색된 숙소의 lodge_id list 받아서 for문을 돌려주기
-- 2. 예약가능한 객실이 있는 숙소의 lodge_id를 list로 뽑아내기
SELECT lodge_id
FROM
(                                                                                                              
    SELECT lodge_id, lg_name, rm_seq, rm_type, rm_price,rm_guest_cnt, rm_cnt - rs_room_cnt AS available_cnt
    FROM
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
        where (rs_checkindate <= to_date('2023-12-16')) and ((to_date('2023-12-16') < rs_checkoutdate) and (rs_checkoutdate <= to_date('2023-12-18')))
            or ((to_date('2023-12-16') <= rs_checkindate) and ((rs_checkindate <= to_date('2023-12-18')) and (to_date('2023-12-18') <= rs_checkoutdate)))
            or ((rs_checkindate <= to_date('2023-12-16')) and (to_date('2023-12-18') <= rs_checkoutdate))
            or ((to_date('2023-12-16') <= rs_checkindate) and (rs_checkoutdate <= to_date('2023-12-18')))
            group by fk_rm_seq
    ) V
    JOIN
    (
        select L.lg_name, L.lodge_id, R.rm_seq, R.rm_type, R.rm_guest_cnt, R.rm_price, R.rm_cnt
        from tbl_room R join tbl_lodge L
        on R.fk_lodge_id = L.lodge_id
        where L.lodge_id = 'JESH0001'
        and to_number(R.rm_guest_cnt) >= to_number('2')
        -- and lg_breakfast_yn = '1'        -- 0:조식없음, 1:조식있음
        -- and lg_pool_yn = '1'             -- 0:수영장없음, 1:수영장있음
        -- and lg_internet_yn = '1'         -- 0:wifi없음, 1:wifi있음
        -- and lg_beach_yn = '1'            -- 0:바다없음 , 1:바다있음
        -- and lg_pet_yn = '1'              -- 0:반려동물 동반 불가 , 1: 반려동물 동반 가능
        -- and fk_spa_type = '1'            -- 0:스파 없음 , 1: 스파 있음
        -- and lg_park_yn = '1'             -- 0:주차장 없음 , 1: 주차장 있음
        -- and (lg_dining_place_yn = '1'    -- 0:저녁장소 없음 , 1: 저녁장소 있음
        -- and '1' = (select count(*) from tbl_din where fk_lodge_id = 'JESH0001' and fk_din_opt_no = '0')) --> 0:레스토랑, 1:카페, 2:라운지
        -- and (lg_fa_travel_yn = '1'       -- 0:가족서비스 없음 , 1: 가족서비스 있음 => 유아용품
        -- and '1' = (select count(*) from tbl_fasvc where fk_lodge_id = 'JESH0001' and fk_fasvc_opt_no = '5')) --> 0:어린이 돌보미, 1:탁아 서비스, 3:키즈 클럽, 4:어린이용 물품, 5:유모차, 6:놀이터
        -- and (lg_service_yn = '1'         -- 0:기타서비스 없음 , 1: 기타서비스 있음 => 세탁기 및 건조기
        -- and '1' = (select count(*) from tbl_cs where fk_lodge_id = 'JESH0001' and fk_cs_opt_no = '3')) --> 0:짐보관, 1:사물함, 2:세탁시설 있음, 3:드라이클리닝/세탁, 4:콘시어지, 5:24시간프런트, 6:다국어, 7:하우스키핑매일, 8:식료품점/편의점
        -- and rm_kitchen_yn = '0'          -- 0:주방없음, 1:주방있음
        -- and (rm_tmp_ctrl_yn = '1'        -- 0:온도조절없음, 1:온도조절있음
        -- and 1 <= (select count(*) from (select * from tbl_tmp T join tbl_room R on T.fk_rm_seq = R.rm_seq) where fk_lodge_id = 'JESH0001' and fk_tmp_opt_no = '0' group by fk_lodge_id)) --> 0:에어컨, 1:선풍기, 2:난방
        -- and 8 <= (select avg(fk_rv_rating) from tbl_review where fk_lodge_id ='JESH0001' group by fk_lodge_id)  --> 고객평점
    ) C
    ON V.fk_rm_seq = C.rm_seq
    where C.rm_cnt - V.rs_room_cnt > 0
)
GROUP BY lodge_id

-- <2-2>
-- 1. 검색된 숙소의 lodge_id list 받아서 for문을 돌려주기
-- 2. 예약가능한 객실이 있는 숙소의 lodge_id를 list로 뽑아내기
-- 3. 해당숙소의 객실과 남은 객실수 리턴
SELECT fk_lodge_id, sum(rest_room_cnt)
FROM
(
    select fk_lodge_id, rm_seq, rm_type, rm_cnt, nvl(rs_room_cnt, 0) AS rs_room_cnt
         , to_number(rm_cnt) - to_number(nvl(rs_room_cnt, 0)) AS rest_room_cnt
    from
    (
        select fk_lodge_id, rm_seq, rm_type, rm_cnt
        from tbl_room
        where fk_lodge_id = 'JESH0001'
        and to_number(rm_guest_cnt) >= to_number('4')
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
)
GROUP BY fk_lodge_id


-- <3>
-- 1. for문 돌려서 해당 lodge_id 에 대해 view page에 보여줄 내용들 받아오기

-- 숙소 기본정보 + 예약가능한 객실 중 최소금액인 객실 금액 + 총 금액
select lodge_id, lg_name, lg_area_2, lg_area, fk_cancel_opt, rm_price, rating, review_cnt
from
(
    select fk_lodge_id, rm_seq, rm_type, rm_cnt, nvl(rs_room_cnt, 0) AS rs_room_cnt
         , to_number(rm_cnt) - to_number(nvl(rs_room_cnt, 0)) AS rest_room_cnt
         , rating, review_cnt
    from
    (
        select R.fk_lodge_id, rm_seq, rm_type, rm_cnt, V.rating, V.review_cnt
        from
        (
            select *
            from tbl_room
            where fk_lodge_id = 'JESH0001'
        ) R
        join
        (
            select fk_lodge_id, round(avg(fk_rv_rating), 1) as rating, count(*) AS review_cnt
            from tbl_review
            group by fk_lodge_ID
        ) V
        on R.fk_lodge_id = V.fk_lodge_id
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
) V
LEFT JOIN
(
    select L.lodge_id, L.lg_name, L.lg_area, L.lg_area_2, rm_price, rm_seq
         , decode(fk_cancel_opt, '0', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 3), 1, '전액 환불 가능', ' ')
                               , '1', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 2), 1, '전액 환불 가능', ' ')
                               , '2', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 1), 1, '전액 환불 가능', ' ')
                               , '3', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 0), 1, '전액 환불 가능', ' ')) AS fk_cancel_opt
    from tbl_lodge L
    join tbl_room R
    on L.lodge_id = R.fk_lodge_id
    where L.lodge_id = 'JESH0001'
        -- and lg_breakfast_yn = '1'        -- 0:조식없음, 1:조식있음
        -- and lg_pool_yn = '1'             -- 0:수영장없음, 1:수영장있음
        -- and lg_internet_yn = '1'         -- 0:wifi없음, 1:wifi있음
        -- and lg_beach_yn = '1'            -- 0:바다없음 , 1:바다있음
        -- and lg_pet_yn = '1'              -- 0:반려동물 동반 불가 , 1: 반려동물 동반 가능
        -- and fk_spa_type = '1'            -- 0:스파 없음 , 1: 스파 있음
        -- and lg_park_yn = '1'             -- 0:주차장 없음 , 1: 주차장 있음
        -- and (lg_dining_place_yn = '1'    -- 0:저녁장소 없음 , 1: 저녁장소 있음
        -- and '1' = (select count(*) from tbl_din where fk_lodge_id = 'JESH0001' and fk_din_opt_no = '0')) --> 0:레스토랑, 1:카페, 2:라운지
        -- and (lg_fa_travel_yn = '1'       -- 0:가족서비스 없음 , 1: 가족서비스 있음 => 유아용품
        -- and '1' = (select count(*) from tbl_fasvc where fk_lodge_id = 'JESH0001' and fk_fasvc_opt_no = '5')) --> 0:어린이 돌보미, 1:탁아 서비스, 3:키즈 클럽, 4:어린이용 물품, 5:유모차, 6:놀이터
        -- and (lg_service_yn = '1'         -- 0:기타서비스 없음 , 1: 기타서비스 있음 => 세탁기 및 건조기
        -- and '1' = (select count(*) from tbl_cs where fk_lodge_id = 'JESH0001' and fk_cs_opt_no = '3')) --> 0:짐보관, 1:사물함, 2:세탁시설 있음, 3:드라이클리닝/세탁, 4:콘시어지, 5:24시간프런트, 6:다국어, 7:하우스키핑매일, 8:식료품점/편의점
        -- and rm_kitchen_yn = '0'          -- 0:주방없음, 1:주방있음
        -- and (rm_tmp_ctrl_yn = '1'        -- 0:온도조절없음, 1:온도조절있음
        -- and 1 <= (select count(*) from (select * from tbl_tmp T join tbl_room R on T.fk_rm_seq = R.rm_seq) where fk_lodge_id = 'JESH0001' and fk_tmp_opt_no = '0' group by fk_lodge_id)) --> 0:에어컨, 1:선풍기, 2:난방
) D
ON V.rm_seq = D.rm_seq
WHERE rest_room_cnt > 0
AND rm_price = 
( 
    select MIN(to_number(rm_price)) AS rm_price
    from
    (
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
    ) V
    LEFT JOIN
    (
        select L.lodge_id, L.lg_name, L.lg_area, L.lg_area_2, rm_price, rm_seq
        from tbl_lodge L
        join tbl_room R
        on L.lodge_id = R.fk_lodge_id
        where L.lodge_id = 'JESH0001'
    ) D
    ON V.rm_seq = D.rm_seq
    WHERE rest_room_cnt > 0
    -- AND 0 < to_number(rm_price)
    -- AND to_number(rm_price) < 500000
)

-- 0 : 24시간 이전 : 50% 환불가능 / 48시간 이전: 75% 환불가능 / 72시간 이전: 100% 환불가능
-- 1 : 24시간 이전 : 75% 환불가능 / 48시간 이전: 100% 환불가능
-- 2 : 24시간 이전 : 100% 환불가능 / 그 이후 환불불가
-- 3 : 체크인 1시간 이전 : 100% 환불가능
select to_date('2023-12-19') - sysdate
from dual

select trunc(to_date('2023-12-20') - sysdate)
from dual

select decode(cancel_opt, '0', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 3), 1, '전액 환불 가능', ' ')
                        , '1', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 2), 1, '전액 환불 가능', ' ')
                        , '2', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 1), 1, '전액 환불 가능', ' ')
                        , '3', decode(SIGN(ceil(to_date('2023-12-20') - sysdate) - 0), 1, '전액 환불 가능', ' '))
from tbl_cancel

select trunc(to_date('2023-12-20') - sysdate)
from dual

select cancel_opt 
from tbl_cancel

-- 해당 숙소의 메인이미지 가져오기(carousel)
select fk_lodge_id, lg_img_name
from tbl_lg_img
where fk_img_cano = '6'
order by lg_img_save_name asc;

select fk_lodge_id, lg_img_save_name, lg_img_name
from tbl_lg_img
where fk_img_cano = '6' and fk_lodge_id = 'JEHI0002'
order by lg_img_save_name asc

update tbl_lg_img set lg_img_save_name = '2023121912400259243254235235334.png'
where lg_img_save_name = '2023121912400259243254235235234.png' and fk_lodge_id = 'JEHI0002';

update tbl_lg_img set lg_img_save_name = '2023121912400259243254235235335.png'
where lg_img_save_name = '2023121912400259243254235235235.png' and fk_lodge_id = 'JEHI0002';

update tbl_lg_img set lg_img_save_name = '2023121912400259243254235235336.png'
where lg_img_save_name = '2023121912400259243254235235236.png' and fk_lodge_id = 'JEHI0002';

update tbl_lg_img set lg_img_save_name = '2023121912400259243254235235337.png'
where lg_img_save_name = '2023121912400259243254235235237.png' and fk_lodge_id = 'JEHI0002';

update tbl_lg_img set lg_img_save_name = '2023121912400259243254235235338.png'
where lg_img_save_name = '2023121912400259243254235235238.png' and fk_lodge_id = 'JEHI0002';

commit;

select fk_lodge_id, lg_img_save_name
		from tbl_lg_img
		where fk_img_cano = '6'
		order by lg_img_save_name asc

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JEHI0002', '2023121912400259' || '243254235235234.png', '01_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JEHI0002', '2023121912400259' || '243254235235235.png', '02_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JEHI0002', '2023121912400259' || '243254235235236.png', '03_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JEHI0002', '2023121912400259' || '243254235235237.png', '04_메인.png', '6');

insert into tbl_lg_img(lg_img_seq ,fk_lodge_id ,lg_img_save_name ,lg_img_name, fk_img_cano)
values(seq_tbl_lg_img.nextval, 'JEHI0002', '2023121912400259' || '243254235235238.png', '05_메인.png', '6');

commit;

select *
from tbl_lodge
where lodge_id = 'JEHI0002'

commit;

-- 해당 숙소의 좋아요 여부확인
select *
from tbl_wishlist

-- 해당 숙소의 전체 리뷰갯수, 평점 가져오기
select *
from tbl_review

-- 검색된 숙소의 최대 최소 가격 가져오기
SELECT nvl(MAX(max_price), 0) AS max_price, nvl(MIN(min_price), 0) AS min_price
FROM
(
    select lodge_id, lg_name, max_price, min_price
    from
    (
        select lodge_id, lg_name
        from tbl_lodge
        where 1 = 1
        and lg_name = '제주신라호텔'
        -- and lg_area_2 = '제주시'
        -- lg_area = '제주특별자치도'
    ) L
    left join 
    (
        select fk_lodge_id, max(to_number(rm_price)) AS max_price, min(to_number(rm_price)) AS min_price
        from tbl_room 
        group by fk_lodge_id
    ) R
    on L.lodge_id = R.fk_lodge_id
)

select *
from tbl_reservation
where fk_h_userid = 'shillaJeju@gmail.com'

insert into tbl_reservation(RS_SEQ, FK_USERID, FK_H_USERID, RS_DATE, RS_CHECKINDATE, RS_CHECKOUTDATE, RS_PRICE, RS_PAYTYPE, RS_NAME, RS_MOBILE, RS_EMAIL, RS_GUEST_CNT, FK_RM_SEQ)
values(seq_reservation.nextval, 'wogn0721@naver.com', 'shillaJeju@gmail.com', to_date('23/12/19'), to_date('23/12/19'), to_date('23/12/21'), '618750', 0, '이재훈', '010-8380-0271', 'wogn0721@naver.com', '2', 'rm-17')

insert into tbl_reservation(RS_SEQ, FK_USERID, FK_H_USERID, RS_DATE, RS_CHECKINDATE, RS_CHECKOUTDATE, RS_PRICE, RS_PAYTYPE, RS_NAME, RS_MOBILE, RS_EMAIL, RS_GUEST_CNT, FK_RM_SEQ)
values(seq_reservation.nextval, 'wogn0721@naver.com', 'shillaJeju@gmail.com', to_date('23/12/20'), to_date('23/12/29'), to_date('23/12/30'), '618750', 0, '이재훈', '010-8380-0271', 'wogn0721@naver.com', '4', 'rm-17')

commit;


select to_date('2023-12-16')
from dual


select *
from tbl_review

desc tbl_review
/*
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
(rv_seq  NVARCHAR2(10) -- 이용후기 글 번호
,fk_lodge_id NVARCHAR2(10) not null -- 숙박시설 id
,fk_rs_seq  VARCHAR2(30) -- 예약번호
,rv_subject NVARCHAR2(200) -- 글제목
,rv_content NVARCHAR2(2000) -- 후기내용
,rv_regDate date default sysdate not null --작성일자
,rv_status NVARCHAR2(1) -- 글 삭제여부 (0: 삭제 / 1:삭제X)
,` number(2) -- 평점
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



create sequence seq_tbl_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
*/

insert into tbl_reservation(RS_SEQ, FK_USERID, FK_H_USERID, RS_DATE, RS_CHECKINDATE, RS_CHECKOUTDATE, RS_PRICE, RS_PAYTYPE, RS_NAME, RS_MOBILE, RS_EMAIL, RS_GUEST_CNT, FK_RM_SEQ)
values(seq_reservation.nextval, 'wogn0721@naver.com', 'hiddenCliff@gmail.com', to_date('23/12/22'), to_date('24/01/02'), to_date('24/01/05'), '410227', 0, '이재훈', '010-8380-0271', 'wogn0721@naver.com', '2', 'rm-36');

commit;

select * from tbl_host
select * from tbl_reservation
select * from tbl_room
select * from tbl_review

insert into tbl_review(rv_seq, fk_lodge_id, fk_rs_seq, rv_subject, rv_content, rv_regdate, rv_status, fk_rv_rating)
values(seq_tbl_review.nextval, 'JESH0001', '8', '12/16-20 제주 신라호텔 산전망 스탠다드 더블 룸 후기', '즐거웠습니다.', default, '1', 8);

insert into tbl_review(rv_seq, fk_lodge_id, fk_rs_seq, rv_subject, rv_content, rv_regdate, rv_status, fk_rv_rating)
values(seq_tbl_review.nextval, 'JESH0001', '14', '12/19-21일 제주 신라호텔 산전망 스탠다드 더블 룸 후기', '행복했습니다.', default, '1', 8);

insert into tbl_review(rv_seq, fk_lodge_id, fk_rs_seq, rv_subject, rv_content, rv_regdate, rv_status, fk_rv_rating)
values(seq_tbl_review.nextval, 'JESH0001', '15', '12/20-29일 제주 신라호텔 산전망 스탠다드 더블 룸 후기', '불편했습니다.', default, '1', 6);

insert into tbl_review(rv_seq, fk_lodge_id, fk_rs_seq, rv_subject, rv_content, rv_regdate, rv_status, fk_rv_rating)
values(seq_tbl_review.nextval, 'JESH0001', '11', '12/21-25일 제주 신라호텔 산전망 디럭스 패밀리 트윈룸 후기', '최고였습니다.', default, '1', 10);

insert into tbl_review(rv_seq, fk_lodge_id, fk_rs_seq, rv_subject, rv_content, rv_regdate, rv_status, fk_rv_rating)
values(seq_tbl_review.nextval, 'JEHI0002', '19', '01/02-05일 히든클리프 디럭스 더블룸 후기', '나쁘지 않았네요.', default, '1', 4);

commit;


create table tbl_search_log
(search_seq     number(10)                      -- 검색번호
,search_text    nvarchar2(50)                   -- 검색내용
,search_date    date default sysdate not null   -- 검색날짜
,constraint PK_tbl_search_log_search_seq primary key(search_seq)
);

create sequence seq_tbl_search_log
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_search_log(search_seq, search_text, search_date)
values(seq_tbl_search_log.nextval, '' || ' ' || '강릉시' || ' ' || '', default);

commit;

select * from tbl_lodge

select search_text
from tbl_search_log
where (sysdate - 7) <= search_date
order by search_date desc

select sysdate - 7
from dual

delete from tbl_search_log where search_text = '서귀포시,제주특별자치도'

update tbl_search_log set search_text = '제주특별자치도' where search_text = '제주특별자치도,서귀포시,제주신라호텔'
commit;

select *
from tbl_user;

update tbl_user set pw = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382' where userid = 'wogn0721@naver.com';
update tbl_user set user_lvl = 2 where userid = 'wogn0721@naver.com';

commit;






/*///////////////////////////////////////////////////////////////////////////////////////
                                    예약리스트 가져오기
                         1. 앞으로 있을 예약(체크인이 지나지 않은 예약)
                         2. 이미 지난 예약
///////////////////////////////////////////////////////////////////////////////////////*/
-- 앞으로 있을 예약
-- 필요한 정보(lg_name, rs_checkindate, rs_seq)
select rno, lodge_id, lg_name, rs_month, rs_day, rs_no, lg_img_save_name
from
(
    select rownum as rno, lodge_id, lg_name, rs_month, rs_day, rs_no, lg_img_save_name
    from
    (
        select lg_name, to_number(to_char(rs_checkindate, 'mm')) as rs_month, to_number(to_char(rs_checkindate, 'dd')) as rs_day, rs_seq as rs_no, lg_img_save_name, rs_date, lodge_id
        from
        (
            select *
            from tbl_reservation
            where fk_userid = 'wogn0721@naver.com'
            and to_date(rs_checkindate, 'yyyy-mm-dd hh24:mi:ss') > to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss')
            and rs_cancel = 0
            order by rs_date desc
        ) R
        join 
        (
            select lodge_id, lg_name, fk_h_userid, lg_img_save_name
            from
            (
                select lodge_id, lg_name, rno, L.fk_h_userid, lg_img_save_name
                from
                (
                    select row_number() over(partition by fk_lodge_id order by lg_img_save_name asc) as rno, fk_lodge_id, lg_img_save_name
                    from tbl_lg_img I
                    order by lg_img_save_name
                ) I
                join tbl_lodge L
                on I.fk_lodge_id = L.lodge_id
            )
            where rno = 1
        ) L
        on R.fk_h_userid = L.fk_h_userid
        order by rs_date desc
    )
)
where rno <= 3



-- 이미 지난 예약
select rno, lodge_id, lg_name, rs_month, rs_day, rs_no, lg_img_save_name, rv_yn, rs_cancel
from
(
    select rownum as rno, lodge_id, lg_name, rs_month, rs_day, rs_no, lg_img_save_name, rv_yn, rs_cancel
    from
    (
        select lg_name, to_number(to_char(rs_checkindate, 'mm')) as rs_month, to_number(to_char(rs_checkindate, 'dd')) as rs_day, rs_seq as rs_no, lg_img_save_name, rs_date, lodge_id, rv_yn, rs_cancel
        from
        (
            select fk_h_userid, S.rs_checkindate, S.rs_seq, S.rs_date, nvl(V.rv_seq, -1) as rv_yn, rs_cancel
            from tbl_reservation S
            left join tbl_review V
            on S.rs_seq = V.fk_rs_seq
            where S.fk_userid = 'wogn0721@naver.com'
            and (to_date(S.rs_checkindate, 'yyyy-mm-dd hh24:mi:ss') <= to_date(sysdate, 'yyyy-mm-dd hh24:mi:ss')
            or rs_cancel = '1')
            order by S.rs_date desc
        ) R
        join 
        (
            select lodge_id, lg_name, fk_h_userid, lg_img_save_name
            from
            (
                select lodge_id, lg_name, rno, L.fk_h_userid, lg_img_save_name
                from
                (
                    select row_number() over(partition by fk_lodge_id order by lg_img_save_name asc) as rno, fk_lodge_id, lg_img_save_name
                    from tbl_lg_img I
                    order by lg_img_save_name
                ) I
                join tbl_lodge L
                on I.fk_lodge_id = L.lodge_id
            )
            where rno = 1
        ) L
        on R.fk_h_userid = L.fk_h_userid
        order by rs_date desc
    )
)
where rno <= 3


-- 클릭시 체크인 시간 기준 72시간이 남았는지 확인하는 메소드
--- *** 취소정책 날짜 계산 *** ---    
select count(*)
from
(
    select to_char(to_date((select to_char(rs_checkindate,'yyyy-mm-dd') from tbl_reservation where rs_seq = '37') ||' '|| checkin_time,'yyyy-mm-dd hh24:mi:ss') - 3 + 0 + 0 + 0,'yyyy-mm-dd hh24:mi:ss') As checkinBefore72hour
    from
    (
        select fk_h_userid
              ,case when substr(lg_checkin_start_time,7,8) = 'PM' then substr(lg_checkin_start_time,1,2) + 12 || ':00:00' else substr(lg_checkin_start_time,1,2) + 0 ||':00:00' end as checkin_time
              ,case when substr(lg_checkout_time,7,8) = 'PM' then substr(lg_checkout_time,1,2) + 12 || ':00' else substr(lg_checkout_time,1,2) + 0 ||':00' end as checkout_time
        from tbl_lodge
    )    
    where 1=1
    and fk_h_userid = (select fk_h_userid from tbl_reservation where rs_seq = '37')
)
where to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') <= checkinBefore72hour


-- update 하는 메소드
update tbl_reservation 
set rs_cancel = '1'
where rs_seq ='7';


select * from tbl_reservation where fk_userid = 'wogn0721@naver.com';

alter table tbl_reservation add rs_cancel Nvarchar2(1) default '0' NOT NULL;

commit;

select *
from tbl_wishlist

select *
from tbl_user

-- 좋아요 테이블
create table tbl_wishlist
(wishlist_seq   number(9)      not null  -- 좋아요 번호   / seq
,fk_lodge_id    Nvarchar2(10)  not null  -- 숙박시설ID    / PARA0001
,fk_userid      varchar2(20)   not null  -- 유저ID       / rm-2
,constraint PK_tbl_wishlist_wishlist_seq primary key(wishlist_seq)
,constraint FK_tbl_wishlist_fk_lodge_id foreign key(fk_lodge_id) references tbl_lodge(lodge_id) on delete cascade
,constraint FK_tbl_wishlist_fk_userid foreign key(fk_userid) references tbl_user(userid)
);

create sequence seq_tbl_wishlist
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop table tbl_wishlist purge;

commit;

select fk_lodge_id from tbl_lg_img group by fk_lodge_id;
select * from tbl_lodge;

insert into tbl_wishlist(wishlist_seq, fk_lodge_id, fk_userid)
values(seq_tbl_wishlist.nextval, 'PARA0001', 'wogn0721@naver.com');

insert into tbl_wishlist(wishlist_seq, fk_lodge_id, fk_userid)
values(seq_tbl_wishlist.nextval, 'JEHI0002', 'wogn0721@naver.com');

insert into tbl_wishlist(wishlist_seq, fk_lodge_id, fk_userid)
values(seq_tbl_wishlist.nextval, 'JESH0001', 'wogn0721@naver.com');

insert into tbl_wishlist(wishlist_seq, fk_lodge_id, fk_userid)
values(seq_tbl_wishlist.nextval, 'GWGN0002', 'wogn0721@naver.com');

commit;

-- 한 회원의 좋아요 리스트
-- lodge_id, lg_name, min_price, rating, review_cnt, lg_img_save_name
select *
from tbl_wishlist
where fk_userid = 'wogn0721@naver.com'

select P.lodge_id, P.lg_name, P.lg_img_save_name, nvl(to_char(min_price), '가격정보없음') as min_price, nvl(to_char(rating), '평점없음') as rating, nvl(to_char(review_cnt), '리뷰없음') as review_cnt
from
(
    select lodge_id, lg_name, lg_img_save_name
    from
    (
        select lodge_id, lg_name, fk_h_userid, lg_img_save_name
        from
        (
            select lodge_id, lg_name, rno, L.fk_h_userid, lg_img_save_name
            from
            (
                select row_number() over(partition by fk_lodge_id order by lg_img_save_name asc) as rno, fk_lodge_id, lg_img_save_name
                from tbl_lg_img I
                order by lg_img_save_name
            ) I
            join tbl_lodge L
            on I.fk_lodge_id = L.lodge_id
        )
        where rno = 1
    ) C
    join tbl_wishlist W
    on C.lodge_id = W.fk_lodge_id
    where fk_userid = 'wogn0721@naver.com'
) P
left join 
(
    select lodge_id, min_price, rating, review_cnt
    from
    (
        select lodge_id, min(to_number(rm_price)) as min_price
        from tbl_room R
        join tbl_lodge L
        on R.fk_lodge_id = L.lodge_id
        group by lodge_id
    ) A 
    join
    (
        select fk_lodge_id, count(*) as review_cnt, avg(to_number(fk_rv_rating)) as rating
        from tbl_review
        group by fk_lodge_id
    ) B
    on A.lodge_id = B.fk_lodge_id
) Q
ON P.lodge_id = Q.lodge_id


select *
from tbl_wishlist

delete from tbl_wishlist
where fk_lodge_id = 'GWGN0002'
and fk_userid = 'wogn0721@naver.com';

commit;

select * -- fk_lodge_id, lg_img_save_name
from tbl_lg_img
where fk_img_cano = '6'
order by lg_img_save_name asc


select fk_lodge_id
from tbl_wishlist
where fk_userid = 'wogn0721@naver.com'

select *
from tbl_search_log

select nvl(search_text, '전체') as search_text
from tbl_search_log
where (sysdate - 7) <= search_date
order by search_date desc


















