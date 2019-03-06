package com.airbus.aerothon.dao;

import org.springframework.data.repository.CrudRepository;

import com.airbus.aerothon.entities.Test;


public interface TestRepository extends CrudRepository<Test, Integer> {

}
