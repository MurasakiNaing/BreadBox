<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<c:url value="resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="resources/js/bootstrap.bundle.min.js" var="jsBs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
</head>
<body>
	<div class="container">
		<h1>Welcome From BreadBox.</h1>
		<c:url value="/login" var="login"></c:url>
		<a href="${login}" class="btn btn-primary">Sign In</a>
	</div>
</body>
</html>