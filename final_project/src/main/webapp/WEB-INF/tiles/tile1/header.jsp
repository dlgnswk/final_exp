<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>
	
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/index/com_index.css" >
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/css/jh/header/header.css" >

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 재훈 : 페이지 로드시 인원 선택창 가리기
		$("div.my_info").hide();
	
		// 재훈 : 인원 선택창 클릭시 선택화면 보이기
		$("button#btn_my_info").click(function(e) {
			$("div.my_info").show();
		});
		
	});
	
	// Function Declaration
	$(document).mouseup(function (e) {
		var movewrap = $("div.my_info");
		if (movewrap.has(e.target).length === 0) {
			movewrap.hide();
		}
	});
	
	
</script>

<%-- 상단 네비게이션 시작 --%>
<header id="headerOfheader" class="global-navigation-site-header">
	<div class="global-navigation-site-header-container">
		<section class="global-navigation-row primary">
			<div class="global-navigation-row-container">
				<div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-flex-wrap-nowrap uitk-spacing uitk-spacing-margin-unset uitk-spacing-padding-inlinestart-six uitk-spacing-padding-small-inlineend-three uitk-spacing-padding-medium-inlineend-three uitk-spacing-padding-large-inlineend-two uitk-spacing-padding-extra_large-inlineend-two uitk-layout-flex-item uitk-layout-flex-item-flex-grow-1">
					
					<%-- expedia 로고 --%>
					<a class="uitk-header-brand-logo" href="<%= ctxPath%>/index.exp" data-testid="header-brand-logo-anchor">
						<img src="https://www.expedia.co.kr/_dms/header/logo.svg?locale=ko_KR&amp;siteid=16&amp;2&amp;6f9ec7db" alt="expedia 로고">
					</a>
					
					<%-- 우측 메뉴 시작 --%>
					<div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-justify-content-flex-end uitk-layout-flex-flex-wrap-nowrap uitk-layout-flex-item uitk-layout-flex-item-flex-basis-full_width uitk-layout-flex-item-flex-grow-1">
						
						<%-- 숙박시설 등록하기 URL --%>
						<a href="#" target="_blank" rel="noopener" data-stid="listYourProperty-link" data-context="global_navigation"
							class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-as-link uitk-button-tertiary uitk-layout-flex-item global-navigation-nav-button uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
							<div class="uitk-text uitk-type-300 uitk-text-default-theme">숙박 시설 등록하기</div>
						</a>
						
						<%-- 내 여행 URL --%>
						<a href="<%= ctxPath%>/trip.exp" target="_self" rel="" data-stid="itinerary-link" data-context="global_navigation" class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-as-link uitk-button-tertiary uitk-layout-flex-item global-navigation-nav-button uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
							<div class="uitk-text uitk-type-300 uitk-text-default-theme">내 여행</div>
						</a>
						
						<%-- 로그인 메뉴 시작 --%>
						<div class="uitk-layout-flex-item uitk-layout-flex-item-flex-grow-0 uitk-menu uitk-menu-mounted" id="">
							
							<%-- 로그인 안 된 경우 --%>
							<c:if test="${sessionScope.loginuser == null}">
								<button aria-expanded="false" data-context="global_navigation"  type="button" class="uitk-button uitk-button-large uitk-button-tertiary global-navigation-nav-button">
									<a href="<%=ctxPath%>/login.exp" class="uitk-text truncate uitk-type-300 uitk-text-default-theme uitk-text-loyalty-lowtier uitk-layout-flex-item uitk-layout-flex-item-max-width-37x">로그인</a>
								</button>
							</c:if>
							
							<%-- 로그인 된 경우 --%>
							<c:if test="${sessionScope.loginuser != null}">
								<%-- 로그인 시 나오는 내 계정 버튼 --%>
								<button tabindex="0" aria-expanded="false" data-context="global_navigation" type="button" id="btn_my_info" class="uitk-button uitk-button-large uitk-button-tertiary uitk-button-tertiary-large-icon uitk-menu-trigger global-navigation-nav-button">
									<div class="uitk-layout-position uitk-layout-position-display-inline-block uitk-layout-position-relative" data-testid="memberprofile-mediumview">
										<div class="uitk-layout-flex uitk-layout-flex-align-items-center uitk-layout-flex-gap-two">
											<svg class="uitk-icon uitk-icon-loyalty-lowtier uitk-layout-flex-item uitk-icon-large uitk-icon-default-theme" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
												<path fill-rule="evenodd" d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm0 3a3 3 0 1 1 0 6 3 3 0 0 1 0-6zM6 15.98a7.2 7.2 0 0 0 12 0c-.03-1.99-4.01-3.08-6-3.08-2 0-5.97 1.09-6 3.08z" clip-rule="evenodd"></path>
											</svg>
											<div class="uitk-layout-flex uitk-layout-flex-align-items-flex-start uitk-layout-flex-flex-direction-column">
												
												<%-- 로그인 유저 아이디 --%>
												<div class="uitk-text truncate uitk-type-300 uitk-text-default-theme uitk-text-loyalty-lowtier uitk-layout-flex-item uitk-layout-flex-item-max-width-37x" style="font-weight: 600;">${sessionScope.loginuser.name}</div>
												
												<%-- 로그인 유저 등급 --%>
												<%--<div class="uitk-text truncate uitk-type-200 uitk-text-default-theme uitk-text-loyalty-lowtier uitk-layout-flex-item">${sessionScope.loginuser.user_lvl}</div>
												 --%>
												
											</div>
										</div>
									</div>
								</button>
							
								<%-- 내 계정 버튼을 클릭시 나오는 메뉴 시작 --%>
								<div class="my_info">
									<div>
										<div>
											<%-- 내 정보 보여주기 --%>
											<div id="my_info_div">
												
												<%-- 회원명 --%>
												<div id="my_info_name">
													안녕하세요, <span style="font-weight: 600;">${sessionScope.loginuser.name}</span> 님
												</div>
												
												<%-- 회원아이디 --%>
												<div id="my_info_userid">
													${sessionScope.loginuser.userid}
												</div>
												
												<%-- 회원등급 --%>
												<div id="my_info_user_lvl">
													<a href="#" class="uitk-button uitk-button-medium uitk-button-as-link uitk-spacing uitk-spacing-margin-blockstart-one">
													
													<%-- 블루 --%>
													<c:if test="${sessionScope.loginuser.user_lvl eq '블루'}">
														<span class="uitk-badge uitk-badge-large uitk-badge-loyalty-low-tier uitk-badge-has-text">
															<span class="uitk-badge-text" aria-hidden="false">블루 회원</span>
														</span>
													</c:if>
													
													<%-- 실버 --%>
													<c:if test="${sessionScope.loginuser.user_lvl eq '실버'}">
														<span class="uitk-badge uitk-badge-large uitk-badge-loyalty-middle-tier uitk-badge-has-text">
															<span class="uitk-badge-text" aria-hidden="false">실버 회원</span>
														</span>
													</c:if>
													
													<%-- 골드 --%>
													<c:if test="${sessionScope.loginuser.user_lvl eq '골드'}">
														<span class="uitk-badge uitk-badge-large uitk-badge-loyalty-high-tier uitk-badge-has-text">
															<span class="uitk-badge-text" aria-hidden="false">골드 회원</span>
														</span>
													</c:if>
													
													</a>
												</div>
												
												<%-- 회원포인트 --%>
												<%-- <button aria-label="이는 보유하신 익스피디아 리워드 포인트가 익스피디아 예약에 사용될 때 가치가 얼마인지를 나타냅니다." data-context="global_navigation" type="button" class="uitk-button uitk-button-medium uitk-button-has-text uitk-button-tertiary"> --%>
												<div class="uitk-text uitk-type-300 uitk-type-regular uitk-text-default-theme" style="display: inline-block;">포인트 금액&nbsp;&nbsp;</div>
													<%-- 
													<svg class="uitk-icon uitk-spacing uitk-spacing-padding-inlinestart-two uitk-icon-small" aria-label="points value information" role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
														<title id="포인트 금액-title">points value information</title>
														<path fill-rule="evenodd" d="M2 12a10 10 0 1 1 20 0 10 10 0 0 1-20 0zm11-1v6h-2v-6h2zm-1 9a8.01 8.01 0 0 1 0-16 8.01 8.01 0 0 1 0 16zm1-13v2h-2V7h2z" clip-rule="evenodd"></path>
													</svg>
													 --%>
												<%-- </button> --%>
												<div id="my_info_point" style="display: inline-block;">
													<span>&#8361; <fmt:formatNumber value="${sessionScope.loginuser.point}" pattern="#,###" /></span>
												</div>
												
												
											</div>
											
											<hr class="uitk-spacing uitk-spacing-margin-block-four uitk-spacing-border-blockstart uitk-spacing-hr">
											
											<%-- 계정 페이지 --%>
											<div class="uitk-layout-flex-item uitk-list uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
												<a role="link" aria-label="계정" data-stid="account-myaccount-link" href="#" target="_self" rel="" class="uitk-link uitk-list-item uitk-link-align-left uitk-link-layout-default uitk-link-medium">
													<div class="uitk-text uitk-type-300 uitk-text-default-theme">계정</div>
												</a>
											</div>
											
											<%-- 즐겨찾기 목록 페이지 --%>
											<div class="uitk-layout-flex-item uitk-list uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
												<a role="link" aria-label="즐겨찾기 목록" data-stid="list-link" href="#" target="_self" rel="" class="uitk-link uitk-list-item uitk-link-align-left uitk-link-layout-default uitk-link-medium">
													<div class="uitk-text uitk-type-300 uitk-text-default-theme">즐겨찾기 목록</div>
												</a>
											</div>
											
											<%-- 고객의견 페이지 --%>
											<div class="uitk-layout-flex-item uitk-list uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
												<a role="link" aria-label="고객 의견" data-stid="support-feedback-link" href="/p/info-other/feedback.htm" target="_blank" rel="noopener" class="uitk-link uitk-list-item uitk-link-align-left uitk-link-layout-default uitk-link-medium">
													<div class="uitk-text uitk-type-300 uitk-text-default-theme">고객 의견</div>
												</a>
											</div>
											
											<hr class="uitk-spacing uitk-spacing-margin-block-four uitk-spacing-border-blockstart uitk-spacing-hr">
											
											<%-- 로그아웃 버튼 --%>
											<div class="uitk-layout-flex-item uitk-list uitk-layout-flex-item-flex-basis-zero uitk-layout-flex-item-flex-grow-0">
												<a role="link" aria-label="로그아웃" data-stid="account-signout-link" href="/user/logout?&amp;uurl=e3id%3Dredr%26rurl%3D%2Faccount%2Fprofile%3Fedit%3Dbasic-information" target="_self" rel="" class="uitk-link uitk-list-item uitk-link-align-left uitk-link-layout-default uitk-link-medium">
													<div class="uitk-text uitk-type-300 uitk-text-default-theme">로그아웃</div>
												</a>
											</div>
											
										</div>
									</div>
								</div>
								<%-- 내 계정 버튼을 클릭시 나오는 메뉴   끝 --%>
							
							</c:if>
							
						</div>
						<%-- 로그인 메뉴   끝 --%>
						
					</div>
					<%-- 우측 메뉴  끝 --%>
					
				</div>
			</div>
		</section>
	</div>
</header>
<%-- 상단 네비게이션 끝 --%>
