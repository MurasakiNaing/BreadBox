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
		<h1>Add Category</h1>
		<c:url value="/admin/edit-category" var="editCategory"></c:url>
		<sf:form modelAttribute="category" action="${editCategory}" method="post">		
			<sf:hidden path="id"/>
			<div class="row">
					<sf:label path="name" cssClass="form-label">Category Name</sf:label>
				<div class="mb-3 col-9">
					<sf:input type="text" path="name" placeholder="Enter Category Name" class="form-control rounded-0" />
					<sf:errors path="name" cssClass="text-danger"></sf:errors>
				</div>
				
				<div class="mb-3 col-3 d-grid">
					<button type="submit" class="btn btn-outline-primary rounded-0">Save</button>
				</div>
			</div>
		</sf:form>
		
		<table class="table table-primary table-striped">
			<thead>
			    <tr>
			      <th scope="col" colspan="3" class="text-center">Category Name</th>
			    </tr>
			</thead>
			<tbody>
			 	<c:if test="${not empty categoryList}">
			 		<c:forEach items="${categoryList}" var="cat">			 			
				 		<tr>
							<td class="col-9 text-center p-1 align-middle">${cat.name}</td>
							<c:url value="/admin/edit-category" var="editCategory">
								<c:param name="id" value="${cat.id}"></c:param>
							</c:url>
							<td class="col-2 p-1"><a href="${editCategory}" class="btn btn-outline-success rounded-0 d-grid">Edit</a></td>
							<td class="col-1 p-1 text-center">
								<button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modal${cat.id}"><i class="fa-regular fa-trash-can"></i></button>
							</td>
						</tr>
			 			<div class="modal fade" id="modal${cat.id}" tabindex="-1" aria-labelledby="modalLabel${cat.id}" aria-hidden="true">
					        <div class="modal-dialog modal-dialog-centered">
					          <div class="modal-content">
					            <div class="modal-header">
					              <h1 class="modal-title fs-5" id="modalLabel">Warning</h1>
					              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            <div class="modal-body">
					              <p>Deleting the Category will delete products related to it.</p>
					            </div>
					            <div class="modal-footer">
					              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					              <c:url value="edit-category/delete/${cat.id}" var="deleteLink"></c:url>
					              <sf:form action="${deleteLink}" method="post">
					            	<button class="btn btn-danger" type="submit">Delete</button>
								  </sf:form>
					            </div>
					          </div>
					        </div>
					      </div>
			 		</c:forEach>
			 	</c:if>
			</tbody>
		</table>
	</div>
	
</body>
</html>