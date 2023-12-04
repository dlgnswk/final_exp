package com.spring.app.db.lodge.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.db.lodge.model.LodgeDAO;

@Service
public class LodgeService_imple implements LodgeService {

	@Autowired
	private LodgeDAO dao;
	
}
