package com.breadbox.service.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;

@Data
public class VoucherDto {

	private int id;
	private LocalDate order_date;
	private LocalTime order_time;
	private String location;
	private int total_amount;
	private String phone;
	private String paymentMethod;
	private String email;

}
