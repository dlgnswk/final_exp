/**
 * 
 */
package com.spring.app.mj.comment.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.expedia.domain.CommentVO;
import com.spring.app.mj.comment.model.CommentDAO;

/** 
* @FileName  : ReviewService_imple.java 
* @Project   : final_project 
* @Date      : 2023. 12. 22 
* @작성자      : 먕지 
* @변경이력    : 
* @프로그램설명    : 
*/

@Service
public class CommentService_imple implements CommentService {
	
	
	// === #34. 의존객체 주입하기(DI: Dependency Injection) ===
 	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private CommentDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.model.BoardDAO_imple 의 bean 을  dao 에 주입시켜준다. 
    // 그러므로 dao 는 null 이 아니다.
	

	// 후기 전체 갯수를 구하는 메소드
	@Override
	public int totalAllCount(String string) {
			int n = dao.totalCount(string);
		return n;
	}


	// 더보기 방식(페이징처리)으로 댓글 8개씩 잘라서(start ~ end) 조회해오기 
	@Override
	public List<CommentVO> selectBySpecComment(Map<String, String> paraMap) {
		List<CommentVO> selectBySpecComment = dao.selectByComment(paraMap);
		return selectBySpecComment;
	}


	// 글목록보기
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, String> paraMap) {
		List<Map<String, Object>> getSearchList = dao.getSearchList(paraMap);
		return getSearchList;
	}

	// 글목록보기 2 검색어 없는 버전
	@Override
	public List<Map<String, Object>> getSelect() {
		List<Map<String, Object>> getSelect = dao.getSelect();
		return getSelect;
	}

	// 답글 다아주기
	@Override
	public int add_Comment(Map<String, String> paraMap ) {
		int n = dao.getComment(paraMap);
		return n;
	}

}
