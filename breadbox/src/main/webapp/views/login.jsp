<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<c:url value="/resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="/resources/js/bootstrap.bundle.min.js" var="jsBs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
</head>
<body>
	<div class="row d-flex justify-content-center m-0 mt-5">
		
		<div class="col-lg-6 col-md-9">
			
			<h1 class="mb-3">Logo</h1>
		
			<div class="mb-4">
				<h3>Log In</h3>
				<h5 class="text-secondary">Continue to BreadBox</h5>
			</div>
			<h6 class="text-danger"><c:out value="${error}"></c:out></h6>
			<c:url value="/login" var="loginUrl" />
			<sf:form action="${loginUrl}" method="post" cssClass="w-100">
				<div class="mb-3">
					<label for="username" class="form-label">Email</label>
					<input type="text" name="username" placeholder="Enter Login Email" required="required" class="form-control rounded-0" />
				</div>
			
				<div class="mb-3">
					<label for="password" class="form-label">Password</label>
					<input type="password" name="password" placeholder="Enter Password" required="required" class="form-control rounded-0" />
				</div>
				<div class="mb-3">
					<input type="checkbox" name="remember-me" id="rememberMe" class="form-check-input rounded-0" />
					<label for="rememberMe" class="form-check-label">Keep Me Logged In</label>
				</div>
				
				<div class="mb-3">
					<button type="submit" class="btn btn-outline-primary w-100 rounded-0">Log In</button>
				</div>
			</sf:form>
			<p class="text-muted forgot-pw mb-3">Forgot Password?</p>	
			<hr/>
			<c:url value="/sign-up" var="signUp"></c:url>
			<p>Don't have an account?<a href="${signUp}"> Get Started</a></p>
		</div>
	</div>
</body>
</html>