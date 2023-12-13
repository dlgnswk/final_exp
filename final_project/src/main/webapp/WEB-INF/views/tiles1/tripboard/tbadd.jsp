<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- === #166. 스마트 에디터 구현 시작 === --%>
		  
			//전역변수
	       var obj = [];
	       
	       //스마트에디터 프레임생성
	       nhn.husky.EZCreator.createInIFrame({
	           oAppRef: obj,
	           elPlaceHolder: "content",
	           sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	           htParams : {
	               // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseToolbar : true,            
	               // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseVerticalResizer : true,    
	               // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseModeChanger : true,
	           }
	       });
	       
	      <%-- === 스마트 에디터 구현 끝 === --%>
		  
	   // 글쓰기 버튼
		$("button#btnWrite").click(function(){
			
			<%-- === 스마트 에디터 구현 시작 === --%>
	         // id가 content인 textarea에 에디터에서 대입
	           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        <%-- === 스마트 에디터 구현 끝 === --%>
			
	        
			// 글제목 유효성 검사 
			const subject = $("input:text[name='subject']").val().trim(); 
			
			if(subject == "") {
				alert("글 제목을 입력하세요!!");
				return; // 종료
			}
	        
			// 글내용 유효성 검사 (스마트에디터 사용할 경우)
			<%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 === --%>
            let contentval = $("textarea#content").val();
			
         	// 글내용 유효성 검사 하기 
            // alert(contentval); // content에  공백만 여러개를 입력하여 쓰기할 경우 알아보는것.
            // <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p> 이라고 나온다.
          
            contentval = contentval.replace(/&nbsp;/gi, ""); // 공백을 "" 으로 변환
            /*    
	                           대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	             ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                           그리고 뒤의 gi는 다음을 의미합니다.
	         
	              g : 전체 모든 문자열을 변경 global
	              i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
          	*/ 
         	// alert(contentval);
         	// <p>             </p>
          
            contentval = contentval.substring(contentval.indexOf("<p>")+3);
            contentval = contentval.substring(0, contentval.indexOf("</p>"));
                   
            if(contentval.trim().length == 0) {
                alert("글내용을 입력하세요!!");
               return;
            }
            
            <%-- === 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 === --%>
            
            
			// 글 암호 유효성 검사
			const pw = $("input:password[name='pw']").val(); 			 
			if(pw == "") {
				alert("글 암호을 입력하세요!!");
				return; // 종료
			}
			
			// 폼 (form)을 적용하자
			const frm = document.addFrm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/tbadd.exp";
			frm.submit();
			
		});
	   
	});// end of $(document).ready(function(){});

</script>

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
         			   <input type="text" name="tb_city" size="35" placeholder="도시 이름을 입력하세요. ex) 서울, 부산" autocomplete="off" />        			
         			</td>
				</tr>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;" size="100" maxlength="200"><span style="color:red;">* </span>제목</th>
         			<td>
							<input type="text" name="tb_subject" size="100" maxlength="200" placeholder="제목을 입력해주세요" autocomplete="off"/> 
         			</td>
				</tr>
				<%-- !!!  textarea 태그에서 required="required" 속성을 사용하면 
                       	 스마트 에디터는 오류가 발생하므로 사용하지 않는다. !!! --%>
				<tr>
         			<th style="width: 15%; background: #f7f7f7;"><span style="color:red;">* </span>내용</th>
         			<td>
         				<textarea style="width:100%; height:300px;" name="tb_content" id="content" placeholder="내용을 입력해주세요" autocomplete="off"></textarea>
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
         				<input type="password" name="tb_pw" maxlength="20" /> 
         			</td>
				</tr>				
			</table>
			
			
			<div style="margin: 20px;">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
				<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
			</div>	
		</form>
	</div>
</div>

		
	</div>
	
</div>