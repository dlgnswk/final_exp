package com.spring.app.common;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/member/memberList.up
		
		String queryString = request.getQueryString();
		// 전달 되어진 데이터를 말한다. 주소에서 ? 다음을 말한다.
	//	System.out.println("queryString => " + queryString);
	// 	searchType=name&searchWord=%EC%83%88%ED%95%9C&sizePerPage=5&currentShowPageNo=8
		// post 방식은 null이 나온다.
		
		if(queryString != null) {// get 방식일 경우
			currentURL += "?"+queryString;
// http://localhost:9090/MyMVC/member/memberList.up ? searchType=name&searchWord=%EC%83%88%ED%95%9C&sizePerPage=5&currentShowPageNo=8
		}
		
		String ctxPath = request.getContextPath();
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		// 21 + 6 = 27
		
		currentURL = currentURL.substring(beginIndex);
		
		currentURL.substring(0);
		
		
		return currentURL;
	}// end of public static String getCurrentURL(HttpServletRequest request) {
}
