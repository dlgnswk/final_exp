<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<style>
	
	table {
    border-spacing: 0;
    border-collapse: collapse;
    box-sizing: border-box;
    border-top: 1px solid black;
	}
	
	table.tbl_tripboard th {
    height: 60px;
    padding: 0 20px;
    border-bottom: 1px solid #ddd;
    background: #f7f7f7;
    color: #222;
    text-align: center;
	}

	table.tbl_tripboard td {
    height: 60px;
    padding: 0 20px;
    line-height: 25px;
    border-bottom: 1px solid #ddd;
    letter-spacing: -0.02em;
    text-align: center;
    vertical-align: middle;	
	}
	
	
</style>
<div style="inline-size: 100%; margin: 0 auto; max-inline-size: 85rem; padding: 50px 0;">
	
	<h2 style="margin-bottom: 30px;">나의 여행기</h2>
	
	<div id="tripboard" style="width:90%;">		
				
		<table class="tbl_tripboard">
			<thead>
							
				<tr style="text-align:center;">
					<th>글 번호</th>
					<th>지역</th>
					<th>글 제목</th>
					<th>글 작성일</th>
					<th>글 등록일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>31</td>
					<td>속초</td>
					<td>속초여행 후기</td>
					<td>임*혁</td>
					<td class="date">2023.11.12</td>
				</tr>
			</tbody>
		</table>
		
	
	
	<form name="nationsearchFrm" style="margin-top: 20px;">
		<select name="nationsearchType" style="height: 26px;">
			<option value="city">도시</option>
			<option value="subject">글제목</option>
			<option value="content">글내용</option>			
			<option value="subject_content">글제목+글내용</option>
			<option value="name">글쓴이</option>
		</select>
	</form> 
	
	</div>
</div>