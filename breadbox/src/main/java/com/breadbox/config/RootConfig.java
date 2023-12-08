package com.breadbox.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mysql.cj.jdbc.MysqlDataSource;

@Configuration
@EnableTransactionManagement
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
	public JdbcTemplate jdbcTemplate(DataSource datasource) {
		return new JdbcTemplate(datasource);
	}
	
	@Bean
	public TransactionManager transactionManager(DataSource datasource) {
		return new DataSourceTransactionManager(datasource);
	}
}
