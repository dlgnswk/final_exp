package com.spring.app.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		// System.out.println("currentURL => " + currentURL);
		// currentURL => http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString(); // ? 다음
		// System.out.println("queryString => " + queryString);
		// queryString => searchType=name&searchWord=%EC%A7%80%EC%9D%80&sizePerPage=10&currentShowPageNo=9
		// queryString =>  null (POST 방식일 경우)
		
		if(queryString != null) { // GET 방식일 경우
			currentURL += "?" + queryString;
			// currentURL => http://localhost:9090/MyMVC/member/memberList.up?searchType=name&searchWord=%EC%A7%80%EC%9D%80&sizePerPage=10&currentShowPageNo=9
		}
		
		String ctxPath = request.getContextPath();
		//     /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//      27     =              21             +        6
		
		currentURL = currentURL.substring(beginIndex);
		// /member/memberList.up?searchType=name&searchWord=%EC%A7%80%EC%9D%80&sizePerPage=10&currentShowPageNo=9
		
		return currentURL;
	} // end of public static String getCurrentURL(HttpServletRequest request)
}
