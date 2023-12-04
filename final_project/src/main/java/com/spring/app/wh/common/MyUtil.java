package com.spring.app.wh.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		// currentURL => http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString();
		//System.out.println("queryString => " + queryString);
		// queryString => searchType=name&searchWord=%EC%9A%B0%ED%98%84&sizePerPage=5&currentShowPageNo=7
		// queryString => null (post 방식일 경우)
		
		if(queryString != null) {	// GET 방식일 경우
			currentURL += "?"+queryString; 
		 // currentURL => http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=%EC%9A%B0%ED%98%84&sizePerPage=5&currentShowPageNo=7
		}
		
		String ctxPath = request.getContextPath();
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//	27				21							6
		
		currentURL = currentURL.substring(beginIndex);
		// /member/memberList.up?searchType=name&searchWord=%EC%9A%B0%ED%98%84&sizePerPage=5&currentShowPageNo=7
		
		return currentURL;
		
	}
	
	
}
