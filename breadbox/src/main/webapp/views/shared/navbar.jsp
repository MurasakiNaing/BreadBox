<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>


<c:choose>
	<c:when test="${not empty user}">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button"
					data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
					aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<a class="navbar-brand" href="#">Navbar</a>
			</div>

			<div class="offcanvas offcanvas-start" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">
						<c:url value="${user.profilepic}" var="profile" />
						<img src="${profile}" class="img-rounded" alt="Profile Image"
							style="width: 40x; height: 40px" />
					</h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav me-2 mt-1">
						<c:choose>
							<c:when test="${user.role eq 'Admin'}">
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Home</a></li>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Product</a></li>
								<li class="nav-item dropdown mt-1"><a
									class="nav-link active dropdown-toggle" href="#" role="button"
									data-bs-toggle="dropdown" aria-expanded="false"> Add New </a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#">Product</a></li>
										<li><hr class="dropdown-divider" /></li>
										<li><a class="dropdown-item" href="#">Category</a></li>
									</ul></li>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Orders</a></li>
							</c:when>
							<c:otherwise>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Home</a></li>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Menu</a></li>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">About</a></li>
								<li class="nav-item mt-1"><a class="nav-link active"
									href="#">Order</a></li>
							</c:otherwise>
						</c:choose>

						<li class="nav-item d-lg-none d-xl-none d-xxl-none"><a
							class="nav-link active" href="#">Profile</a></li>
						<li class="nav-item d-lg-none d-xl-none d-xxl-none"><a
							class="nav-link active" href="#">Settings</a></li>
						<li class="nav-item d-lg-none d-xl-none d-xxl-none"><a
							class="nav-link active" href="#">Log Out</a></li>

						<div class="dropdown d-none d-lg-inline d-xl-inline d-xxl-inline">
							<a class="dropdown-toggle d-flex align-items-center" href="#"
								id="navbarDropdownMenuAvatar" role="button"
								data-bs-toggle="dropdown" data-bs-display="static"
								aria-expanded="false"> <c:url value="${user.profilepic}"
									var="profile" /> <img src="${profile}" class="img-rounded"
								alt="Profile Image" style="width: 40x; height: 40px" />
							</a>
							<ul
								class="dropdown-menu dropdown-menu-sm-start dropdown-menu-md-end me-1"
								aria-labelledby="navbarDropdownMenuAvatar">
								<li><a class="dropdown-item" href="#">My profile</a></li>
								<li><a class="dropdown-item" href="#">Settings</a></li>
								<li><sf:form action="/logout">
										<button type="submit" class="dropdown-item">Log Out</button>
									</sf:form></li>
							</ul>
						</div>
					</ul>
				</div>
			</div>
		</nav>
	</c:when>
	<c:otherwise>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation"
				style="margin-left: 12px;">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand" href="#"
				style="padding-left: 12px; padding-right: 12px;">Navbar</a>

			<div class="offcanvas offcanvas-start" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<button type="button" class="btn-close text-reset ms-auto"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body ms-lg-auto ms-xl-auto ms-xxl-auto">
					<ul class="navbar-nav me-2 mt-1">
						<li class="nav-item mt-1"><a class="nav-link active" href="#">Home</a>
						</li>
						<li class="nav-item mt-1"><a class="nav-link active" href="#">Product</a>
						</li>
						<li class="nav-item dropdown mt-1"><a
							class="nav-link active dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> Add New </a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">Product</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item" href="#">Category</a></li>
							</ul></li>
						<li class="nav-item mt-1"><a class="nav-link active" href="#">Orders</a>
						</li>
						<li class="nav-item mt-1"><a class="nav-link active"
							href="/login">Log In</a></li>

					</ul>
				</div>
			</div>
		</nav>
	</c:otherwise>
</c:choose>