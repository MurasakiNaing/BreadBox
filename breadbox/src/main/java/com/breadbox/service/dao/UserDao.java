package com.breadbox.service.dao;

import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.breadbox.service.dto.SignupForm;
import com.breadbox.service.dto.UserDto;
import com.breadbox.service.dto.UserDto.Role;

@Repository
public class UserDao {

	@Autowired
	DataSource datasource;
	
	@Autowired
	private PasswordEncoder encoder;
	
	private JdbcTemplate template;

	@Autowired
	private SimpleJdbcInsert insert;
	
	public UserDto findById(String email) {
		template = new JdbcTemplate(datasource);
		return template.queryForObject("select * from users where email = ?",
				new BeanPropertyRowMapper<>(UserDto.class),
				email);
	}

	public int singUp(SignupForm form) {
		insert.setTableName("users");
		insert.setGeneratedKeyName("userId");
		return insert.executeAndReturnKey(getInsertParams(form)).intValue();
	}
	
	private Map<String, Object> getInsertParams(SignupForm form) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", form.getEmail());
		map.put("username", form.getUsername());
		map.put("password", encoder.encode(form.getPassword()));
		map.put("role", Role.Customer.toString());
		map.put("profilepic", null);
		return map;
	}
	
}
