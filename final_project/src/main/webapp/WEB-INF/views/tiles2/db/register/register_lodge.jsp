<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/register_lodge.css" />


<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div class="register_body">
		<div id="fixed_step">
			여기는 단계입니다.
		</div>
		
		<div id="lodge_info">
			<form name="lodge_info_Frm">
				
				<input type="text" size="6" />-<input type="text" size="6" />
				<input type="text" name="lodge_id" />
			
			
			</form>
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
		</div>
	</div>


	

</div>