package com.breadbox.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.breadbox.service.dao.CheckoutDao;
import com.breadbox.service.dto.OrderDto;
import com.breadbox.service.dto.SaleItems;
import com.breadbox.service.dto.VoucherDto;

@Service
@Transactional(readOnly = true)
public class CheckoutService {

	@Autowired
	private CheckoutDao dao;
	
	public List<SaleItems> getVoucherItems(int voucher_id) {
		return dao.getVoucherItems(voucher_id);
	}
	
	public List<VoucherDto> getAllVouchers() {
		return dao.getAllVouchers();
	}
	
	public List<VoucherDto> getVouchersUser(String email) {
		return dao.getAllVouchersUser(email);
	}
	
	public VoucherDto getVoucher(int voucher_id) {
		return dao.getVoucher(voucher_id);
	}
	
	public List<OrderDto> getOrder(int voucher_id) {
		return dao.getOrder(voucher_id);
	}
	
	@Transactional
	public void order(VoucherDto voucher, List<SaleItems> items) {
		dao.order(voucher, items);
	}
	
}
