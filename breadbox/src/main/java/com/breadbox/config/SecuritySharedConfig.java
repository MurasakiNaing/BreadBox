package com.breadbox.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import com.breadbox.handler.CustomAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecuritySharedConfig {

	@Autowired
	private CustomAuthenticationSuccessHandler successHandler;
	
	@Scope("prototype")
	@Bean
	MvcRequestMatcher.Builder mvc(HandlerMappingIntrospector introspector) {
		return new MvcRequestMatcher.Builder(introspector);
	}
	
	@Bean 
	public PasswordEncoder passwordEncoder() { 
	    return new BCryptPasswordEncoder(); 
	}
	
	@Bean
	SecurityFilterChain homeFilter(HttpSecurity http) throws Exception {

		http.securityMatcher("/").authorizeHttpRequests(request -> {
			request.anyRequest().permitAll();
		});

		return http.build();
	}

	@Bean
	SecurityFilterChain resourcesFilter(HttpSecurity http) throws Exception {
		http.securityMatcher("/resources/**").authorizeHttpRequests(request -> {
			request.anyRequest().permitAll();
		});

		return http.build();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http, MvcRequestMatcher.Builder mvc) throws Exception {
		http.authorizeHttpRequests(request -> {
			request.requestMatchers(mvc.pattern("/login"), mvc.pattern("/signup")).permitAll();
			request.requestMatchers(mvc.pattern("/admin/**")).hasAuthority("Admin");
			request.requestMatchers(mvc.pattern("/customer/**")).hasAnyAuthority("Customer", "Admin");
			request.anyRequest().denyAll();
		});
		
		http.formLogin(form -> {
			form.loginPage("/login");
			form.successHandler(successHandler);
			form.failureForwardUrl("/login-error");
		});
		
		http.logout(Customizer.withDefaults());
		
		return http.build();
	}
}
