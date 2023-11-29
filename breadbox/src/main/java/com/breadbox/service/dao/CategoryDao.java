package com.breadbox.service.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.breadbox.service.dto.CategoryDto;

@Repository
public class CategoryDao {

	@Autowired
	@Qualifier("categories")
	private SimpleJdbcInsert insert;

	public List<CategoryDto> getAllCategories() {
		var template = insert.getJdbcTemplate();
		return template.query("select * from categories", new BeanPropertyRowMapper<>(CategoryDto.class),
				new Object[] {});
	}

	public CategoryDto findByName(String name) {
		var template = insert.getJdbcTemplate();
		// Use of Try Catch to catch exception as queryForObject always expect at one and only one row
		try {
			// Search For Category with name
			return template.queryForObject("select * from categories where name = ?",
					new BeanPropertyRowMapper<>(CategoryDto.class), name);
		} catch (EmptyResultDataAccessException e) {
			// Return null when there is no corresponding data.
			return null;
		}
	}

	public CategoryDto findById(int id) {
		var template = insert.getJdbcTemplate();
		// Use of Try Catch to catch exception as queryForObject always expect at one and only one row
		try {
			// Search For Category with Id
			return template.queryForObject("select * from categories where id = ?",
					new BeanPropertyRowMapper<>(CategoryDto.class), id);
		}  catch (EmptyResultDataAccessException e) {
			// Return null when there is no corresponding data.
			return null;
		}
	}

	public void addCategory(CategoryDto category) {
		Map<String, Object> param = new HashMap<>();
		param.put("name", category.getName());
		insert.execute(param);
	}

	public void updateCategory(CategoryDto category) {
		// Get JDBC Template form JDBC Insert
		var template = insert.getJdbcTemplate();
		var sql = """
				update Categories
				set name = ?
				where id = ?
				""";
		// Update Table
		template.update(sql, category.getName(), category.getId());
	}
	
	public void deleteCategory(int id) {
		// Get JDBC Template form JDBC Insert
		var template = insert.getJdbcTemplate();
		// Delete Category
		template.update("delete from categories where id = ?", id);
	}
}
