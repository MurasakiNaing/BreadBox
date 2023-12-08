<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Setting</title>
<c:url value="/resources/css/bootstrap.min.css" var="cssBs" />
<c:url value="/resources/js/bootstrap.bundle.min.js" var="jsBs" />
<c:url value="/resources/js/user.js" var="userJs" />
<link rel="stylesheet" href="${cssBs}">
<script src="${jsBs}"></script>
<script src="${userJs}" defer></script>
</head>
<body onload="loadUsernameModal(${not empty usernameError}); loadPasswordModal(${not empty currentPasswordError or not empty newPasswordError})">
	<jsp:include page="shared/navbar.jsp"></jsp:include>
    <div class="container">

      <h2>My Account</h2>

      <div class="containter">
        <div class="row">
          <div class="col">
            <img src="${user.profilepic}" id="current" class="rounded-circle d-inline-block" style="width: 80px; height: 80px;" alt="image">
            <img src="#" id="imagePreview" class="rounded-circle d-none" style="width: 80px; height: 80px;" alt="image">
            <p class="d-inline-block">${user.username}</p>
          </div>
          <div class="col text-end align-self-center">
            <button class="btn btn-primary" onclick="triggerFileInput()">Edit Profile</button>
          </div>
        </div>
        <c:url value="/settings/change-profile" var="changeProfile"></c:url>
        <sf:form action="${changeProfile}" method="post" class="mt-3 d-none" id="form-btn" enctype="multipart/form-data">
          <input type="file" class="d-none" id="imageUpload" name="imageUpload" accept="image/*" onchange="previewImage(this)">
          <button class="btn btn-primary" type="submit">Save</button>
          <button class="btn btn-danger" type="button" onclick="discard()">Discard</button>
        </sf:form>
        <hr>
        <div class="row">
          <div class="form-floating col">
            <input type="text" class="form-control border-0 ps-0" style="background-color: transparent;" disabled value="${user.username}">
            <label for="floatingInput">Username</label>
          </div>
          <div class="col text-end align-self-center">
            <button type="button" id="editUsernameBtn" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#editUsername">
              Edit
            </button>

            <div class="modal fade" id="editUsername" tabindex="-1" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                  <div class="modal-header border-0">
                    <h5 class="modal-title" id="modalTitleId">Change Username</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <c:url value="/settings/username-edit" var="editUsername"></c:url>
                  <sf:form id="usernameForm" action="${editUsername}" method="post">
                    <div class="modal-body">
                        <div class="form-floating mb-3">
                          <input type="text" name="username" class="form-control" placeholder="" value="${user.username}" required>
                          <label for="username">Username</label>
                          <p class="text-danger">${usernameError}</p>
                        </div>
                      </div>
                      <div class="modal-footer border-0">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                      </div>
                  </sf:form>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="row">
          <div class="form-floating">
            <input type="email" class="form-control border-0 ps-0" style="background-color: transparent;" disabled value="${user.email}">
            <label for="floatingInput">Email address</label>
          </div>
        </div>
      </div>
      <hr>
  
      <div class="container-fluid mt-2 px-0">
        <h3>Account Credentials</h3>
        <button type="button" class="btn btn-info" id="changePasswordBtn" data-bs-toggle="modal" data-bs-target="#editPassword">
          Change Password
        </button>
        
        <div class="modal fade" id="editPassword" tabindex="-1" role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title" id="modalTitleId">Change Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <c:url value="/settings/change-password" var="changePassword"></c:url>
              <sf:form action="${changePassword}" method="post">
                <div class="modal-body">
                    <div class="form-floating mb-3">
                      <input type="password" name="currentPassword" class="form-control" placeholder="">
                      <label for="currentPassword">Current Password</label>
                      <p class="text-danger">${currentPasswordError}</p>
                    </div>
                    <div class="form-floating mb-3">
                      <input type="password" name="newPassword" class="form-control" placeholder="">
                      <label for="newPassword">New Password</label>
                      <p class="text-danger">${newPasswordError}</p>
                    </div>
                  </div>
                  <div class="modal-footer border-0">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                  </div>
              </sf:form>
            </div>
          </div>
        </div>
      </div>
    </div>
</body>
</html>