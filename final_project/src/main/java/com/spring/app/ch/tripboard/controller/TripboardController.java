package com.spring.app.ch.tripboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.ch.tripboard.service.TripboardService;

@Controller
public class TripboardController {
	/*
	 * @Autowired // Type에 따라 알아서 Bean 을 주입해준다. private TripboardService service;
	 */
	
	// === 여행후기 게시판 글목록 페이지 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tripboard.exp") 
	public ModelAndView tripboard(ModelAndView mav) {
		
		
		mav.setViewName("tripboard/tblist.tiles1");
		
		return mav;
	}

	// === 여행후기 게시판 글 상세보기 페이지 === //
				// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tbview.exp") 
	public ModelAndView tbview(ModelAndView mav) {
			
			
		mav.setViewName("tripboard/tbview.tiles1");
			
		return mav;
	}
	
	// === 여행후기 게시판 글쓰기 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tbadd.exp") 
	public ModelAndView tbadd(ModelAndView mav) {
		
		
		mav.setViewName("tripboard/tbadd.tiles1");
		
		return mav;
	}
	
	
	
	
	
	
	// === 여행후기 게시판 글 수정하기 페이지 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tbedit.exp") 
	public ModelAndView tbedit(ModelAndView mav) {
		
		
		mav.setViewName("tripboard/tbedit.tiles1");
		
		return mav;
	}
	
	// === 여행후기 게시판 글 수정하기 페이지 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/tbdel.exp") 
	public ModelAndView tbdel(ModelAndView mav) {
		
		
		mav.setViewName("tripboard/tbdel.tiles1");
		
		return mav;
	}
	// ========== **** 여행 후기 게시판 시작 **** ========== //
	
	
}
