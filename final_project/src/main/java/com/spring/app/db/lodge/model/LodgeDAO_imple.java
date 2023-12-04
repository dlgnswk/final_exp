package com.spring.app.db.lodge.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LodgeDAO_imple implements LodgeDAO {

	@Resource
	private SqlSessionTemplate sqlsession;
	
}
