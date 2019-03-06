package com.airbus.aerothon.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.airbus.aerothon.dao.TestRepository;
import com.airbus.aerothon.entities.Test;
import com.google.common.collect.Lists;

@Service
public class TestService {

	@Autowired
	TestRepository testRepository;
	
	public List<Test> getTests() {
		return Lists.newArrayList(testRepository.findAll());
	}

}
