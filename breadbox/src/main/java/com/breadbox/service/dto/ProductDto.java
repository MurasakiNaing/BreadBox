package com.breadbox.service.dto;

import lombok.Data;

@Data
public class ProductDto {

	private int id;
	
	private String image;
	
	private String name;
	
	private int category_id;
	
	private int price;
	
	private String description;
	
	
}
