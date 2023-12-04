package com.spring.app.jh.index.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//==== #32. Repository(DAO) 선언 ====
//@Component
@Repository
public class IndexDAO_imple implements IndexDAO {

	// === #33. 의존객체 주입하기(DI: Dependency Injection) ===
	// >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	//     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	//     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	//     의존 객체 자동 주입(Automatic Dependency Injection)방법 3가지 
	//     1. @Autowired ==> Spring Framework에서 지원하는 어노테이션이다. 
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
	//     2. @Resource  ==> Java 에서 지원하는 어노테이션이다.
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	
	//     3. @Inject    ==> Java 에서 지원하는 어노테이션이다.
    //                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
/*	
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private SqlSessionTemplate abc;
	// Type 에 따라 Spring 컨테이너가 알아서 root-context.xml 에 생성된 org.mybatis.spring.SqlSessionTemplate 의 bean 을  abc 에 주입시켜준다. 
    // 그러므로 abc 는 null 이 아니다.
*/
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	
	
	// spring_test 테이블에 insert 하기 
	@Override
	public int test_insert() {
		
		int n = sqlsession.insert("board.test_insert");
		
		return n;
	}



	@Override
	public String getName() {
		String name = sqlsession.selectOne("jh_index.getName");
		return name;
	}
	
	
	
}
