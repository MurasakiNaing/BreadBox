<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart Details</title>
<c:url value="/resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="/resources/js/bootstrap.bundle.min.js" var="jsBs" />
<c:url value="/resources/js/all.js" var="jsFa" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
<script src="${jsFa}"></script>
</head>
<body>
	
	<jsp:include page="shared/navbar.jsp"></jsp:include>
	<div class="container">
		<h1>Order Details</h1>
		<p>Voucher ID: ${voucher.id}</p>
		<p>Order Date: ${voucher.order_date}</p>
		<p>Order Time: ${voucher.order_time }</p>
		<c:if test="${not empty items}">
			<c:forEach items="${items}" var="item">
				<div class="card border-0 mt-3">
			      <div class="row row-cols-2">
			        <div class="col-5 col-md-4 col-lg-3 pe-0 ">
			          <img
			            src="${item.product.image}"
			            class="img-fluid rounded-4"
			            alt="image"
			          />
			        </div>
			        <div class="col-7 col-md-8 col-lg-9">
			          <div class="card-body px-0">
		                <h5 class="card-title">${item.product.name}</h5>
			            <p class="card-text text-secondary">${item.product.price} each</p>
			            <div class="row">
			              <div class="col-8 col-md-10">
			                <div class="d-flex align-items-center mb-2">
			                  <input type="text" class="mx-1 text-center border-0" style="width: 25px;" readonly value="${item.quantity}">
			                </div>
			              </div>
			              <div class="col-3 col-md-2">
			                <p class="mt-2" style="width: fit-content;">${item.amount}</p>
			              </div>
			            </div>
			          </div>
			        </div>
			      </div>
			    </div>
			</c:forEach>
		</c:if>
		<hr />
		<p>Delivery Location: ${voucher.location}</p>
		<p>Payment Type: ${voucher.paymentMethod}</p>
		<p>Total: ${voucher.total_amount}</p>
	</div>
</body>
</html>