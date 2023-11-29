package com.breadbox.service.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SaleItems {

	private int id;
	private int voucher_id;
	private ProductDto product;
	private int quantity;
	private int amount;
	
	public void addQty(int qty) {
		quantity += qty;
		amount = qty * amount;
	}
	
	public void changeQuantity(boolean increment) {
		if(increment)
			incrementQty();
		else
			decrementQty();
	}
	
	private void incrementQty() {
		// Increment the quantity
		quantity++;
		// Change the amount value
		amount = product.getPrice() * quantity;
	}
	
	private void decrementQty() {
		// Decrement the quantity
		quantity--;
		// Change the amount value
		amount = product.getPrice() * quantity;
	}

	public SaleItems(ProductDto product, int quantity) {
		this.product = product;
		this.quantity = quantity;
		amount = product.getPrice() * quantity;
	}
	
	
}
