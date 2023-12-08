package com.breadbox.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.breadbox.service.dao.UserDao;
import com.breadbox.service.dto.SignupForm;
import com.breadbox.service.dto.UserDto;

@Service
@Transactional(readOnly = true)
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public UserDto findById(String email) {
		return userDao.findById(email);
	}
	
	@Transactional
	public void signUp(SignupForm form) {
		userDao.signUp(form);
	}
	
	@Transactional
	public void changeProfile(String image, String email) {
		userDao.changeProfile(image, email);
	}
	
	@Transactional
	public void editUsername(String newUsername, String email) {
		userDao.editUsername(newUsername, email);
	}
	
	@Transactional
	public void changePassword(String newPassword, String email) {
		userDao.changePassword(newPassword, email);
	}
	
	public boolean validatePassword(String inputPassword, String currentPassword) {
		return userDao.validatePassword(inputPassword, currentPassword);
	}
}
