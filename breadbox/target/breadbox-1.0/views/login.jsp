<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<c:url value="resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="resources/js/bootstrap.bundle.min.js" var="jsBs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
</head>
<body>
	<div class="container">
		<h1>Sign In</h1>
		<h3 class="text-secondary">Please sign in to continue</h3>
	</div>
</body>
</html>