<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	String ctxPath = request.getContextPath();
    //      /board
%>  

<script src="https://kit.fontawesome.com/cba4097ef6.js" crossorigin="anonymous"></script>

<style>	
	.content_block {
    position: relative;
    width: 90%;
    min-height: 600px;
    margin: 0 auto;
	}
	
	.page_navigation {
    width: 90%;
    height: 25px;
    margin: auto;
    text-align: right;
	}
	
	a:link,
	a:visited,
	a:active,
	a {
	  color: black;
	}
	
	a:hover{
	text-decoration-line : underline;
	color: black;
	}
	
	ul {
    list-style: none;
	}
	
	ul.page_nav li {
    display: inline-block;
    height: 50px;
    line-height: 50px;
    padding-left: 20px;
    font-size: 14px;
    color: #777;
	}
	
	div {
    display: block;
	}
	
	
	
	.tit_con_title {
    margin-bottom: 20px;
    line-height: 1;
    font-size: 32px;
    color: #222;
	}
	
	.cont_travel_review .brd_title {
	border-top: 2px solid #222;
	}
	
	brd_title .tag {
    position: static;
    display: inline-block;
    margin: -5px 5px 0 0;
    vertical-align: middle;
	}
	
	.brd_title {
    position: relative;
    height: 80px;
    padding: 0 20px;   
    font-size: 18px;
	}
	
	#content > div > h4 > span > h5 {
	margin-top: 15px;
	}
	
	brd_editor {
    border-top: 1px solid #222;
    border-bottom: 1px solid #222;
	}
	
	.report_box {
    display: flex;
    padding: 0 20px;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid #ddd;
	}
	
	
	.cont_travel_review .like_wrap {
    position: relative;
    display: flex;
    margin-bottom: 40px;
    justify-content: center;
    align-items: center;
	}
	
	.cont_travel_review .editor_travel .report_box {
    padding-top: 22px;
	}
	
	.cont_travel_review .brd_right {
    position: absolute;
    display: flex;
    right: 20px;
    top: 30px;
    font-size: 15px;
    }
    
    .cont_travel_review .brd_right span {
    position: relative;
    padding: 0 15px;
    }
    
    .cont_travel_review .brd_right span:last-child {
    padding: 0 0 0 15px;
    }
    
    .editor_area {
    min-height: 300px;
    padding: 40px 20px;
    margin-bottom: 40px;
    line-height: 25px;
    border-bottom: 2px solid #222;
	}
    
    .cont_travel_review .like_wrap div {
    position: relative;
    display: flex;
    padding: 10px 40px;
    justify-content: center;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 30px;
	}
    
    .cont_travel_review .like_wrap p {
    padding-right: 20px;
    padding-top: 15px;
    color: #222;
	}
	
	table {
    border-spacing: 0;
    border-collapse: collapse;
    box-sizing: border-box;
	}
	
	.tbl_cell {
    width: 780px;
    height: 80px;
    display: table-cell;
    line-height: 1.4;
    vertical-align: middle;
	}
	
	table.tbl_pren {
    width: 100%;
    margin: 50px 0 20px 0;
    border-top: 1px solid #ddd;
	}
	
	tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
	}
	
	table.tbl_pren th {
    height: 60px;
    padding: 0 20px;
    border-bottom: 1px solid #ddd;
    color: #222;
    text-align: left;
	}
	
	table.tbl_pren td {
    position: relative;
    height: 60px;
    padding: 0 20px;
    border-bottom: 1px solid #ddd;
    vertical-align: middle;
    text-align: left;
	}
	
	/* 드롭다운 메뉴 예시 스타일 */

	
	.dropdown_content {
    position: absolute;
    display: none;
    width: 157px;
    background-color: white;
    border-radius: 4px;
    box-shadow: 4px 4px 10px #c5b0b0;
    animation: fade-in 1s ease;
    right: 0; /* 오른쪽에 위치하도록 설정 */
    z-index: 1; /* 다른 요소 위에 나타나도록 z-index 설정 */
	}

	#tbedit, #tbdelete {
	    text-align: left;
	    color: black;
	    padding: 0.5rem;
	    text-decoration: none;
	    display: block;
	    font-size: 16px;
	}
	
	
	#dropdownMenuButton{
	border: 0px solid black;
	border-radius: 70%;
	background-color: rgba(0, 0, 0, 0);
	}
	
	#dropdownMenuButton:hover {
	cursor: pointer;
	background-color: rgba(0, 0, 0, 0.06);
	}
	
	/* 드롭다운 메뉴 예시 스타일 */
	
	#tbedit:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	#tbdelete:hover {
		border: 0px solid black;
		border-radius: 6px;
		cursor: pointer;
		background-color: rgba(0, 0, 0, 0.06);
	}
	
	
	/* 목록버튼 css */
	#btnList {
	  background-color: #0073ff;
	  height: 30.7px;
	  color: white;
	  width: 55px;
	  margin: 0 0 0.7% 0.8%;
	  border: 0px solid #555555;
	  border-radius: 5px;
	  font-size: 14px;
	}
	#btnList:hover {
  	background-color:rgba(0, 80, 190, 0.97);
  	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.08);
  	}
  	
  	/* 모달 css 시작*/
  	.tbdeleteModal{ 
	  position:absolute; 
	  width:100%; 
	  height:100%; 
	  background: rgba(0,0,0,0.8); 
	  top:0; 
	  left:0; 
	  display:none;
	  z-index: 100;
	}
	
	body.modal-open {
  		overflow: hidden; /* 페이지 스크롤 막기 */
	}
	
	.tbdeleteModal_header{
	  width:500px; 
	  height:300px;
	  background:#fff; 
	  border-radius:10px;
	  position:relative; 
	  top:50%; 
	  left:50%;
	  margin-top:-150px;  /* height의 절반 */
	  margin-left:-250px; /* width의 절반 */
	  text-align:center;
	  box-sizing:border-box; 
	  padding:74px 0;
	  line-height:23px; 
	  cursor:pointer;
	}
	
	.tbdeleteModal_body{
	  width:500px; 
	  height:300px;
	  background:#fff; 
	  border-radius:10px;
	  position:relative; 
	  top:50%; 
	  left:50%;
	  margin-top:-150px;  /* height의 절반 */
	  margin-left:-250px; /* width의 절반 */
	  text-align:center;
	  box-sizing:border-box; 
	  padding:74px 0;
	  line-height:23px; 
	  cursor:pointer;
	}
	
	
	#mycontent > div.tbdeleteModal > div > span {
	position: absolute; 
	top: 15px; right: 15px;
	}
	
	#btn_tbdel {
	  background-color: #0073ff;
	  height: 40px;
	  color: white;
	  width: 70px;
	  border: 0px solid #555555;
	  border-radius: 17px;
	  font-size: 14px;
	}
	
	#btn_tbdelconfirm {
	  background-color: #0073ff;
	  height: 40px;
	  color: white;
	  width: 80px;
	  border: 0px solid #555555;
	  border-radius: 17px;
	  font-size: 14px;
	}
	#btn_tbdel:hover, #btn_tbdelconfirm:hover {
  	background-color:rgba(0, 80, 190, 0.97);
  	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.08);
  	}
  	
	#btn_cancel, #btn_cancelconfirm {
	  background-color: #8e979c;
	  height: 40px;
	  margin-left: 5%;
	  color: white;
	  width: 70px;
	  border: 0px solid #555555;
	  border-radius: 17px;
	  font-size: 14px;
	}
	
	#btn_cancel:hover, #btn_cancelconfirm:hover {
  	background-color:rgba(94, 110, 128, 1);
  	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.08);
  	}
  	
  	#mycontent > div.tbdeleteModal > div.tbdeleteModal_body > p > input[type=password] {
  	width: 40%;
  	height: 30px;
  	}
  	
	/* 모달 css 끝*/
	
	/* 좋아요 css 시작  */
	
	/* 추가적인 스타일링을 하실 수 있습니다. */
    
	/* 좋아요 css 끝  */
</style>

<script type="text/javascript">
	  
$(document).ready(function() {
    var dropdown = document.querySelector(".dropdown_bar");
    var dropdownContent = document.querySelector(".dropdown_content");
    var modal = document.querySelector(".tbdeleteModal");
    
    dropdown.addEventListener("click", function(event) {
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            dropdownContent.style.display = "block";
        }
        event.stopPropagation(); // 이벤트 버블링 방지
    });

    // 문서의 다른 영역을 클릭했을 때 드롭다운을 닫음
    document.addEventListener("click", function(event) {
        if (!dropdown.contains(event.target) && event.target !== dropdownContent) {
            dropdownContent.style.display = "none";
        }
    });
    
    // 삭제 버튼 클릭 시 모달 열기
    $("div#tbdelete").click(function() {
        $(".tbdeleteModal").fadeIn();
        $(".tbdeleteModal_header").show(); // 삭제 버튼 클릭 시 헤더 영역 보이기
        $(".tbdeleteModal_body").hide(); // 삭제 버튼 클릭 시 바디 영역 숨기기
        $("body").addClass("modal-open"); // body에 modal-open 클래스 추가
    });
    
    // 삭제 모달 내 '삭제' 버튼 클릭 시 동작
    $("#btn_tbdel").click(function() {
        $(".tbdeleteModal_header").hide(); // 헤더 영역 숨기기
        $(".tbdeleteModal_body").show(); // 바디 영역 보이기
    });
    
    // 삭제 모달 내 header에서 '취소' 버튼 클릭 시 동작
    $("#btn_cancel").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    // 삭제 모달 내 body에서 '취소' 버튼 클릭 시 동작
    $("#btn_cancelconfirm").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    // 모달의 닫기 버튼 클릭 시 모달 닫기
    $("span.close").click(function() {
        $(".tbdeleteModal").fadeOut();
        $("body").removeClass("modal-open"); // body에서 modal-open 클래스 제거
    });
    
    
    // 삭제 모달 내 '삭제' 버튼 클릭 시 동작 (필요한 경우)
    $("#confirmDelete").click(function() {
        // 삭제 기능 구현
    });
});
	
	
	
	
</script>

<div style="inline-size: 100%; margin: auto; max-inline-size: 85rem; padding: 30px 0;">

	<div id="select_box">
		<div id="container">
			<div class="page_navigation">
				<ul class="page_nav">
					<li><a href="<%= ctxPath%>/index.exp">홈</a></li>
					<li>></li>
					<li><a href="<%= ctxPath%>/tripboard.exp">여행 후기</a></li>
				</ul>
			</div>
			<div class="content_block" id="content">
				<div class="dropdown_main">
					<div class="dropdown_bar">														
						<h3 class="tit_con_title">여행 후기
						<button style="height:30px; float:right; margin-top:15px;" type="button" id="dropdownMenuButton" >
							<svg style="float:right;" viewBox="0 0 24 24" width="20px" height="20px" class="d Vb UmNoP"><path d="M5 14a2 2 0 100-4 2 2 0 000 4zM19 14a2 2 0 100-4 2 2 0 000 4zM12 14a2 2 0 100-4 2 2 0 000 4z"></path></svg>
						</button>
						</h3>							  																
					</div>
					<div class="dropdown_content">
						    <a id="tbedit" href="#">후기수정</a>
        					<div id="tbdelete">후기삭제</div>
			  		</div>	
				</div>	
				
				<div id="tooltip" style="display: none; position: absolute; background-color: #f1f1f1; padding: 10px; border-radius: 6px;"></div>
				
			         <div class="cont_travel_review">
			                 <h4 class="brd_title" style="font-weight: normal;">
				              <span class="tbl_cell">
	                         <span class="tag"></span>
	                         	제목보다 내용이 중요하죠.
	                    	 </span>
								<div class="brd_right">
				                     <span>이*진 님</span>
				                    <span>2023.12.05</span>
									<span>조회 <em>4</em></span>
			                    </div>
			                 </h4>
			                 <div class="brd_editor editor_travel">
									<!-- 고객 작성 후기인 경우 -->
									<div class="report_box">
										<div class="txt_guide">
											아래 내용은 고객님께서 직접 다녀오신 여행 상품에 대해 작성하신 후기입니다.
										</div>
				                    </div>
							        <!-- // 고객 작성 후기인 경우 -->
			                     <div class="editor_area">
			                         <p> 내용 샬라 샬라</p>
			                     </div>
			                 </div>
			            
			            
				            <!-- 후기 좋아요 -->
				            <div class="like_wrap">
								<div>
									<p>후기가 도움 되었나요?</p>
									<div class="likebtn">
										<button type="button" class="btn_like" id="btnLike">좋아요</button>&nbsp;&nbsp;
										<span class="likeCnt" id="likeCnt">0</span>																			
									</div>
									
									
								</div>
							</div>
				            <!-- // 후기 좋아요 -->
								
				            <table class="tbl_pren">
					            <colgroup>
						            <col style="width:100px">
						            <col>
					            </colgroup>
				           		<tbody>
									 <tr>
						                <th scope="row">이전 글</th>		                
						                
						                <td>이전 글이 없습니다</td>
						            </tr>
			
									<tr>
						                <th scope="row">다음 글</th>
						                <td><a href="">처음간 방콕 또 가고싶은 방콕</a></td>
						                		                
						            </tr>
					            </tbody>
				            </table>
				            <div class="btn_area">                
								<button type="button" class="btn_cof" id="btnList" onclick=""><span aria-hidden="true">목록</span></button>
				            </div>				            				            
				 	 </div>
				 	 
			  </div> 
		</div>		
	</div>
						
</div>

						<!-- 삭제 모달 창 구현 -->
				 	 <div class="tbdeleteModal">				 	 		  				 	 		  		                            
                              <div class="tbdeleteModal_header">
                               <span class="close">&times;</span>                                                       	                              	                             	
                              	<h3>여행후기를 삭제하시겠습니까?</h3>                              
	                             <p style="margin-top:10%;">
	                             	<button id="btn_tbdel">삭제</button>
	                              	<button id="btn_cancel">취소</button>
	                             </p> 		                              	
                              </div>
                              <div class="tbdeleteModal_body">
                               <span class="close">&times;</span>                                                       	                              	                             	
                              	<h3>비밀번호를 입력하세요</h3>                              
	                             <p style="margin-top:5%;">
	                             	<input type="password" name="pw" maxlength="20" />	                           	
	                             </p>
	                             <div class="confirmbtn"style="margin-top:5%;">
		                             <button id="btn_tbdelconfirm">삭제완료</button>
		                         	 <button id="btn_cancelconfirm">취소</button> 		                              	
                              	 </div>
                              </div>                                                            
                     </div>