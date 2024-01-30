package com.breadbox.service.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;

@Data
public class OrderDto {

	private int voucher_id;
	private ProductDto product;
	private int quantity;
	private int amount;
	private LocalDate order_date;
	private LocalTime order_time;
	private String location;
	private int total_amount;
	private String paymentMethod;
	
}
