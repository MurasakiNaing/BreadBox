<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<c:url value="resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="resources/js/bootstrap.bundle.min.js" var="jsBs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
</head>
<body>
	<div class="row d-flex justify-content-center m-0 mt-5">
		
		<div class="col-lg-6 col-md-9">
			
			<h1 class="mb-3">Logo</h1>
		
			<div class="mb-4">
				<h3>Create Breadbox Account</h3>
				<h5 class="text-secondary">One Last Step before using our services</h5>
			</div>
			<h6 class="text-danger"><c:out value="${error}"></c:out></h6>
			<c:url value="/sign-up" var="signupUrl" />
			<sf:form action="${signupUrl}" modelAttribute="form" method="post" cssClass="w-100">
				
				<div class="mb-3">
					<sf:label path="username" cssClass="form-label">Username</sf:label>
					<sf:input type="text" path="username" placeholder="Enter Username" class="form-control rounded-0" />
					<sf:errors path="username" cssClass="text-danger"></sf:errors>
				</div>
			
				<div class="mb-3">
					<sf:label path="email" class="form-label">Email</sf:label>
					<sf:input type="text" path="email" placeholder="Enter Login Email" class="form-control rounded-0" />
					<sf:errors path="email" cssClass="text-danger"></sf:errors>
				</div>
			
				<div class="mb-3">
					<sf:label path="password" class="form-label">Password</sf:label>
					<sf:input type="password" path="password" placeholder="Enter Password" class="form-control rounded-0" />
					<sf:errors path="password" cssClass="text-danger"></sf:errors>
				</div>
				<div class="mb-3">
					<sf:label path="confirmPassword" class="form-label">Confirm Password</sf:label>
					<sf:input type="password" path="confirmPassword" placeholder="Enter Password" class="form-control rounded-0" />
					<sf:errors path="confirmPassword" cssClass="text-danger"></sf:errors>
				</div>
				
				<div class="mb-3">
					<button type="submit" class="btn btn-outline-primary w-100 rounded-0">Sign Up</button>
				</div>
			</sf:form>
			<hr/>
			<p>Already have an account? Log In</p>
		</div>
	</div>
</body>
</html>