package com.breadbox.service.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.breadbox.service.dto.ProductDto;

@Repository
public class ProductDao {

	@Autowired
	private JdbcTemplate template;
	
	// Select Queries
	
	public List<ProductDto> getAllProduct() {
		// Query to get all products
		return template.query("select * from products", new BeanPropertyRowMapper<>(ProductDto.class),
				new Object[] {});
	}
	
	public ProductDto findById(int id) {
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
		// Use of Try Catch to catch exception as queryForObject always expect at one and only one row
		try {
			return template.queryForObject("select * from products where name = ?", new BeanPropertyRowMapper<>(ProductDto.class), name);
		} catch(EmptyResultDataAccessException e) {
			// Catch exception as queryForObject always expects at least one data and only one data
			// Return null when there is no corresponding data.
			return null;
		}
	}
	
	public List<ProductDto> searchProduct(String name) {
		// SQL Query
		var sql = "select * from products where lower(name) like lower('%s')";
		return template.query(sql.formatted(name+"%"), new BeanPropertyRowMapper<>(ProductDto.class));
	}
	
	public List<ProductDto> getTrendingProducts() {
		// SQL Query
		var sql = """
				SELECT p.id, p.category_id, p.name, p.price, p.description, p.image
				FROM products p
				JOIN sale_items s ON p.id = s.product_id
				GROUP BY s.product_id
				ORDER BY SUM(s.qty) DESC
				LIMIT 3;
				""";
		return template.query(sql, new BeanPropertyRowMapper<>(ProductDto.class));
	}
	
	public List<ProductDto> getNewlyAddedProducts() {
		// SQL Query
		var sql = """
				SELECT * FROM products
				ORDER BY id DESC
				LIMIT 3;
				""";
		return template.query(sql, new BeanPropertyRowMapper<>(ProductDto.class));
	}
	
	// CRUD Queries
	
	public void addProduct(ProductDto product) {
		// Get SimpleJdbcInsert
		var insert = new SimpleJdbcInsert(template.getDataSource());
		// Set Table Name
		insert.setTableName("products");
		// Add product to products table
		insert.execute(new BeanPropertySqlParameterSource(product));
	}
	
	public void updateProduct(ProductDto product) {
		// Get Named Parameter JDBC Template form JDBC Insert
		NamedParameterJdbcTemplate namedTemplate = new NamedParameterJdbcTemplate(template);
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
	    namedTemplate.update(sql, params);
	}
	
	public void delete(int id) {
		template.update("delete from products where id = ?", id);
	}
}
