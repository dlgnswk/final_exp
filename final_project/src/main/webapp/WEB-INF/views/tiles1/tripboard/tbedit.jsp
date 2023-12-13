<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 50px 0;">

	<div id="select_box">

		<div style="display:flex;">
	<div style="margin: auto; padding-left:3%;">
		

			<h2 style="margin-bottom: 30px;">여행후기 작성</h2>

	<%--	<form name="addFrm">  --%>
	<%-- === #149. 파일 첨부하기 === 
	 	먼저 위의 <form name="addFrm"> 을 주석처리 한 뒤에 아래와 같이 해야한다.
	 	enctype="multipart/form-data" 를 반드시 해주어야만, 파일첨부가 되어진다.	 
	 --%>
	 <form name="addFrm" enctype="multipart/form-data">  		
			<table style="width: 1024px" class="table table-bordered">
      			<tr>
         			<th style="width: 15%; background: #f7f7f7;"><span style="color:red;">* </span>성명</th>
         			<td>
         			   <input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly /> <%-- readonly는 읽기 전용 => input 태그 안에 있는 내용 못바꾸게 설정 --%>
         			   <input type="text" name="name" value="${sessionScope.loginuser.name}" readonly /> <%-- readonly는 읽기 전용 => input 태그 안에 있는 내용 못바꾸게 설정 --%>        			
         			</td>
				</tr>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;"><span style="color:red;">* </span>지역</th>
         			<td>
         			   <input type="text" name="city" size="35" placeholder="도시 이름을 입력하세요. ex) 서울, 부산" autocomplete="off"/>        			
         			</td>
				</tr>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;" size="100" maxlength="200"><span style="color:red;">* </span>제목</th>
         			<td>
							<input type="text" name="subject" size="100" maxlength="200" placeholder="제목을 입력해주세요" autocomplete="off"/> 
         			</td>
				</tr>
				<%-- !!!  textarea 태그에서 required="required" 속성을 사용하면 
                       	 스마트 에디터는 오류가 발생하므로 사용하지 않는다. !!! --%>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;"><span style="color:red;">* </span>내용</th>
         			<td>
         				<textarea style="width:100%; height:300px;" name="content" id="content" placeholder="내용을 입력해주세요" autocomplete="off"></textarea>
         			</td>
				</tr>
				
				<%-- === #150. 파일첨부 타입 추가하기 === --%>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;">파일첨부</th>
         			<td>
         				<input type="file" name="attach" /> 
         			</td>
				</tr>	
				
				<tr>
         			<th style="width: 15%; background: #f7f7f7;"><span style="color:red;">* </span>글암호</th>
         			<td>
         				<input type="password" name="pw" maxlength="20" /> 
         			</td>
				</tr>				
			</table>
			
			
			<div style="margin: 20px;">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">수정완료</button>
				<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
			</div>	
		</form>
	</div>
</div>

		
	</div>
	
</div>


