package com.breadbox.service.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class CategoryDto {

	private int id;
	
	@NotBlank(message = "Category Name cannot be empty")
	private String name;
	
}
