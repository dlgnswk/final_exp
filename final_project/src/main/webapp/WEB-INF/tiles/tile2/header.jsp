<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<%-- 상단 네비게이션 시작 --%>
<nav class="navbar navbar-expand-sm" style="min-block-size: 4.5rem; box-shadow: 1px 1px 10px 3px #e4e4e4; padding: 0px 24px; border-bottom: 1px solid #b6b6b6">
	<a class="navbar-brand" href="#" style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 0.5rem 0.75rem 0.5rem 0;">
		<img class="ulx-header__image" src="https://apps.expediapartnercentral.com/list/static/images/eg-logo-blue.svg" alt="Expedia group header logo" width="178" height="32">
	</a>
	

  <%-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 이메일 주소를 출력하기 === --%>
   <c:if test="${not empty sessionScope.loginuser}">
	  <div style="float: right; font-size: 9pt;">
		 <span style="color: navy; font-weight: bold;">${sessionScope.loginuser.email}</span> 님<br>로그인중.. 
	  </div>
   </c:if>
	
</nav>
<%-- 상단 네비게이션 끝 --%>			       
    