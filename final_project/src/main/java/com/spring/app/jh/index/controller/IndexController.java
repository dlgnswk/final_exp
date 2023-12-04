package com.spring.app.jh.index.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.spring.app.jh.index.service.*;


@Controller
public class IndexController { 


	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private IndexService service;



	
	
	// ========== **** 게시판 시작 **** ========== //
	
	// === #36. 메인 페이지 요청 === //
	// 먼저, com.spring.app.HomeController 클래스에 가서 @Controller 을 주석처리한다.
	@GetMapping("/index.exp") 
	public ModelAndView index(ModelAndView mav) {
		
		String name = service.getName();
		
		mav.addObject("name", name);
		mav.setViewName("/index/index.tiles1");
		
		return mav;
	}
	
	@GetMapping("/partner.exp") 
	public ModelAndView partner(ModelAndView mav) {
		
		String name = service.getName();
		
		mav.addObject("name", name);
		mav.setViewName("/index/partner.tiles2");
		
		return mav;
	}
	
	
}
