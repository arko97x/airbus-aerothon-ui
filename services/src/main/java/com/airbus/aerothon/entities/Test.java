package com.airbus.aerothon.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "test")
public class Test {

	@Id
	@Column(name = "id")
	Integer id;

	@Column(name = "age")
	Integer age;

	@Column(name = "name")
	String name;

	@Column(name = "flightid")
	Integer flightId;

	@Column(name = "date")
	Date date;
}
