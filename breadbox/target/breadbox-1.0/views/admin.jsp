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
	<div class="container">
		<h1>Welcome From BreadBox. <c:out value="${user.username}" /></h1>
		<c:url value="/admin/edit-category" var="editCategory"></c:url>
		<a href="${editCategory}" class="btn btn-primary">Category</a>
		<c:url value="/admin/edit-product" var="editProduct"></c:url>
		<a href="${editProduct}" class="btn btn-primary">Product Edit</a>
		<sf:form action="/logout">
			<button type="submit" class="btn btn-primary">Log Out</button>		
		</sf:form>
	</div>
</body>
</html>