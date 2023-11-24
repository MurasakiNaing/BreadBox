package com.breadbox.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.breadbox.service.CategoryService;
import com.breadbox.service.dto.CategoryDto;

@Controller
@RequestMapping("/admin/edit-category")
public class EditCategoryController {

	@Autowired
	private CategoryService service;

	@GetMapping
	public String edit() {
		return "edit-category";
	}

	@PostMapping
	public String save(@ModelAttribute("category") @Validated CategoryDto category, BindingResult result) {
		// Check if there's validation error
		if (result.hasErrors()) {
			return "edit-category";
		}
		// Check if the category already exists
		if(service.findByName(category.getName()) != null) {
			result.addError(new FieldError("category", "name", "Category already exists."));
			return "edit-category";
		}
		// Save the category
		service.save(category);
		return "redirect:/admin/edit-category";
	}

	@PostMapping("/delete/{id}")
	public String delete(@PathVariable Integer id) {
		// Delete category using ID
		service.delete(id);
		return "redirect:/admin/edit-category";
	}
	
	@ModelAttribute("category")
	CategoryDto category(@RequestParam Optional<Integer> id) {
		// If ID exists return the Category object searched with the ID
		if (id.isPresent() && id.get() != 0) {
			return service.findById(id.get());
		}
		// Return new Category object if id does not exist
		return new CategoryDto();
	}
	
	@ModelAttribute("categoryList")
	List<CategoryDto> categoryList() {
		// Return all the categories
		return service.getAllCategories();
	}
}
