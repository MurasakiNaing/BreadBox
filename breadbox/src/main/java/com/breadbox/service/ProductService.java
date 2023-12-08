package com.breadbox.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.breadbox.service.dao.ProductDao;
import com.breadbox.service.dto.ProductDto;

@Service
@Transactional(readOnly = true)
public class ProductService {

	@Autowired
	private ProductDao dao;
	
	public ProductDto findById(int id) {
		return dao.findById(id);
	}
	
	public ProductDto findByName(String name) {
		return dao.findByName(name);
	}
	
	public List<ProductDto> searchProduct(String name) {
		return dao.searchProduct(name);
	}
	
	public List<ProductDto> getProducts() {
		return dao.getAllProduct();
	}
	
	public List<ProductDto> getTrendingProducts() {
		return dao.getTrendingProducts();
	}
	
	public List<ProductDto> getNewlyAddedProducts() {
		return dao.getNewlyAddedProducts();
	}
	
	@Transactional
	public void save(ProductDto product) {
		// Check if the product id is 0 or not.
		if(product.getId() == 0)
			// Call add product method if id is 0.
			dao.addProduct(product);
		else
			// Call update product method if id is not 0.
			dao.updateProduct(product);
	}

	@Transactional
	public void delete(int id) {
		dao.delete(id);
		
	}
}
