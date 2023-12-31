package com.breadbox.service.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class Cart {

	private List<SaleItems> items;

	public Cart() {
		this.items = new ArrayList<>();
	}
	
	public void addToCart(ProductDto product, int qty) {
		var item = getItem(product.getId());
		if(item != null) {
			// If item is already in cart increment
			item.addQty(qty);
		}
		// If the item is not in class add it to cart
		items.add(new SaleItems(product, qty));
	}
	
	public void changeQuantity(boolean increment, int id) {
		var item = getItem(id);
		if(item != null) {
			item.changeQuantity(increment);
			// When quantity is 0 remove the item from cart
			if(item.getQuantity() == 0)
				items.remove(item);
		}
	}
	
	public int getTotal() {
		return items.stream().mapToInt(SaleItems::getAmount).sum();
	}
	
	public int getCartSize() {
		return items.size();
	}
	
	public void removeFromCart(int id) {
		var item = getItem(id);
		if(item != null) {
			items.remove(item);
		}
	}
	
	public void clearCart() {
		items.clear();
	}
	
	public VoucherDto createVoucher(String location, String phone, String paymentMethod, String email) {
		// Create voucher object
		VoucherDto voucher = new VoucherDto();
		// Set total for voucher
		voucher.setTotal_amount(getTotal());
		// Set location for voucher
		voucher.setLocation(location);
		// Set phone number for voucher
		voucher.setPhone(phone);
		// Set voucher order date
		voucher.setOrder_date(LocalDate.now());
		// Set voucher order time
		voucher.setOrder_time(LocalTime.now());
		// Set voucher payment method
		voucher.setPaymentMethod(paymentMethod);
		// Set email to voucher
		voucher.setEmail(email);
		return voucher;
	}
	
	private SaleItems getItem(int id) {
		return items.stream().filter(item -> item.getProduct().getId() == id).findFirst().orElse(null);
	}
}
