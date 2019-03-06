package com.airbus.aerothon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.airbus.aerothon.entities.Test;
import com.airbus.aerothon.services.TestService;

@RestController
public class TestController {

	@Autowired
	TestService testService;
	
	@GetMapping("/test")
	public List<Test> getTests() {
		return testService.getTests();
	}
}
