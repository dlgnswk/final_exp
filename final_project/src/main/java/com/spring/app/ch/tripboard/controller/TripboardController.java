package com.spring.app.ch.tripboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.ch.tripboard.service.TripboardService;

@Controller
public class TripboardController {
	

	
	// === #36. 메인 페이지 요청 === //
		// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tripboard.exp") 
	public ModelAndView index(ModelAndView mav) {
		
		
		mav.setViewName("tripboard/tripboard.tiles1");
		
		return mav;
	}

	
	
	// ========== **** 여행 후기 게시판 시작 **** ========== //
	
	
}
