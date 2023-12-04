package com.spring.app.db.lodge.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.app.db.lodge.service.LodgeService;

@Controller
public class LodgeController {
	
	@Autowired
	private LodgeService service;
	
	
	
	// === 숙박 시설 등록 페이지 == //
	@RequestMapping(value="/register_lodge.exp")
	public String register_lodge(HttpServletRequest request) {
		System.out.println();
		
		return "db/register/register_lodge.tiles2";
		// /WEB-INF/views/tiles2/db/register/register_lodge.jsp
		// /WEB-INF/views/tiles2/{1}/{2}/{3}.jsp
	}
	
	
}
