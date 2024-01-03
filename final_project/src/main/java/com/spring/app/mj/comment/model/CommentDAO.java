package com.spring.app.mj.comment.model;

import java.util.List;
import java.util.Map;

import com.spring.app.expedia.domain.CommentVO;

/** 
* @FileName  : ReviewDAO.java 
* @Project   : final_project 
* @Date      : 2023. 12. 22 
* @작성자      : 손명진 
* @변경이력    : 
* @프로그램설명    : 
*/
public interface CommentDAO {

	/** 
	* @Method Name  : totalCount 
	* @작성일   : 2023. 12. 25 
	* @작성자   : 손명진
	* @변경이력  : 
	* @Method 설명 : // 후기 전체 갯수를 구하는 메소드
	* @param string
	* @return 
	*/
	int totalCount(String string);

	/** 
	* @Method Name  : selectByComment 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 더보기 방식(페이징처리)으로 댓글 8개씩 잘라서(start ~ end) 조회해오기 
	* @param paraMap
	* @return 
	*/
	List<CommentVO> selectByComment(Map<String, String> paraMap);

	/** 
	* @Method Name  : getSearchList 
	* @작성일   : 2023. 12. 26 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 글목록 보여주기
	* @param paraMap
	* @return 
	*/
	List<Map<String, Object>> getSearchList(Map<String, String> paraMap);

	/** 
	* @Method Name  : getInsert 
	* @작성일   : 2023. 12. 30 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 
	* @return 
	*/
	List<Map<String, Object>> getSelect();

	/** 
	* @Method Name  : getComment 
	* @작성일   : 2024. 1. 1 
	* @작성자   : 손명진 
	* @변경이력  : 
	* @Method 설명 : 답변 달아주는 insert하기
	* @param paraMap
	* @return 
	*/
	int getComment(Map<String, String> paraMap);

}
