<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /expedia
%>  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">


<style>
	
	div#tripboard {
	margin: 0, auto;
	width: 90%;
	padding-left: 10%;
	font-family: Noto Sans;
	}
	
	table {
    border-spacing: 0;
    border-collapse: collapse;
    box-sizing: border-box;
    border-top: 1px solid black;
    margin: 0, auto;
    width: 100%;
	}
	
	table.tbl_tripboard th {
    height: 60px;
    padding: 0 20px;
    border-bottom: 1px solid #ddd;
    background: #f7f7f7;
    color: #222;
    text-align: center;
    font-weight: bold;
	}
	
	table.tbl_tripboard tr:hover {
	cursor: pointer;
	background-color: rgba(0, 0, 0, 0.06);
	}	
	
	table.tbl_tripboard td {
    height: 60px;
    padding: 0 20px;
    line-height: 25px;
    border-bottom: 1px solid #ddd;
    letter-spacing: -0.02em;
    text-align: center;
    vertical-align: middle;
    font-weight: normal;	
	}
	
	
	#tripboard > form > button {
	  background-color: #0073ff;
	  height: 35px;
	  color: white;
	  width: 40px;
	  margin: 0 0 0.7% 0.5%;
	  border: 0px solid #555555;
	  border-radius: 35%;
	  font-size: 14px;
	}
	
	
	#tripboard > form > button:hover {
  	background-color:rgba(0, 80, 190, 0.97);
  	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.08);
  	}
	
</style>
<div style="inline-size: 100%; margin: 0 auto; max-inline-size: 85rem; padding: 50px 0;">
	
	
	
	<div id="tripboard">		
		
		<h2 style="margin-bottom: 30px;">여행 후기</h2>		
		
		<table class="tbl_tripboard">
			
			<thead>
							
				<tr style="text-align:center;">
					<th style="width: 13%;">글 번호</th>
					<th style="width: 10%;">지역</th>
					<th style="width: 37%;">글 제목</th>
					<th style="width: 15%;">작성자</th>
					<th style="width: 15%;">글 등록일</th>
					<th style="width: 10%;">조회 수</th>
				</tr>
			</thead>
			<tbody>
				<tr onclick="<%= ctxPath%>/tbview.exp">
					<td>31</td>
					<td>속초</td>
					<td>속초여행 후기</td>
					<td>임*혁</td>
					<td class="date">2023.11.12</td>
					<td class="readcount">13</td>
				</tr>
			</tbody>	
		</table>
		
		<%-- === 페이지바 보여주기 === --%>
	    <div align="center" style="border: solid 0px gray; width: 80%; margin: 30px auto;"> 
	        ${requestScope.pageBar}
	    </div>	
		
		<%-- === 검색 폼 추가  === --%>
		<form name="searchFrm" style="margin-top: 20px;">
				<select name="searchType" style="height: 30px;">
					<option value="city">도시</option>
					<option value="subject">글제목</option>
					<option value="content">글내용</option>			
					<option value="subject_content">글제목+글내용</option>
					<option value="name">글쓴이</option>
				</select>
				<input type="text" name="searchWord" style="height: 30px;" size="38" autocomplete="off" /> 
				<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 				
				<button type="button" onclick="goSearch()">
				<span aria-hidden="true">
					<!-- <svg class="uitk-icon uitk-icon-leading" aria-hidden="true" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path fill-rule="evenodd" d="M14.71 14h.79l4.99 5L19 20.49l-5-4.99v-.79l-.27-.28a6.5 6.5 0 1 1 .7-.7l.28.27zM5 9.5a4.5 4.5 0 1 0 8.99.01A4.5 4.5 0 0 0 5 9.5z" clip-rule="evenodd"></path></svg> -->
					검색
				</span>
				</button>
						   </form>	
	</div>
	
	
	
</div>