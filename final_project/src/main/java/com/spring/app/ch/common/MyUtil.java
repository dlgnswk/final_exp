package com.spring.app.ch.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();  // Stringbuffer 를 string 으로 바꿔준다.
		// currentURL : http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString(); // 전달되어진 데이터를 말한다.  / ? 이후의 주소
		// System.out.println("queryString => " + queryString);
		// queryString => searchType=name&searchWord=%EC%B1%84%ED%98%81&sizePerPage=5&currentShowPageNo=7
		// queryString => null (POST 방식인 경우)
		
		if(queryString != null) {  // GET 방식일 경우
			currentURL += "?"+queryString;
		// currentURL = http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=%EC%B1%84%ED%98%81&sizePerPage=5&currentShowPageNo=7	
		}
		
		String ctxPath = request.getContextPath();
		//  /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();  // 문자열 길이
		//    27       =                   21        +          6
		
		currentURL = currentURL.substring(beginIndex);
		
		return currentURL;
	}
	
}
