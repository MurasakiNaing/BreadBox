<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders</title>
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
		<h1>Orders</h1>
		<c:if test="${not empty vouchers}">
			<table class="table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Date</th>
						<th>${user.role eq 'Admin' ? 'Email' : 'Location'}</th>
						<th>Total</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${vouchers}" var="voucher">
						<tr class="align-middle">
							<td>${voucher.id}</td>
							<td>${voucher.order_date}</td>
							<td>${user.role eq 'Admin' ? voucher.email : voucher.location}</td>
							<td>${voucher.total_amount}</td>
							<td>
								<c:url value="/orders/${voucher.id}" var="detailsUrl"></c:url>
								<a href="${detailsUrl}" class="btn btn-outline-info">
									<i class="fa-solid fa-info"></i> View
								</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>