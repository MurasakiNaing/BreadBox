package com.breadbox.service.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.breadbox.service.dto.ProductDto;

@Repository
public class ProductDao {

	@Autowired
	SimpleJdbcInsert insert;

	public List<ProductDto> getAllProduct() {
		// Get JDBC Template from Simple JDBC Insert
		var template = insert.getJdbcTemplate();
		// Query to get all products
		return template.query("select * from products", new BeanPropertyRowMapper<>(ProductDto.class),
				new Object[] {});
	}
	
	public ProductDto findById(int id) {
		// Get JDBC Template from Simple JDBC Insert
		var template = insert.getJdbcTemplate();
		// Use of Try Catch to catch exception as queryForObject always expect at one and only one row
		try {
			// Search for product using id
			return template.queryForObject("select * from products where id = ?", new BeanPropertyRowMapper<>(ProductDto.class), id);
		} catch(EmptyResultDataAccessException e) {
			// Return null when there is no corresponding data.
			return null;
		}
	}
	
	public ProductDto findByName(String name) {
		var template = insert.getJdbcTemplate();
		// Use of Try Catch to catch exception as queryForObject always expect at one and only one row
		try {
			return template.queryForObject("select * from products where name = ?", new BeanPropertyRowMapper<>(ProductDto.class), name);
		} catch(EmptyResultDataAccessException e) {
			// Catch exception as queryForObject always expects at least one data and only one data
			// Return null when there is no corresponding data.
			return null;
		}
	}
	
	public void addProduct(ProductDto product) {
		// Set table to insert
		insert.setTableName("products");
		// Add product to products table
		insert.execute(new BeanPropertySqlParameterSource(product));
	}
	
	public void updateProduct(ProductDto product) {
		// Get Named Parameter JDBC Template form JDBC Insert
		NamedParameterJdbcTemplate template = new NamedParameterJdbcTemplate(insert.getJdbcTemplate());
		// SQL string for update
	    String sql = """
	            UPDATE products
	            SET category_id = :category_id, name = :name, price = :price, description = :description, image = :image
	            WHERE id = :id
	            """;
	    // Create HashMap for named sql parameters
	    Map<String, Object> params = new HashMap<>();
	    params.put("category_id", product.getCategory_id());
	    params.put("name", product.getName());
	    params.put("price", product.getPrice());
	    params.put("description", product.getDescription());
	    params.put("image", product.getImage());
	    params.put("id", product.getId());

	    // Update the products table
	    template.update(sql, params);
	}
	
	public void delete(int id) {
		var template = insert.getJdbcTemplate();
		template.update("delete from products where id = ?", id);
	}
}
