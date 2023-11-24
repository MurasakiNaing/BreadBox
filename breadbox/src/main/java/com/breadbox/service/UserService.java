package com.breadbox.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.breadbox.service.dao.UserDao;
import com.breadbox.service.dto.SignupForm;
import com.breadbox.service.dto.UserDto;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public UserDto findById(String email) {
		return userDao.findById(email);
	}
	
	public void signUp(SignupForm form) {
		userDao.signUp(form);
	}
}
