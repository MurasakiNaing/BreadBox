package com.breadbox.service.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.breadbox.service.dto.ProductDto;
import com.breadbox.service.dto.SaleItems;
import com.breadbox.service.dto.VoucherDto;

@Repository
public class CheckoutDao {

	@Autowired
	@Qualifier("checkout")
	private SimpleJdbcInsert insert;

	public void order(VoucherDto voucher, List<SaleItems> items) {
		// Add voucher to voucher table
		var voucher_id = insert.executeAndReturnKey(getVoucherInsert(voucher)).intValue();
		// Set voucher id for all the sale items
		setVoucherIdForItems(items, voucher_id);
		
		// Get JDBC Template
		var template = insert.getJdbcTemplate();

		// SQL String
		String sql = "insert into sale_items (voucher_id, product_id, qty, price, product_name, product_image, amount) values (?, ?, ?, ?, ?, ?, ?)";
		template.batchUpdate(sql, getSaleItemsBatch(items));
	}

	public List<SaleItems> getVoucherItems(int voucher_id) {
		// Get JDBC Template
		var template = insert.getJdbcTemplate();
		var sql = "select * from sale_items where voucher_id = %d";
		return template.query(sql.formatted(voucher_id), getItemRowMapper());
	}
	
	public List<VoucherDto> getAllVouchers() {
		var template = insert.getJdbcTemplate();
		var sql = "select * from voucher";
		return template.query(sql, getVoucherRowMapper());
	}
	
	public List<VoucherDto> getAllVouchersUser(String email) {
		var template = insert.getJdbcTemplate();
		var sql = "select * from voucher where email = '%s'";
		return template.query(sql.formatted(email), getVoucherRowMapper());
	}
	
	public VoucherDto getVoucher(int voucher_id) {
		var template = insert.getJdbcTemplate();
		var sql = "select * from voucher where id = %d";
		return template.queryForObject(sql.formatted(voucher_id), getVoucherRowMapper());
	}
	
	private RowMapper<SaleItems> getItemRowMapper() {
		RowMapper<SaleItems> rm = (rs, rowNum) -> {
			var item = new SaleItems();
			item.setId(rs.getInt("id"));
			item.setVoucher_id(rs.getInt("voucher_id"));
			item.setProduct(getProductDto(rs));
			item.setAmount(rs.getInt("amount"));
			return item;
		};
				
		return rm;
	}
	
	private RowMapper<VoucherDto> getVoucherRowMapper() {
		RowMapper<VoucherDto> rm = (rs, rowNum) -> {
			var voucher = new VoucherDto();
			voucher.setId(rs.getInt("id"));
			voucher.setOrder_date(rs.getDate("order_date").toLocalDate());
			voucher.setLocation(rs.getString("location"));
			voucher.setTotal_amount(rs.getInt("total_amount"));
			voucher.setPhone(rs.getString("phone"));
			voucher.setPaymentMethod(rs.getString("paymentMethod"));
			voucher.setEmail(rs.getString("email"));
			voucher.setOrder_time(rs.getTime("order_time").toLocalTime());
			return voucher;
		};
		return rm;
	}
	
	private ProductDto getProductDto(ResultSet rs) throws SQLException {
		var product = new ProductDto();
		product.setId(rs.getInt("product_id"));
		product.setName(rs.getString("product_name"));
		product.setPrice(rs.getInt("price"));
		product.setImage(rs.getString("product_image"));
		return product;
	}
	
	private List<Object[]> getSaleItemsBatch(List<SaleItems> items) {
		// Create Batch for SaleItems
		List<Object[]> batch = new ArrayList<>();
		for (SaleItems item : items) {
			Object[] value = new Object[] { item.getVoucher_id(), item.getProduct().getId(), item.getQuantity(),
					item.getProduct().getPrice(), item.getProduct().getName(), item.getProduct().getImage(),
					item.getAmount() };
			batch.add(value);
		}
		return batch;
	}

	private void setVoucherIdForItems(List<SaleItems> items, int voucherId) {
		items.forEach(item -> item.setVoucher_id(voucherId));
	}
	
	private Map<String, Object> getVoucherInsert(VoucherDto voucher) {
		Map<String, Object> map = new HashMap<>();
		map.put("order_date", Date.valueOf(voucher.getOrder_date()));
		map.put("order_time", Time.valueOf(voucher.getOrder_time()));
		map.put("location", voucher.getLocation());
		map.put("total_amount", voucher.getTotal_amount());
		map.put("phone", voucher.getPhone());
		map.put("paymentMethod", voucher.getPaymentMethod());
		map.put("email", voucher.getEmail());
		return map;
	}
}
