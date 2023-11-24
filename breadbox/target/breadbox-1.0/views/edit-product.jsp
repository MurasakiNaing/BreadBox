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
	<div class="container">
	
		<c:url value="/admin/edit-product" var="editProduct"></c:url>
		<sf:form modelAttribute="product" action="${editProduct}" method="post" enctype="multipart/form-data">
			<sf:hidden path="id" value="0"/>
			<sf:hidden path="image" value="" />
			
			<div class="mb-3 col-9">
				<label for="upload">Image</label>
				<input name="upload" id="upload" type="file" accept="image/*" onchange="previewImage(this)" class="d-none" />
				<div style="width: 200px; height: 200px; border: dotted;" onclick="triggerFileInput()" id="cta">
					<p>Click To Add Image</p>
				</div>
				<img id="imagePreview" class="img-p d-none" src="" alt="" onclick="triggerFileInput()" style="width: 200px; height: 200px; display: block;">
				<sf:errors path="image"></sf:errors>
			</div>
			
			<div class="mb-3 col-9">
				<sf:label path="name">Name</sf:label>
				<sf:input type="text" path="name" placeholder="Enter Product Name" class="form-control rounded-0" />
				<sf:errors path="name" cssClass="text-danger"></sf:errors>
			</div>
			<div class="mb-3 col-9">
				<sf:label path="category_id">Category</sf:label>
				<sf:select path="category_id" cssClass="form-select">
					<sf:option value="0" label="Select A Category"></sf:option>
					<sf:options items="${categories}" itemValue="id" itemLabel="name" />
				</sf:select>
			</div>
			<div class="mb-3 col-9">
				<sf:label path="price">Price</sf:label>
				<sf:input type="number" path="price" placeholder="Enter Price" min="0" class="form-control rounded-0" />
				<sf:errors path="price" cssClass="text-danger"></sf:errors>
			</div>
			
			<div class="form-floating col-9 mb-3">
			  <sf:textarea path="description" class="form-control" placeholder="Product Description" id="floatingTextarea" cssStyle="height:100px;"></sf:textarea>
			  <sf:label path="description" for="floatingTextarea">Description</sf:label>
			</div>
			<div class="mb-3 col-3 d-grid">
				<button type="submit" class="btn btn-outline-primary rounded-0">Save</button>
			</div>
		</sf:form>
	
	</div>
</body>
</html>