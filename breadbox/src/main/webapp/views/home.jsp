<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<c:if test="${not empty orderSuccessMessage}">
			<div class="toast show align-items-center text-bg-info border-0 mb-3 mt-3 w-75 mx-auto" role="alert" aria-live="assertive" aria-atomic="true">
			    <div class="d-flex">
			      <div class="toast-body">
			        <c:out value="${orderSuccessMessage}"></c:out>
			      </div>
			      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
			    </div>
			  </div>
		</c:if>
		<h1>Welcome From BreadBox.</h1>
		<c:url value="/login" var="login"></c:url>
		<a href="${login}" class="btn btn-primary">Sign In</a>
		
		<c:url value="/sign-up" var="signUp"></c:url>
		<a href="${signUp}" class="btn btn-primary">Sign Up</a>
	</div>
</body>
</html>