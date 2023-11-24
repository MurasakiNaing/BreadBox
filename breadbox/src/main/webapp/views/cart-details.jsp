<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
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
		<h1>My Cart</h1>
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
		            <div class="row">
		              <div class="col-8 col-md-10">
		                <h5 class="card-title">${item.product.name}</h5>
		              </div>
		              <div class="col-1">
		              	<c:url value="/cart-details/delete/${item.product.id}" var="deleteUrl"></c:url>
		              	<sf:form action="${deleteUrl}" method="post">
			                <button type="submit" class="btn btn-outline-danger"><i class="fa-regular fa-trash-can"></i></button>
		              	</sf:form>
		              </div>
		            </div>
		            <p class="card-text">${item.product.price}</p>
		            <div class="row">
		              <div class="col-8 col-md-10">
		                <div class="d-flex align-items-center mb-2">
		                  <c:url value="/cart-details/decrement/${item.product.id}" var="decrement"></c:url>
		                  <a href="${decrement}" class="btn btn-primary decrement-button" style="width: 40px;">-</a>
		                  <input type="text" class="mx-1 text-center border-0" style="width: 25px;" readonly value="${item.quantity}">
		                  <c:url value="/cart-details/increment/${item.product.id}" var="increment"></c:url>
		                  <a href="${increment}" class="btn btn-primary increment-button" style="width: 40px;">+</a>
		                </div>
		              </div>
		              <div class="col-3 col-md-2">
		                <p class="mt-2" style="width: fit-content;">${item.amount}</p>
		              </div>
		            </div>
		            <button type="button" class="btn btn-primary">
		              Add To card
		            </button>
		          </div>
		        </div>
		      </div>
		    </div>
		</c:forEach>
	</div>
</body>
</html>