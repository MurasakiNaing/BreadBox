package com.breadbox.service.dto;

import lombok.Data;

@Data
public class UserDto {

	private String email;
	private String username;
	private String password;
	private Role role;
	private String profilepic;
	
	public enum Role {
		Admin, Customer
	}
}
