package com.breadbox.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.breadbox.service.UserService;
import com.breadbox.service.dto.UserDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/settings")
public class SettingController {

	@Autowired
	private UserService userService;

	@GetMapping({"", "/username-edit", "/change-password"})
	public String setting() {
		return "settings";
	}
	
	@PostMapping("/change-profile")
	public String changeProfile(@RequestParam("imageUpload") MultipartFile imageFile, HttpSession session) {
		// Set Upload Path (Relative Path which will be stored in database)
		var uploadPath = "/resources/images/profile-images/";
		// If image is not null copy it to destination
				if (!imageFile.isEmpty()) {
					// Get Servlet Context
					var context = session.getServletContext();
					// Get Real Path to use for uploading file
					String fileName = context.getRealPath(uploadPath + imageFile.getOriginalFilename());
					try {
						// Copy the file to destined path
						Files.copy(imageFile.getInputStream(), Paths.get(fileName), StandardCopyOption.REPLACE_EXISTING);
						// Get user from session scope
						UserDto user = (UserDto) session.getAttribute("user");
						// Change profilepic in database
						userService.changeProfile(uploadPath + imageFile.getOriginalFilename(), user.getEmail());
						user.setProfilepic(uploadPath + imageFile.getOriginalFilename());
					} catch (IOException e) {
						e.printStackTrace();
						// Return to edit-page if there's error
						return "edit-product";
					}
				}
		return "redirect:/settings";
	}

	@PostMapping("/username-edit")
	public String editUsername(@RequestParam("username") String username, Authentication authentication, HttpSession session, ModelMap map) {
		if (!usernameValidated(map, username, authentication.getName())) {
			return "settings";
		}
		// Change Password
		userService.editUsername(username, authentication.getName());
		// If username change is successful replace the user in session scope to get updated user
		UserDto user = userService.findById(authentication.getName());
		session.setAttribute("user", user);
		// Redirect to avoid multiple submission
		return "redirect:/settings";
	}

	@PostMapping("/change-password")
	public String changePassword(@RequestParam("currentPassword") String inputPassword,
			@RequestParam("newPassword") String newPassword, HttpSession session, ModelMap map) {
		UserDto user = (UserDto) session.getAttribute("user");
		// Validation
		if(!passwordValidated(map, newPassword, inputPassword, user.getPassword())) 
			return "settings";
		// Change Password
		userService.changePassword(newPassword, user.getEmail());
		// Log out the user to re-authenticate if changing password is successful
		return "redirect:/login?logout";
	}

	private boolean usernameValidated(ModelMap map, String username, String email) {
		// Check if username is blank or empty
		if (username.isBlank()) {
			map.put("usernameError", "Username cannot be blank.");
			return false;
		}

		// If new username is the same with current username
		var currentUsername = userService.findById(email).getUsername();
		if (currentUsername.equals(username)) {
			// If so return false as there is no need to run SQL update statement
			return false;
		}
		return true;
	}
	
	private boolean passwordValidated(ModelMap map, String newPassword, String inputPassword, String currentPassword) {
		// Check if the input password and current password matches
		if(!userService.validatePassword(inputPassword, currentPassword)) {
			map.put("currentPasswordError", "Passwords does not match.");
			return false;
		}
		// Check if new password field is blank
		if(newPassword.isBlank()) {
			map.put("newPasswordError", "New Password field cannot be blank.");
			return false;
		}
		// Check if new password and current password matches
		if(userService.validatePassword(newPassword, currentPassword)) {
			map.put("newPasswordError", "New password and Current Password cannot be the same.");
			return false;
		}
		return true;
	}
}
