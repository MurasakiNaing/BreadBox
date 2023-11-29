<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Out</title>
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
		<h1>Checkout</h1>
		<div class="row">
        <!-- Left Column - Items to be ordered -->
        <div class="col-lg-8">
            <h2>Items to be Ordered</h2>
            	<div class="row">
			            <c:forEach items="${cart.items}" var="item">
			            	<div class="card border-0 mt-3">
				                <div class="row">
				                  <div class="col-5 col-md-4 pe-0">
				                    <img
				                      src="${item.product.image}"
				                      class="img-fluid rounded-4"
				                      alt="image"
				                    />
				                  </div>
				                  <div class="col-7 col-md-8">
				                    <div class="card-body px-0">
				                    <div class="col-8 col-md-10">
				                        <h5 class="card-title">${item.product.name}</h5>
				                    </div>
				                      <p class="card-text">${item.quantity}</p>
				                      <p class="card-text">${item.amount}</p>
				                      <c:if test="${item.quantity gt 1}">
				                      	<p class="card-text text-secondary">${item.product.price} each</p>
				                      </c:if>
				                    </div>
				                  </div>
				                </div>
			              	</div>
			            </c:forEach>
			        </div>
        </div>

        <!-- Right Column - Total amount and payment method -->
        <div class="col-md-4 mt-3 mt-lg-0">
            <h2>Total Amount</h2>
            <p class="mb-2">Total: ${cart.getTotal()}</p>

            <div class="mb-3">
            	<c:url value="/checkout" var="checkout"></c:url>
            	<sf:form action="${checkout}" method="post">
	            	<label for="location" class="form-label">Delivery Location</label>
	            	<input type="text" class="form-control" name="location" placeholder="Please Enter Delivery Location" />
            		<p class="text-danger">${locationError}</p>
            		<label for="phone" class="form-label">Phone Number</label>
            		<input type="text" class="form-control" name="phone" placeholder="Please Enter Phone Number" />
            		<p class="text-danger">${phoneError}</p>
	                <label for="paymentMethod" class="form-label">Payment Method</label>
	                <select name="paymentMethod" class="form-select" id="paymentMethod">
	                    <option value="">Select Payment Method</option>
	                    <option value="Cash On Delivery" selected>Cash On Delivery</option>
	                    <option value="PayPal" disabled>PayPal</option>
	                </select>
	                <p class="text-danger">${optionError}</p>
		            <button type="submit" class="btn btn-primary">Place Order</button>
            	</sf:form>
            </div>

        </div>
    </div>
	</div>
</body>
</html>