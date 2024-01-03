package com.spring.app.wh.partner.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.app.expedia.domain.HostVO;

@Repository
public class PartnerDAO_imple implements PartnerDAO {

	@Resource // bean에 올라가 있는 것들 중 sqlsession 의 필드명을 가지고 있는 객체를 찾아서 연결해줌
	private SqlSessionTemplate sqlsession;

	
	// 로그인 처리하기 
	@Override
	public HostVO getLoginHost(Map<String, String> paraMap) {
		
		HostVO loginhost = sqlsession.selectOne("wh_partner.getLoginHost", paraMap);
		
		// System.out.println("확인용 : dao loginhost : "+loginhost);
		
		return loginhost;
	}

	// 회원가입 시 입력한 아이디 값이 기존에 가입한 회원에 존재하는지 확인해주는 메소드
	@Override
	public int idDuplicateCheck(String userid) {
		int isExists = sqlsession.selectOne("wh_partner.idDuplicateCheck", userid);
		return isExists;
	}
	
	// tbl_host 에 HostVO 에 저장된 정보를 insert 해주는 메소드
	@Override
	public int registerHost(HostVO host) {
		int n = sqlsession.insert("wh_partner.registerHost",host);
		return n;
	}

	
	
	// 월별 객실등급별 예약 인원 수 가져오기
	@Override
	public List<Map<String, String>> useLodgeCnt(Map<String, String> paraMap) {
		List<Map<String, String>> useLodgeCntList = sqlsession.selectList("wh_partner.useLodgeCnt", paraMap);
		return useLodgeCntList;
	}

	
	// tbl_host 에 저장된 판매자의 정보를 update 해주는 메소드
	@Override
	public int editHost(Map<String, String> paraMap) {
		int n = sqlsession.update("wh_partner.editHost", paraMap);
		return n;
	}

	
	
	



	
	
	

}
