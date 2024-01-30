package com.breadbox.service.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
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
	private PasswordEncoder encoder;
	
	@Autowired
	private JdbcTemplate template;
	
	public UserDto findById(String email) {
		try {
			return template.queryForObject("select * from users where email = ?",
					new BeanPropertyRowMapper<>(UserDto.class),
					email);
		} catch(EmptyResultDataAccessException e) {
			return null;
		}
	}

	public void signUp(SignupForm form) {
		var insert = new SimpleJdbcInsert(template.getDataSource());
		insert.setTableName("users");
		insert.execute(getInsertParams(form));
	}
	
	public void changeProfile(String image, String email) {
		// SQL String
		var sql = """
				update users
				set profilepic = ?
				where email = ?
				""";
		// Update Profile picture
		template.update(sql, image, email);
	}
	
	public void editUsername(String newUsername, String email) {
		var sql = """
				update users
				set username = '%s'
				where email = '%s'
				""";
		template.update(sql.formatted(newUsername, email));
	}
	
	public void changePassword(String newPassword, String email) {
		var sql = """
				update users
				set password = '%s'
				where email = '%s'
				""";
		template.update(sql.formatted(encoder.encode(newPassword), email));
	}
	
	public boolean validatePassword(String inputPassword, String currentPassword) {
		return encoder.matches(inputPassword, currentPassword);
	}
	
	private Map<String, Object> getInsertParams(SignupForm form) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", form.getEmail());
		map.put("username", form.getUsername());
		map.put("password", encoder.encode(form.getPassword()));
		map.put("role", Role.Customer.toString());
		map.put("profilepic", "/resources/images/profile-images/default_pfp.png");
		return map;
	}
	
}
