<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="select_box">
		
		<div>
			<div style="border: 1px solid lightgray; height: 200px; border-radius: 1rem;">
				
				<!-- 팝업띄우는 버튼 -->
			<div id="btnWrap">
			  <button typ="button" id="popupBtn">모달 팝업 띄우기</button> //팝업을 띄우기 위한 버튼
			</div>

			 <!-- 모달 팝업창 -->
			<div id="modalWrap">
			  <div id="modalContent">
			    <div id="modalBody">
			      <span id="closeBtn">&times;</span> //닫기 버튼
			      <p>modal-popup 입니다.</p> //팝업창 내 글귀
			    </div>
			  </div>
			</div>
				
			</div>
		</div>
		
	</div>
	
</div>