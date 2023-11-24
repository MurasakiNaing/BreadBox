<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
<c:url value="/resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="/resources/js/bootstrap.bundle.min.js" var="jsBs" />
<c:url value="/resources/js/all.js" var="jsFa" />
<c:url value="/resources/js/product.js" var="jsProduct" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
<script src="${jsFa}"></script>
<script src="${jsProduct}" defer></script>
</head>
<body>
	<jsp:include page="shared/navbar.jsp"></jsp:include>
	<div class="container mt-2 justify-content-center">
	
		<c:if test="${user.role eq 'Admin'}">
			<c:url value="/admin/edit-product" var="editUrl">
				<c:param name="id" value="${product.id}"></c:param>
			</c:url>
			<div class="mb-2 col-9 mx-auto mx-lg-0">
				<a href="${editUrl}" class="btn btn-info">Edit</a>
				<a href="${editUrl}" class="btn btn-danger">Delete</a>
			</div>
		</c:if>
		<div class="mb-3 col-lg-9">
			<img class="mx-auto mx-lg-0" src="${product.image}" alt="" style="width: 350px; height: 350px; display: block;">
		</div>
		<div class="mb-3 col-9 mx-auto mx-lg-0">
			<label for="name" class="ms-0">Name</label>
			<input type="text" name="name" value="${product.name}" readonly="readonly" class="form-control rounded-0" />
		</div>
		
		<div class="mb-3 col-9 mx-auto mx-lg-0">
			<label for="category">Category</label>
			<input type="text" name="category" readonly="readonly" value="${category.name}" class="form-control rounded-0" />
		</div>
		
		<div class="mb-3 col-9 mx-auto mx-lg-0">
			<label for="price">Price</label>
			<input type="number" name="price" readonly="readonly" value="${product.price}" class="form-control rounded-0" />
		</div>
		
		<div class="mb-3 col-9 mx-auto mx-lg-0">
			<label for="description">Description</label>
			<textarea placeholder="${product.description}" readonly="readonly" class="form-control"></textarea>
		</div>
		<c:if test="${not (user.role eq 'Admin')}">
			<button class="btn btn-outline-success mb-2">Add To Cart</button>
		</c:if>
	</div>
</body>
</html>