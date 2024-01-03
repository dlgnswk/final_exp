package com.spring.app.jy.lodge.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.app.expedia.domain.UserVO;
import com.spring.app.jy.lodge.service.LodgeService;

@Controller
public class LodgeController {
	
	@Autowired
	private LodgeService service;
	
	@GetMapping("/lodgeDetail_info.exp")
	public ModelAndView lodgeDetail_info(ModelAndView mav, HttpServletRequest request) {
		

		// 오늘날짜 가져오기
		Calendar cal = Calendar.getInstance();
		String format = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		String today_date = sdf.format(cal.getTime());
		// System.out.println(today_date); // 2023-12-14

		// 이틀뒤 날짜 가져오기
		cal = null;
		cal = Calendar.getInstance();
		sdf = new SimpleDateFormat(format);
		cal.add(cal.DATE, +2);
		String after_tommorrow_date = sdf.format(cal.getTime());
		// System.out.println(after_tommorrow_date); // 2023-12-16

		// 두달뒤 날짜 가져오기
		cal = null;
		cal = Calendar.getInstance();
		sdf = new SimpleDateFormat(format);
		cal.add(cal.MONTH, +12);
		String after_1year_date = sdf.format(cal.getTime());
		// System.out.println(after_2month_date); // 2024-02-14

		Map<String, String> date_map = new HashMap<>();
		date_map.put("today_date", today_date);
		date_map.put("after_tommorrow_date", after_tommorrow_date);
		date_map.put("after_1year_date", after_1year_date);

		mav.addObject("date_map", date_map);

		// String lodge_id = request.getParameter("lodge_id");
		String lodge_id = "GWGN0002";
		String rm_seq = "rm-2";
		String startDate = request.getParameter("startDate");
		//String startDate = "2024-02-26";
		String endDate = request.getParameter("endDate");
		//String endDate = "2024-03-01";
		
		if(startDate != null && endDate!= null) {
			// 두 날짜 사이의 일수 계산(차이 구하기)
			try {
				Date d_startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
				Date d_endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
				
				long stayNight = (d_endDate.getTime() - d_startDate.getTime())/(1000*24*60*60);
				mav.addObject("stayNight",stayNight);
			} catch (ParseException e) {
				e.printStackTrace();
			}	
		}
		else {
			startDate = ""; 
			endDate = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("lodge_id", lodge_id);
		
		String d_rate="0";
		
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		if(loginuser == null) {
			d_rate = "0";
		}
		else if(loginuser.getUser_lvl()=="0") {
			d_rate = "0.1";
		}
		else if(loginuser.getUser_lvl()=="1") {
			d_rate = "0.15";
		}
		else if(loginuser.getUser_lvl()=="2") {
			d_rate = "0.2";
		}
		
		mav.addObject("d_rate", d_rate);
		
	//	Map<String, String> i_paraMap = new HashMap<>();
	//	i_paraMap.put("lodge_id", lodge_id);
		if(loginuser == null) {
			paraMap.put("userid", "-");
		}
		else {
			paraMap.put("userid", loginuser.getUserid());
		}
		
		String guest_cnt = "1";
		if(request.getParameter("guest") != null) {
			guest_cnt = request.getParameter("guest");
		}
		paraMap.put("guest_cnt", guest_cnt);
		String room_cnt = "1";
		if(request.getParameter("room") != null) {
			room_cnt = request.getParameter("room");
		}
		paraMap.put("room_cnt", room_cnt);		
		String adult_cnt = "2";
		if(request.getParameter("adults") != null) {
			adult_cnt = request.getParameter("adults");
		}
		String child_cnt = "0";
		if(request.getParameter("childs") != null) {
			child_cnt = request.getParameter("childs");
		}
		mav.addObject("room_cnt", room_cnt);
		mav.addObject("guest_cnt", guest_cnt);
		mav.addObject("adult_cnt", adult_cnt);
		mav.addObject("child_cnt", child_cnt);
		
		// 숙박 시설에 대한 정보 및 옵션 가져오기
		Map<String, String> lodgeinfo_map = service.getLodgeInfo(lodge_id); // 숙박시설 기본 정보 (w/ 리뷰 평점, 갯수)
		List<Map<String, String>> inet_opt_list = service.getInet_opt_list(lodge_id); // 숙박시설 옵션 - 인터넷
		List<Map<String, String>> park_opt_list = service.getPark_opt_list(lodge_id); // 숙박시설 옵션 - 주차 및 교통
		List<Map<String, String>> din_opt_list = service.getDin_opt_list(lodge_id); // 숙박시설 옵션 - 다이닝장소
		List<Map<String, String>> pool_opt_list = service.getPool_opt_list(lodge_id); // 숙박시설 옵션 - 수영장
		List<Map<String, String>> fac_opt_list = service.getFac_opt_list(lodge_id); // 숙박시설 옵션 - 장애인 편의 시설
		List<Map<String, String>> cs_opt_list = service.getCs_opt_list(lodge_id); // 숙박시설 옵션 - 고객서비스
		List<Map<String, String>> rmsvc_opt_list = service.getRmsvc_opt_list(lodge_id); // 숙박시설 옵션 - 객실 용품 및 서비스
		List<Map<String, String>> bsns_opt_list = service.getBsns_opt_list(lodge_id); // 숙박시설 옵션 - 비즈니스
		List<Map<String, String>> fasvc_opt_list = service.getFasvc_opt_list(lodge_id); // 숙박시설 옵션 - 가족여행 편의 시설 
		List<Map<String, String>> lg_img_list = service.getLg_img_list(paraMap); // 숙박시설 사진_메인
		List<Map<String, String>> lg_img_ca_list = service.getLg_img_ca_list(lodge_id); // 숙박시설 사진_카테고리
		paraMap.put("data", "all");
		List<Map<String, String>> all_lg_img_list = service.getLg_img_list(paraMap); 
		// 숙박시설 사진 가져오기 (i_paraMap 에 lodge_id 만 들어가고 data 키값에 all 이란 value 를 넣어줌. xml 에서 구분하기 위한 용도)
		
		// 해당 숙박 시설에 위시리스트 등록이 돼있는 지 확인
		boolean isExist_wish = service.isExist_wish(paraMap);
		
		
		mav.addObject("d_map",paraMap);
		mav.addObject("lodgeinfo",lodgeinfo_map);
		mav.addObject("park_opt_list",park_opt_list);
		mav.addObject("inet_opt_list",inet_opt_list);
		mav.addObject("din_opt_list",din_opt_list);
		mav.addObject("pool_opt_list",pool_opt_list);
		mav.addObject("fac_opt_list",fac_opt_list);
		mav.addObject("cs_opt_list",cs_opt_list);
		mav.addObject("rmsvc_opt_list",rmsvc_opt_list);
		mav.addObject("bsns_opt_list",bsns_opt_list);
		mav.addObject("fasvc_opt_list",fasvc_opt_list);
		mav.addObject("lg_img_list",lg_img_list);
		mav.addObject("lg_img_ca_list",lg_img_ca_list);
		mav.addObject("all_lg_img_list",all_lg_img_list);
		mav.addObject("isExist_wish",isExist_wish);
		
		// 조회한 날짜에 예약 가능한 객실 보여주기
		List<Map<String, String>> avbl_rm_list  = service.getAvbl_rm_list(paraMap);
		
		// 해당 숙박 시설이 가진 객실의 옵션들 가져오기(전체 객실 중 하나라도 갖고있으면 가져오기)
		List<Map<String, String>> com_bath_opt_list = service.getCom_bath_opt_list(lodge_id);
		List<Map<String, String>> com_snk_opt_list = service.getCom_snk_opt_list(lodge_id);
		List<Map<String, String>> com_kt_opt_list = service.getCom_kt_opt_list(lodge_id);
		List<Map<String, String>> com_ent_opt_list = service.getCom_ent_opt_list(lodge_id);
		List<Map<String, String>> com_tmp_opt_list = service.getCom_tmp_opt_list(lodge_id);
		List<Map<String, String>> rm_img_list = service.getRm_img_list(rm_seq);
		
		// 남은 rm의 총 갯수 < 입력된 객실 갯수 && 결과의 게스트의 평균 < 입력된 guest의 평균 일때만 객실 결과 보여주기
		if(avbl_rm_list != null) {
			int ttl_left_room_cnt = 0;
			int ttl_rm_guest_cnt = 0;
			for (Map<String, String> rm : avbl_rm_list) {
				ttl_left_room_cnt += Integer.parseInt(String.valueOf(rm.get("LEFT_ROOM_CNT")));
				ttl_rm_guest_cnt += Integer.parseInt(String.valueOf(rm.get("rm_guest_cnt")));
			}
			float avg_rm_guest_cnt = ttl_rm_guest_cnt/Integer.parseInt(guest_cnt);
			
			// 남은 rm의 총 갯수 > 입력된 객실 갯수 && 결과의 게스트의 평균 > 입력된 guest의 평균 일때만 객실 결과 보여주기
			if(ttl_left_room_cnt>Integer.parseInt(room_cnt) && avg_rm_guest_cnt>Integer.parseInt(guest_cnt)) {
				mav.addObject("avbl_rm_list",avbl_rm_list);
			}
		}
		
		
		// 객실 사진 가져오기
		List<Map<String, String>> all_rm_img_list = service.getAll_rm_img_list(lodge_id);

		
		mav.addObject("com_bath_opt_list",com_bath_opt_list);
		mav.addObject("com_snk_opt_list",com_snk_opt_list);
		mav.addObject("com_kt_opt_list",com_kt_opt_list);
		mav.addObject("com_ent_opt_list",com_ent_opt_list);
		mav.addObject("com_tmp_opt_list",com_tmp_opt_list);
		mav.addObject("rm_img_list",rm_img_list);
		mav.addObject("all_rm_img_list",all_rm_img_list);
		
		
		mav.setViewName("jy/lodge/lodgeDetail_info.tiles1");
		
		return mav;
	}

	@ResponseBody
	@GetMapping(value="/rmDetail_info_json.exp", produces="text/plain;charset=UTF-8")
	public String lodgeDetail_info_json(HttpServletRequest request) {
		
		String rm_seq = request.getParameter("rm_seq");
		// System.out.println(rm_seq);
		String lodge_id = request.getParameter("lodge_id");
		// System.out.println("확인용 lodge_id => "+lodge_id);
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("rm_seq", rm_seq);
		
		// 숙박시설 정보 필요한 데이터 가져오기
		List<Map<String, String>> rmsvc_opt_list = service.getRmsvc_opt_list(lodge_id); // 숙박시설 옵션 - 객실 용품 및 서비스
		List<Map<String, String>> inet_opt_list = service.getInet_opt_list(lodge_id); // 숙박시설 옵션 - 인터넷
		// 객실 정보 가져오기
		List<Map<String, String>> bath_opt_list = service.getBath_opt_list(rm_seq); 
		List<Map<String, String>> snk_opt_list = service.getSnk_opt_list(rm_seq);
		List<Map<String, String>> kt_opt_list = service.getKt_opt_list(rm_seq);
		List<Map<String, String>> ent_opt_list = service.getEnt_opt_list(rm_seq);
		List<Map<String, String>> tmp_opt_list = service.getTmp_opt_list(rm_seq);
		// 객실 사진 가져오기
		List<Map<String, String>> rm_img_list = service.getRm_img_list(rm_seq);
		List<Map<String, String>> avbl_rm_list  = service.getAvbl_rm_list(paraMap);
		
		// List<Map<String, String>> 들을 담아줄 JsonObject 생성!
		JsonObject jsonObj = new JsonObject(); 
		
		if(bath_opt_list != null && bath_opt_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : bath_opt_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("bath_opt_no", map.get("bath_opt_no"));
				jsonObj2.addProperty("bath_opt_desc", map.get("bath_opt_desc"));
	            
				jsonArr.add(jsonObj2);				
			}
			jsonObj.add("bath_opt_list", jsonArr);
		}
		if(snk_opt_list != null && snk_opt_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : snk_opt_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("snk_opt_no", map.get("snk_opt_no"));
				jsonObj2.addProperty("snk_opt_desc", map.get("snk_opt_desc"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("snk_opt_list", jsonArr);
		}
		if(kt_opt_list != null && kt_opt_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : kt_opt_list) {				
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("kt_opt_no", map.get("kt_opt_no"));
				jsonObj2.addProperty("kt_opt_desc", map.get("kt_opt_desc"));
	            
				jsonArr.add(jsonObj2);				
			}
			jsonObj.add("kt_opt_list", jsonArr);
		}
		if(ent_opt_list != null && ent_opt_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : ent_opt_list) {				
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("ent_opt_no", map.get("ent_opt_no"));
				jsonObj2.addProperty("ent_opt_desc", map.get("ent_opt_desc"));
	            
				jsonArr.add(jsonObj2);
				jsonObj.add("ent_opt_list", jsonArr);
			}
		}
		if(tmp_opt_list != null && tmp_opt_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : tmp_opt_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("tmp_opt_no", map.get("tmp_opt_no"));
				jsonObj2.addProperty("tmp_opt_desc", map.get("tmp_opt_desc"));
	            
				jsonArr.add(jsonObj2);				
			}
			jsonObj.add("tmp_opt_list", jsonArr);
		}		
		
		if(rm_img_list != null && rm_img_list.size() > 0) {
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : rm_img_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("rm_img_save_name", map.get("rm_img_save_name"));
				jsonObj2.addProperty("rm_img_main", map.get("rm_img_main"));
	            
				jsonArr.add(jsonObj2);				
			}
			jsonObj.add("rm_img_list", jsonArr);
		}
		if(avbl_rm_list != null && avbl_rm_list.size() > 0) {			 
			for(Map<String, String> map : avbl_rm_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("rm_type", map.get("rm_type"));
				jsonObj2.addProperty("view_desc", map.get("view_desc"));
				jsonObj2.addProperty("rm_size_meter", map.get("rm_size_meter"));
				jsonObj2.addProperty("rm_single_bed", map.get("rm_single_bed"));
				jsonObj2.addProperty("rm_ss_bed", map.get("rm_ss_bed"));
				jsonObj2.addProperty("rm_double_bed", map.get("rm_double_bed"));
				jsonObj2.addProperty("rm_queen_bed", map.get("rm_queen_bed"));
				jsonObj2.addProperty("fk_view_no", map.get("fk_view_no"));
				jsonObj2.addProperty("rm_guest_cnt", map.get("rm_guest_cnt"));
				jsonObj2.addProperty("rm_breakfast_yn", map.get("rm_breakfast_yn"));
				jsonObj2.addProperty("rm_smoke_yn", map.get("rm_smoke_yn"));
				jsonObj2.addProperty("rm_wheelchair_yn", map.get("rm_wheelchair_yn"));
	            
				jsonObj.add("rm_list", jsonObj2);
			}
			
		}
		
		if(rmsvc_opt_list != null && rmsvc_opt_list.size() > 0) {	
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : rmsvc_opt_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("fk_rmsvc_opt_no", map.get("fk_rmsvc_opt_no"));
				jsonObj2.addProperty("rmsvc_opt_desc", map.get("rmsvc_opt_desc"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("rmsvc_opt_list", jsonArr);
		}
		if(inet_opt_list != null && inet_opt_list.size() > 0) {	
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : inet_opt_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("fk_inet_opt_no", map.get("fk_inet_opt_no"));
				jsonObj2.addProperty("inet_opt_desc", map.get("inet_opt_desc"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("inet_opt_list", jsonArr);
		}
		
		return new Gson().toJson(jsonObj);
	}

	@ResponseBody
	@GetMapping(value="/get_lg_img_json.exp", produces="text/plain;charset=UTF-8")
	public String get_lg_img_json(HttpServletRequest request) {
		
		String img_cano = request.getParameter("img_cano");
		String lodge_id = request.getParameter("lodge_id");
		
		Map<String, String> i_paraMap = new HashMap<>();
		i_paraMap.put("lodge_id", lodge_id);
		i_paraMap.put("data", "all");
		List<Map<String, String>> lg_all_img_list = service.getLg_img_list(i_paraMap); 
		// 숙박시설 사진 가져오기 (i_paraMap 에 lodge_id 만 들어가고 data 키값에 all 이란 value 를 넣어줌. xml 에서 구분하기 위한 용도)
		
		i_paraMap.put("img_cano", img_cano);
		
		List<Map<String, String>> lg_ca_img_list = service.getLg_img_list(i_paraMap); // 숙박시설 사진
		
		// 객실 사진 가져오기
		List<Map<String, String>> all_rm_img_list = service.getAll_rm_img_list(lodge_id);
		
		JsonObject jsonObj = new JsonObject();
		if(lg_ca_img_list != null && lg_ca_img_list.size() > 0) {	
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : lg_ca_img_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("lodge_id", map.get("lodge_id"));
				jsonObj2.addProperty("lg_name", map.get("lg_name"));
				jsonObj2.addProperty("fk_img_cano", map.get("fk_img_cano"));
				jsonObj2.addProperty("img_cate_name", map.get("img_cate_name"));
				jsonObj2.addProperty("lg_img_save_name", map.get("lg_img_save_name"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("lg_ca_img_list", jsonArr);
		}
		
		if(all_rm_img_list != null && all_rm_img_list.size() > 0) {	
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : all_rm_img_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("rm_seq", map.get("rm_seq"));
				jsonObj2.addProperty("rm_img_save_name", map.get("rm_img_save_name"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("all_rm_img_list", jsonArr);
		}
		if(lg_all_img_list != null && lg_all_img_list.size() > 0) {	
			JsonArray jsonArr = new JsonArray(); 
			for(Map<String, String> map : lg_all_img_list) {
				JsonObject jsonObj2 = new JsonObject(); 
				jsonObj2.addProperty("lodge_id", map.get("lodge_id"));
				jsonObj2.addProperty("lg_name", map.get("lg_name"));
				jsonObj2.addProperty("fk_img_cano", map.get("fk_img_cano"));
				jsonObj2.addProperty("img_cate_name", map.get("img_cate_name"));
				jsonObj2.addProperty("lg_img_save_name", map.get("lg_img_save_name"));
	            
				jsonArr.add(jsonObj2);
			}
			jsonObj.add("lg_all_img_list", jsonArr);
		}
		
		return new Gson().toJson(jsonObj);
	}	
	
	@ResponseBody
	@GetMapping(value="/update_wishList_json.exp", produces="text/plain;charset=UTF-8")
	public String update_wishList_json(HttpServletRequest request) {

		
		String lodge_id = request.getParameter("lodge_id");
	
		HttpSession session = request.getSession();
		UserVO loginuser = (UserVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("lodge_id", lodge_id);
		paraMap.put("userid", userid);
		
		boolean isExist_wish = service.isExist_wish(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		// 저장하지 않은 상태일때, tbl_wishlist 에 insert
		if(!isExist_wish) {
			int add_wishList = service.add_wishList(paraMap);
			jsonObj.put("add_wishList", add_wishList);
		}
		// 저장돼있는 상태일때, tbl_wishlist 에서 delete
		else if(isExist_wish) {
			int delete_wishList = service.delete_wishList(paraMap);
			jsonObj.put("delete_wishList", delete_wishList);
		}
				
		return jsonObj.toString();
	}
}
