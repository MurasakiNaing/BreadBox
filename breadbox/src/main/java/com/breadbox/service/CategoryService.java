package com.breadbox.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.breadbox.service.dao.CategoryDao;
import com.breadbox.service.dto.CategoryDto;

@Service
@Transactional(readOnly = true)
public class CategoryService {

	@Autowired
	private CategoryDao dao;
	
	public List<CategoryDto> getAllCategories() {
		return dao.getAllCategories();
	}
	
	public CategoryDto findById(int id) {
		return dao.findById(id);
	}
	
	public CategoryDto findByName(String name) {
		return dao.findByName(name);
	}
	
	@Transactional
	public void save(CategoryDto category) {
		// Check if the id is 0
		if(category.getId() == 0) {
			// If ID is 0 call addCategory method
			dao.addCategory(category);
		} else {
			// If ID is not 0 call updateCategory method
			dao.updateCategory(category);
		}
	}
	
	@Transactional
	public void delete(int id) {
		dao.deleteCategory(id);
	}
	
}
