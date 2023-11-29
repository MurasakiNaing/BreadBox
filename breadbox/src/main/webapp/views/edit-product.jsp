<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.id == 0 ? 'Add New' : 'Edit'} Product</title>
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
		<h1>${product.id == 0 ? 'Add New' : 'Edit'} Product</h1>
		
		<c:if test="${product.id != 0}">
			<div class="toast show align-items-center text-bg-info border-0 mb-3 mt-3" role="alert" aria-live="assertive" aria-atomic="true">
			    <div class="d-flex">
			      <div class="toast-body">
			        To change the image, click on current image.
			      </div>
			      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			    </div>
			</div>
		</c:if>
		
		<c:if test="${product.id != 0}">
			<sf:form action="edit-product/delete/${product.id}">
				<button type="submit" class="btn btn-danger">Delete</button>
			</sf:form>
		</c:if>
		
		<c:url value="/admin/edit-product" var="editProduct"></c:url>
		<sf:form modelAttribute="product" action="${editProduct}" method="post" enctype="multipart/form-data">
			<sf:hidden path="id"/>
			<sf:hidden path="image"/>
			<div class="mb-3 col-9">
				<label for="upload">Image</label>
				<input name="upload" id="upload" type="file" accept="image/*" onchange="previewImage(this)" class="d-none" />
				<div style="width: 200px; height: 200px; border: dotted;" onclick="triggerFileInput()" id="cta" class="${product.id == 0 ? '' : 'd-none'}">
					<p>Click To Add Image</p>
				</div>
				<img id="imagePreview" class="${product.id != 0 ? '' : 'd-none'}" src="${product.id == 0 ? '' : product.image}" alt="" onclick="triggerFileInput()" style="width: 200px; height: 200px; display: block;">
				<button class="btn btn-outline-danger mt-2" type="button" onclick="removeImage()" id="imgRemove">Remove Image</button>
			</div>
			
			<div class="mb-3 col-9">
				<sf:label path="name">Name</sf:label>
				<sf:input type="text" path="name" placeholder="Enter Product Name" class="form-control rounded-0" />
				<p class="text-danger">${nameError}</p>
			</div>
			<div class="mb-3 col-9">
				<sf:label path="category_id">Category</sf:label>
				<sf:select path="category_id" cssClass="form-select">
					<sf:option value="0" label="Select A Category"></sf:option>
					<sf:options items="${categories}" itemValue="id" itemLabel="name" />
				</sf:select>
				<p class="text-danger">${categoryError}</p>
			</div>
			<div class="mb-3 col-9">
				<sf:label path="price">Price</sf:label>
				<sf:input type="number" path="price" placeholder="Enter Price" min="0" class="form-control rounded-0" />
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