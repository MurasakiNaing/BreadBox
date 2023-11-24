package com.breadbox.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;

import com.mysql.cj.jdbc.MysqlDataSource;

@Configuration
@ComponentScan(basePackages = {"com.breadbox.service"})
public class RootConfig {

	@Bean
	public DataSource datasource() {
		var bean = new MysqlDataSource();
		bean.setUrl("jdbc:mysql://localhost:3306/breadbox");
		bean.setUser("breadboxuser");
		bean.setPassword("breadbxadmin");
		return bean;
	}
	
	@Bean
	@Scope("prototype")
	public SimpleJdbcInsert simpleJdbcInsert(DataSource datasource) {
		return new SimpleJdbcInsert(datasource);
	}
	
}
