<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
<c:url value="resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="resources/js/bootstrap.bundle.min.js" var="jsBs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
</head>
<body>
	<div class="container">
		<h1>Welcome From BreadBox. Admin</h1>
		<sf:form action="/logout">
			<button type="submit" class="btn btn-primary">Log Out</button>		
		</sf:form>
	</div>
</body>
</html>