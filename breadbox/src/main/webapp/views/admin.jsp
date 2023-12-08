<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
<c:url value="/resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="/resources/js/bootstrap.bundle.min.js" var="jsBs" />
<c:url value="/resources/js/all.js" var="jsFa" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
<script src="${jsFa}"></script>
</head>
<body>
	<jsp:include page="shared/navbar.jsp"></jsp:include>
	<div class="container mt-2">
		<h2>Trending Products</h2>
		<div class="row row-cols-1 row-cols-lg-3 g-3">
	        <c:forEach items="${trendingProducts}" var="product">
	        	<c:url value="details/${product.id}" var="details"></c:url>
	        	<div class="col">
	        		<div class="card border-0">
	        			<div class="row row-cols-2 row-cols-lg-1">
	        				<div class="col-5 col-md-4 pe-0 px-md-2">
	        					<c:url value="/details/${product.id}" var="details"></c:url>
	        					<a href="${details}">
		        					<img src="${product.image}" alt="product image" class="img-fluid w-100 h-100 rounded-4" />
	        					</a>
	        				</div>
	        				<div class="col-7 col-md-8">
	        					<div class="card-body px-0">
	        						<h5 class="card-title">${product.name}</h5>
	                  				<p class="card-text">${product.price}</p>
	                  				<c:if test="${user.role eq 'Admin'}">
		                  				<c:url value="/admin/edit-product" var="editUrl">
											<c:param name="id" value="${product.id}"></c:param>
										</c:url>
	                  					<a href="${editUrl}" class="btn btn-primary">Edit</a>
	                  					<sf:form action="/admin/edit-product/delete/${product.id}" cssClass="d-inline">
											<button type="submit" class="btn btn-danger">Delete</button>
										</sf:form>
	                  				</c:if>
	                  				<c:if test="${not(user.role eq 'Admin')}">
	                  					<c:url value="/add-to-cart/${product.id}" var="addToCart"></c:url>
	                  					<sf:form action="${addToCart}" method="get">
			                  				<div class="d-flex align-items-center mb-2">
			                  					<button type="button" class="btn btn-primary decrement-button" style="width: 40px;">-</button>
							                    <input type="text" name="quantity" class="mx-1 text-center border-0" style="width: 25px;" readonly value="1">
							                    <button type="button" class="btn btn-primary increment-button" style="width: 40px;">+</button>
			                  				</div>
			                  				
			                  				<button type="submit" class="btn btn-outline-primary">
			                  					Add To Cart
			                  				</button>                  					
	                  					</sf:form>
	                  				</c:if>
	        					</div>
	        				</div>
	        			</div>
	        		</div>
	        	</div>
	        </c:forEach>
	      </div>
	</div>
	
	<div class="container mt-2">
		<h2>Newly Added Products</h2>
		<div class="row row-cols-1 row-cols-lg-3 g-3">
	        <c:forEach items="${newProducts}" var="product">
	        	<c:url value="details/${product.id}" var="details"></c:url>
	        	<div class="col">
	        		<div class="card border-0">
	        			<div class="row row-cols-2 row-cols-lg-1">
	        				<div class="col-5 col-md-4 pe-0 px-md-2">
	        					<c:url value="/details/${product.id}" var="details"></c:url>
	        					<a href="${details}">
		        					<img src="${product.image}" alt="product image" class="img-fluid w-100 h-100 rounded-4" />
	        					</a>
	        				</div>
	        				<div class="col-7 col-md-8">
	        					<div class="card-body px-0">
	        						<h5 class="card-title">${product.name}</h5>
	                  				<p class="card-text">${product.price}</p>
	                  				<c:if test="${user.role eq 'Admin'}">
		                  				<c:url value="/admin/edit-product" var="editUrl">
											<c:param name="id" value="${product.id}"></c:param>
										</c:url>
	                  					<a href="${editUrl}" class="btn btn-primary">Edit</a>
	                  					<sf:form action="/admin/edit-product/delete/${product.id}" cssClass="d-inline">
											<button type="submit" class="btn btn-danger">Delete</button>
										</sf:form>
	                  				</c:if>
	                  				<c:if test="${not(user.role eq 'Admin')}">
	                  					<c:url value="/add-to-cart/${product.id}" var="addToCart"></c:url>
	                  					<sf:form action="${addToCart}" method="get">
			                  				<div class="d-flex align-items-center mb-2">
			                  					<button type="button" class="btn btn-primary decrement-button" style="width: 40px;">-</button>
							                    <input type="text" name="quantity" class="mx-1 text-center border-0" style="width: 25px;" readonly value="1">
							                    <button type="button" class="btn btn-primary increment-button" style="width: 40px;">+</button>
			                  				</div>
			                  				
			                  				<button type="submit" class="btn btn-outline-primary">
			                  					Add To Cart
			                  				</button>                  					
	                  					</sf:form>
	                  				</c:if>
	        					</div>
	        				</div>
	        			</div>
	        		</div>
	        	</div>
	        </c:forEach>
	      </div>
	</div>
</body>
</html>