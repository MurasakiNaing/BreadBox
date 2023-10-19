package com.breadbox.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import com.breadbox.handler.CustomAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = "com.breadbox.handler")
public class SecurityConfig {

	@Autowired
	private CustomAuthenticationSuccessHandler successHandler;
	
	@Bean()
    public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
        return new HandlerMappingIntrospector();
    }
	
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
			request.requestMatchers(mvc.pattern("/login"), mvc.pattern("/sign-up/**")).permitAll();
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
	
	@Bean
	JdbcUserDetailsManager configure(DataSource datasource) {
		var userDetailsService = new JdbcUserDetailsManager(datasource);
		userDetailsService
				.setUsersByUsernameQuery("select email username, password, true from user where email = ?");
		userDetailsService.setAuthoritiesByUsernameQuery("select email username, role from user where email = ?");
		return userDetailsService;
	}
}