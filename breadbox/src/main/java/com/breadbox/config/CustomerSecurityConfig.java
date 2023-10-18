package com.breadbox.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@Configuration
public class CustomerSecurityConfig {

	
	@Bean
	public InMemoryUserDetailsManager userDetailsService(PasswordEncoder passwordEncoder) {
		
		UserDetails admin = User.withUsername("admin")
				.password(passwordEncoder.encode("adminPass"))
				.authorities("Admin")
				.build();
		UserDetails user = User.withUsername("customer")
				.password(passwordEncoder.encode("customerPass"))
				.authorities("Customer")
				.build();
		return new InMemoryUserDetailsManager(admin, user);
	}
}
