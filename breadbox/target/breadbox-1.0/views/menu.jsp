<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu</title>
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
		<h1>Menu</h1>
		<div class="container">
      <div class="row row-cols-1 row-cols-lg-3 g-3">
        <div class="col">
          <div class="card border-0">
            <div class="row row-cols-2 row-cols-lg-1">
           	<c:url value="/resources/images/product-images/default-product.png" var="defaultImg" />
              <div class="col-4">
                <img
                  src="${defaultImg}"
                  class="img-fluid rounded-start"
                  alt="image"
                />
              </div>
              <div class="col-8 mt-md-auto mb-md-auto">
                <div class="card-body px-0">
                  <h5 class="card-title">Product</h5>
                  <p class="card-text">Price</p>
                  <button type="button" class="btn btn-primary">
                    Add To cart
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card border-0">
            <div class="row row-cols-2 row-cols-lg-1">
              <div class="col-4">
                <img
                  src="${defaultImg}"
                  class="img-fluid rounded-start"
                  alt="image"
                />
              </div>
              <div class="col-8 mt-md-auto mb-md-auto">
                <div class="card-body px-0">
                  <h5 class="card-title">Product</h5>
                  <p class="card-text">Price</p>
                  <button type="button" class="btn btn-primary">
                    Add To cart
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card border-0">
            <div class="row row-cols-2 row-cols-lg-1">
              <div class="col-4">
                <img
                  src="${defaultImg}"
                  class="img-fluid rounded-start"
                  alt="image"
                />
              </div>
              <div class="col-8 mt-md-auto mb-md-auto">
                <div class="card-body px-0">
                  <h5 class="card-title">Product</h5>
                  <p class="card-text">Price</p>
                  <button type="button" class="btn btn-primary">
                    Add To cart
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card border-0">
            <div class="row row-cols-2 row-cols-lg-1">
              <div class="col-4">
                <img
                  src="${defaultImg}"
                  class="img-fluid rounded-4"
                  alt="image"
                />
              </div>
              <div class="col-8 mt-md-auto mb-md-auto">
                <div class="card-body px-0">
                  <h5 class="card-title">Product</h5>
                  <p class="card-text">Price</p>
                  <button type="button" class="btn btn-primary">
                    Add To cart
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <c:if test="${not empty products}">
    	<p>List is not Empty</p>
    </c:if>
    
	</div>
</body>
</html>