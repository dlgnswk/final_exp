<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<link type="text/css" rel="stylesheet" href="<%= ctxPath%>/resources/css/db/rm_image.css" />

<title>객실 사진 등록</title>

<script type="text/javascript">

	let roomImage_arr = []; 	// 객실 이미지 배열
	
	$(document).ready(function(){
		
		// == roomImage 메인이미지 Drag & Drop 만들기 == //
		$("div#roomImage").on("dragenter", function(e){ /* "dragenter" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 최초로 들어왔을 때 */ 
       		e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){ /* "dragover" 이벤트는 드롭대상인 박스 안에 Drag 한 파일이 머물러 있는 중일 때. 필수이벤트이다. dragover 이벤트를 적용하지 않으면 drop 이벤트가 작동하지 않음 */ 
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#f2f2f2");
	    }).on("dragleave", function(e){ /* "dragleave" 이벤트는 Drag 한 파일이 드롭대상인 박스 밖으로 벗어났을 때  */
			e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#fff");
	    }).on("drop", function(e){      /* "drop" 이벤트는 드롭대상인 박스 안에서 Drag 한것을 Drop(Drag 한 파일(객체)을 놓는것) 했을 때. 필수이벤트이다. */
			e.preventDefault();
	    	const elmt = $(this);
	    	elmt.find("div.infoDiv").hide(); // 안쪽 회색 상자 숨기기	    
	    	
	        var files = e.originalEvent.dataTransfer.files;
	        
	        let check = fileCheck(files);
	        
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	arrDropPush(roomImage_arr, files, elmt);
	       	
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
	        
	    }); // end of drop 이벤트 처리 ----------------------------
		
		// "사진 추가" 버튼 클릭시 input 파일을 클릭한 것으로 한다.		
		$("button.btnAdd").click(function(){
			$(this).next().click();
		});// end of $("button.btnAdd").click(function()
		
				
		// let roomImage_arr = []; 	/ 객실 사진
		// roomImage 객실 "사진 첨부" 클릭
		$("input[name='roomImage']").change(function(){
			$(this).parent().parent().parent().find("div.infoDiv").hide(); // 상자정보 숨기기
		//	console.log($("input[name='mainImage']").get(0).files[0]);
			
			const files = $(this).get(0).files;

			let check = fileCheck(files);
			const elmt = $(this);
			
	       	if( check == false ) {
	       	// 이미지 파일이 아닌경우
	       		alert("해당 파일은 이미지가 아닙니다. 이미지(*.png, *.jpeg) 파일을 등록해 주세요.");
	       		return;
	       	}
	       	else {
	       	// 이미지 파일이 올라온 경우
            	
        		if(files != null && files != undefined){
					//	console.log("files.length 는 => " + files.length);
					arrPush(roomImage_arr, files, elmt);
	        	
	        	}// end of if(files != null && files != undefined)--------------------------
	        
	       	}// end of if( check == false ) else 이미지 파일이 아닌경우 -------------
			
		});// end of $("input[name='mainImage']").change(function()
		
		
				
		// 이미지 삭제 버튼	
		$(document).on("click", "span.delete", function(){
			
			const delIdx = $(this).parent().parent().parent().find("span.delete").index($(this));
			const removeImg = $(this).parent().parent();
		//	console.log(delIdx);   0 1 2 3 4 5 ...
			
			const infoDiv = $(this).parent().parent().parent().find(".infoDiv");
			
		
			let arrName = $(this).parent().parent().parent();
		//	console.log("arrName => " + arrName.attr("id"));
			// arrName => diningImage
			// arrName => outImage
			
			let arrLength;
			
			// "x"버튼의 부모의 id를  찾아서 대응 시킨다.
			if ( arrName.attr("id") == "roomImage") {
			// let mainImage_arr = []; 	// 6 	메인이미지
				roomImage_arr.splice(delIdx,1);
				arrLength = roomImage_arr.length;
			}
			
			if ( arrLength == 0 ) {
				infoDiv.show();
			}
			
			removeImg.remove(); // 이미지 제거하기
			
		}); // end of $(document).on("click", "span.delete", function()
		
				
				
		// 이미지 전체 삭제 버튼
		$("button.btnDelete").click(function(){
			
			const delId = $(this).parent().parent().parent().find("div.image_drop").attr("id");
			const removeImgs = $(this).parent().parent().parent().find("div.image_drop");
			
			// "x"버튼의 부모의 id를  찾아서 대응 시킨다.
			if ( delId == "roomImage") {
			// let roomImage_arr = []; 	// 6 	메인이미지
				roomImage_arr = [];
			}
			
			removeImgs.find(".imageItem").remove(); // 이미지들 전부 지우기
			removeImgs.find(".infoDiv").show();		// "사진 업로드" 다시 보이기
			
		});// end of $("button.btnDelete").click(function()
				
				
	});// end of $(document).ready(function(){

	
	
	// 들어온 파일의 타입을 체크한다.
	function fileCheck(file) {
	
		const fileType = file[0].type; // 파일의 타입이 무엇인지 확인한다.
	//	console.log(typeof fileType); // image.png, image.jpeg
		
		let check = false; // 기본
			
		if( fileType.includes('jpeg') || fileType.includes('png') ) {
		// 파일 타입에 png, jpeg가 포함되어 있으면 이면 체크 true	
			check = true;
		}
		// png, jpeg포함되어 있지 않으면 false이다.
	//	console.log("check => "+ check);
		return check;
	} // end of function fileCheck(file)
	
	
	// "drop" 하는 이벤트 
	function arrDropPush(arr, files, elmt) {
		
		if(files != null && files != undefined){
			//	console.log("files.length 는 => " + files.length);
			
    		let html = "";
        	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다. 
        	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
    	
    		if(fileSize >= 10) {
    			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
    			elmt.css("background-color", "#fff");
    			return;
    		}
    		else {
    		// 하나의 파일은 10MB를 넘지 못한다.
    		
   				arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
        		const fileName = f.name; // 파일명	
       			
               	const fileReader = new FileReader();
               	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
               	
               	let viewFileName = fileName;
	        //  console.log(fileName);
	            // 이그제큐티브 스위트 투베드룸1.png
			//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
	            // 이그제큐티브 스위트 투베드룸1
	        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
				// .png
               	
               	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
				const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
              	// .png
              	
	          	if( fileFrontName.length > 7) {
	          		console.log(fileFrontName);
	          		console.log(fileTypeName);
	          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
	          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
	          	}
               	
   				fileReader.onload = function(){
					/*
		              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
		              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
		          	*/
		          	
		          	html += 
		          		"<div class='imageItem'>" +
   		                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
   		                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
	               		"</div>";
                    
               		elmt.append(html);
                   	// document.getElementById("previewImg").src = fileReader.result;
               		elmt.scrollLeft(99999999); // 스크롤 끝으로
   				}; // end of fileReader.onload = function() -----------
    				
    		
			} // end of if(fileSize >= 10) else ---------- 파일은 10MB
    	
    	}// end of if(files != null && files != undefined)--------------------------
    
    	elmt.css("background-color", "#fff");		
	}// end of function arrDropPush(arr, files, elmt) ----------------------
	
	
	// "사진 추가" 하는 이벤트
	function arrPush(arr, files, elmt) {
		
		let html = "";
    	const f = files[0]; // 어차피 files.length 의 값이 1 이므로 위의 for문을 사용하지 않고 files[0] 을 사용하여 1개만 가져오면 된다.
    	console.log(f);
    	let fileSize = f.size/1024/1024;  /* 파일의 크기는 MB로 나타내기 위하여 /1024/1024 하였음 */
	
		if(fileSize >= 10) {
			alert("10MB 이상인 파일은 업로드할 수 없습니다.!!");
			$(this).css("background-color", "#fff");
			return;
		}
		else {
		// 하나의 파일은 10MB를 넘지 못한다.
				
			arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
       		const fileName = f.name; // 파일명	
   			
           	const fileReader = new FileReader();
           	fileReader.readAsDataURL(files[0]); //  fileReader.result안에 이미지를 저장한다.
           	
           	let viewFileName = fileName;
        //  console.log(fileName);
            // 이그제큐티브 스위트 투베드룸1.png
		//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
            // 이그제큐티브 스위트 투베드룸1
        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
			// .png
           	
           	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
			const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
             	// .png
             	
          	if( fileFrontName.length > 7) {
          		console.log(fileFrontName);
          		console.log(fileTypeName);
          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
          	}
           	
			fileReader.onload = function(){
				/*
	              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
	              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
	          	*/
	          	
	          	html += 
	          		"<div class='imageItem'>" +
	                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
	                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
               		"</div>";
                   
               	elmt.parent().parent().parent().find(".image_drop").append(html);
               	// document.getElementById("previewImg").src = fileReader.result;
               	elmt.parent().parent().parent().find(".image_drop").scrollLeft(99999999); // 스크롤 끝으로
			}; // end of fileReader.onload = function() -----------
				
		} // end of if(fileSize >= 10) else ---------- 파일은 10MB
		
	} // end of function arrLimitPush(arr, files, elmt) ------------------------------------- 이미지 5개 제한 
	
	
	
	// === 사진 등록 하기  === //
	$(document).on("click", "button#image_register", function(){
		
		var formData = new FormData($("form[name='addFrm']").get(0));
		
		console.log(roomImage_arr);
		// 메인 이미지 
		if(roomImage_arr.length > 0) {
			
			roomImage_arr.forEach(function(item){
				// 첨부파일 추가하기 "file_arr" 이 키값이고  item 이 밸류값인데 file_arr 배열속에 저장되어진 배열요소인 파일첨부되어진 파일이 되어진다.
				// 같은 key를 가진 값을 여러 개 넣을 수 있다.(덮어씌워지지 않고 추가가 된다.)
	        	formData.append("roomImage_arr", item);  
	        });
			
		}// end of if(mainImage_arr.length > 0)
			
		const fk_rm_seq = $("select[name='fk_rm_seq']").val();
		formData.append("fk_rm_seq", fk_rm_seq);
	<%--	
		$.ajax({
            url : "<%= ctxPath%>/rm_image.exp",
            type : "post",
            data : formData,
            async: false,
            processData:false,  // 파일 전송시 설정 -> query string(쿼리 스트링) 하지마라
            contentType:false,  // 파일 전송시 설정 
            dataType:"json",
            success:function(json){
          	  	
            	alert("이미지가 성공적으로 등록되었습니다.");
          	  	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
        });
	--%>
	}); // end of $("button#image_register").click(function()
	
			
	
	// 객실 이름이 바뀌면 DB에 기존에 등록되어 있는 이미지 파일명을 가져오는 이벤트
	$(document).on("change","select[name='fk_rm_seq']",function(){
		
		roomImage_arr = [];
		
		$.ajax({
            url : "<%= ctxPath%>/getRmImgData.exp",
            type : "post",
            data : { fk_rm_seq:$("select[name='fk_rm_seq']").val()},
            async: false,
            dataType:"json",
            success:function(json){
            	let elmt = $("input[name='roomImage']");
            	elmt.parent().parent().parent().find(".imageItem").remove();
            	
            	$.each(json, function(index, item){
					console.log(item.rm_img_name +"\n" + item.rm_img_save_name);
            		
				//	new File(source배열, name, option객체 : {type: "text/plain"});
					// File 객체를 생성하는 방법은 크게 2가지 있다. 
					// 1.생성자 , 2.input엘리먼트를 통해 취득
					/*
						source배열 
						- 파일에 저장할 데이터. ArrayBuffer, ArrayBufferView, Blob, DOMString을 요소로 하는 배열을 입력 (UTF-8)
						
						name
						- 파일명이나 파일의 경로를 나타내는 USVString.
						
						option객체:
						- type: MIME 유형을 나타내는 DOMString. 디폴트는 ""
						- lastModified: 최종수정일. 디폴트는 Date.now()
					
					*/
					
					let f = new File([item.rm_img_name],'C:/NCS/workspace_spring_framework/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/final_project/resources/images/'+'${requestScope.fk_lodge_id}'+"/"+item.rm_img_save_name, {type: "image/png",type: "image/jpeg"});
					console.log(f);	
				//	arrPush(roomImage_arr, file, elmt) console.log(roomImage_arr);
						
					roomImage_arr.push(f); //  드롭대상인 박스 안에 첨부파일을 드롭하면 파일들을 담아둘 배열인 file_arr 에 파일들을 저장시키도록 한다.
		       		const fileName = item.rm_img_name; // 파일명	
		   			
		           	const fileReader = new FileReader();
		           	fileReader.readAsDataURL(f); //  fileReader.result안에 이미지를 저장한다.
		           	
		           	let viewFileName = fileName;
		        //  console.log(fileName);
		            // 이그제큐티브 스위트 투베드룸1.png
				//	console.log(fileName.substr(0,fileName.lastIndexOf('.')));
		            // 이그제큐티브 스위트 투베드룸1
		        //	console.log(fileName.substr(fileName.lastIndexOf('.')));
					// .png
		           	
		           	const fileFrontName = viewFileName.substr(0,viewFileName.lastIndexOf('.'));
					const fileTypeName = viewFileName.substr(viewFileName.lastIndexOf('.'));
		             	// .png
		             	
		          	if( fileFrontName.length > 7) {
		          		console.log(fileFrontName);
		          		console.log(fileTypeName);
		          		console.log(fileFrontName.substr(0,6) + "···" + fileTypeName);
		          		viewFileName = fileFrontName.substr(0,6) + "···" + fileTypeName;
		          	}
		           	
					fileReader.onload = function(){
						/*
			              	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
			              	이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
			          	*/
			          	
			          	
			          	console.log("fileReader.result => "+ fileReader.result);
			          	let html = 
			          		"<div class='imageItem'>" +
			                   	"<img class='__image' src='"+fileReader.result+"' />" + // &times;는 X로 보여주는 것이다.
			                   	"<div class='imageName'><span class='delete'>&times;</span><span class='fileName'>"+viewFileName+"</span></div>"
		               		"</div>";
		               		
		               	elmt.parent().parent().parent().find(".image_drop").append(html);
		               	// document.getElementById("previewImg").src = fileReader.result;
		               	elmt.parent().parent().parent().find(".image_drop").scrollLeft(99999999); // 스크롤 끝으로
		               	elmt.parent().parent().parent().find(".infoDiv").hide();
					}; // end of fileReader.onload = function() -----------
					
            	}); // end of $.each(json, function(index, item)
            			
            	console.log(roomImage_arr);
            	
            },
            error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		      }
        });
		
	}); // end of $(document).on("change","select[name='fk_rm_seq']",function(){
			
</script>


<div id="root_container" style="inline-size: 100%; margin: auto; max-inline-size: 75rem; padding: 50px 0;">
	<div class="container">
		<div class="title">
			<h2>객실 사진 등록</h2>
		</div>

		
		<div class="images_div">
			<span class="div_span">
				<select name="fk_rm_seq">
					<c:forEach var="updateRmInfo" items="${updateRmInfoMapList}" >
						<option value="${updateRmInfo.rm_seq}">${updateRmInfo.rm_type}</option>
					</c:forEach>
				</select>
			</span>
			<span class="addText">*가장 먼저 등록한 사진이 객실의 메인사진으로 사용됩니다.</span>
			<div class="image_drop __flex" id="roomImage">
				<div class="infoDiv __flex">
					<div class="verticalMiddle __flex">
						<div class="svgDiv">
							<svg class="__Icon" xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#a6a6a6" d="M149.1 64.8L138.7 96H64C28.7 96 0 124.7 0 160V416c0 35.3 28.7 64 64 64H448c35.3 0 64-28.7 64-64V160c0-35.3-28.7-64-64-64H373.3L362.9 64.8C356.4 45.2 338.1 32 317.4 32H194.6c-20.7 0-39 13.2-45.5 32.8zM256 192a96 96 0 1 1 0 192 96 96 0 1 1 0-192z"/></svg>
							사진 업로드
						</div>
						<div class="dragText">
							사진 추가 또는 이미지 끌어다 놓기
						</div>
					</div>
				</div>
			</div>
			<div class="btnContDiv__ __flex">
				<div class="flexChild">
					<button type="button" class="btnDelete"><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M432 256c0 17.7-14.3 32-32 32L48 288c-17.7 0-32-14.3-32-32s14.3-32 32-32l352 0c17.7 0 32 14.3 32 32z"/></svg>사진 전체 제거</button>
					<button type="button" class="btnAdd" ><svg class="svgCam" xmlns="http://www.w3.org/2000/svg" height="16" width="14" viewBox="0 0 448 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#2667b9" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>사진 추가</button>
					<input type="file" name="roomImage" accept=".jpg, .png" style="display:none;"/>
				</div>
			</div>
		</div>
			
		<form name="addFrm" enctype="multipart/form-data"></form>
		
		<div class="hadan">
			<button id="image_register" type="button">사진 등록</button>
		</div>
	</div>
</div>
