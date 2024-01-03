package com.spring.app.wh.partner.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.expedia.domain.HostVO;

public interface PartnerService {


	
	// 로그인 처리하기
	// ModelAndView loginEnd(ModelAndView mav, Map<String, String> paraMap, HttpServletRequest request);

	// 로그인 처리하기
	HostVO getLoginHost(Map<String, String> paraMap);

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	int idDuplicateCheck(String userid);	
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	int registerHost(HostVO host);

	
	// 월별 객실등급별 예약 인원 수 가져오기
	List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap);

	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	int editHost(Map<String, String> paraMap);

	



	
	
}
