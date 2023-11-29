package com.breadbox.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
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
	
	@Bean("users")
	public SimpleJdbcInsert simpleJdbcUsersInsert(DataSource datasource) {
		var insert = new SimpleJdbcInsert(datasource);
		insert.setTableName("users");
		return insert;
	}
	
	@Bean("categories")
	public SimpleJdbcInsert simpleJdbcCategoriesInsert(DataSource datasource) {
		var insert = new SimpleJdbcInsert(datasource);
		insert.setTableName("categories");
		insert.setGeneratedKeyName("id");
		return insert;
	}
	
	@Bean("products")
	public SimpleJdbcInsert simpleJdbcProductInsert(DataSource datasource) {
		var insert = new SimpleJdbcInsert(datasource);
		insert.setTableName("products");
		return insert;
	}

	@Bean("checkout")
	public SimpleJdbcInsert simpleJdbcInsertCheckout(DataSource datasource) {
		var insert = new SimpleJdbcInsert(datasource);
		insert.setTableName("voucher");
		insert.setGeneratedKeyName("id");
		return insert;
	}
	
	@Bean
	public TransactionManager transactionManager(DataSource datasource) {
		return new DataSourceTransactionManager(datasource);
	}
}
