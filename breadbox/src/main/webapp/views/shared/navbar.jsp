<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<c:choose>
	<c:when test="${not empty user}">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation"
				style="margin-left: 12px">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand d-none d-lg-block d-xl-block d-xxl-block"
				href="/" style="padding-left: 12px; padding-right: 12px">Navbar</a>
			<c:url value="/search" var="searchUrl"></c:url>
			<sf:form action="${searchUrl}" method="get">
				<div class="input-group d-lg-none w-auto ms-auto me-auto">
					<input type="text" class="form-control" name="name"
						placeholder="Search Products" aria-label="Search Products">
					<button class="btn btn-outline-secondary" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
			</sf:form>
			<c:if test="${not (user.role eq 'Admin')}">
				<div>
					<c:url value="/cart-details" var="cartDetails"></c:url>
					<a href="${cartDetails}"
						class="d-lg-none d-xl-none d-xxl-none btn btn-outline-secondary me-1">
						<i class="fa-solid fa-bag-shopping fa-lg"></i>
						<c:if test="${cart.items.size() gt 0}">
			           		<sup class="badge rounded-5 badge-notification bg-danger">${cart.items.size()}</sup>
		                </c:if>
					</a>
				</div>
			</c:if>
			<div class="offcanvas offcanvas-start w-75" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">Navbar</h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body ms-lg-auto">
					<ul class="navbar-nav me-2 mt-1">
						<li class="nav-item mt-1 mx-lg-2"><a class="nav-link active"
							href="/"><i class="fa-solid fa-house"></i> Home</a></li>
						<li class="nav-item mt-1 mx-lg-2"><c:url value="/menu"
								var="menuUrl" /> <a class="nav-link active" href="${menuUrl}">
								<i class="fa-solid fa-bread-slice"></i> Menu
						</a></li>
						<c:choose>
							<c:when test="${user.role eq 'Admin'}">

								<li class="nav-item dropdown mt-1"><a
									class="nav-link active dropdown-toggle" href="#" role="button"
									data-bs-toggle="dropdown" aria-expanded="false"><i
										class="fa-solid fa-plus"></i> Add New</a>
									<ul class="dropdown-menu">
										<c:url value="/admin/edit-product" var="editProduct"></c:url>
										<li><a class="dropdown-item" href="${editProduct}">Product</a></li>
										<li><hr class="dropdown-divider" /></li>
										<c:url value="/admin/edit-category" var="editCategory"></c:url>
										<li><a class="dropdown-item" href="${editCategory}">Category</a></li>
									</ul></li>
								<li class="nav-item mt-1">
								<c:url value="/orders" var="order"></c:url>
								<a class="nav-link active"
									href="${order}"><i class="fa-solid fa-list-check"></i> Orders</a></li>

							</c:when>
							<c:otherwise>

								<li class="nav-item mt-1 mx-lg-2"><a
									class="nav-link active" href="#"> <i
										class="fa-regular fa-address-card"></i> About
								</a></li>

								<li class="nav-item mt-1 mx-lg-2">
								<c:url value="/orders" var="order"></c:url>
								<a class="nav-link active" href="${order}"> <i
										class="fa-solid fa-list-check"></i> Orders
								</a></li>
							</c:otherwise>
						</c:choose>
						<c:url value="/search" var="searchUrl"></c:url>
						<sf:form action="${searchUrl}" method="get">
							<div class="input-group w-auto d-none d-lg-inline-flex d-xl-inline-flex d-xxl-flex mt-1 mx-lg-2">
								<input type="text" class="form-control" name="name"
									placeholder="Search Products" aria-label="Search Products">
								<button class="btn btn-outline-secondary" type="submit">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</sf:form>

						<c:if test="${user.role eq 'Customer' }">
							<li
								class="nav-item d-none d-lg-inline d-xl-inline d-xxl-inline mt-1 mx-lg-2">
								<c:url value="/cart-details" var="cartDetails"></c:url>
								<a class="nav-link active" href="${cartDetails}">
				                  <i class="fa-solid fa-bag-shopping fa-lg"></i> Cart
				                  <c:if test="${cart.items.size() gt 0}">
					                  <sup class="badge rounded-5 badge-notification bg-danger">${cart.items.size()}</sup>
				                  </c:if>
				                </a>
							</li>
						</c:if>

						<hr class="d-lg-none" />
						<li class="nav-item d-lg-none d-xl-none d-xxl-none"><a
							class="nav-link active" href="#"><i class="fa-solid fa-gear"></i>
								Settings</a></li>
						<li class="nav-item d-lg-none d-xl-none d-xxl-none"><sf:form
								action="/logout">
								<button type="submit" class="dropdown-item">
									<i class="fa-solid fa-arrow-right-from-bracket"></i> Log Out
								</button>
							</sf:form></li>

						<li
							class="nav-item d-lg-none d-xl-none d-xxl-none fixed-bottom w-75 ps-3">
							<div class="row me-0 align-middle my-2">
								<div class="col-1 pe-5">
									<c:url value="${user.profilepic}" var="profile" />
									<img src="${profile}" class="rounded-circle mt-1" height="45"
										alt="Black and White Portrait of a Man" loading="lazy" />
								</div>
								<div class="col ps-1 mt-1">
									<p class="my-0">${user.username}</p>
									<p class="my-0">${user.email}</p>
								</div>
							</div>
						</li>
						<div class="dropdown d-none d-lg-inline d-xl-inline d-xxl-inline">
							<a
								class="dropdown-toggle active d-flex align-items-center text-dark"
								href="#" id="navbarDropdownMenuAvatar" role="button"
								data-bs-toggle="dropdown" data-bs-display="static"
								aria-expanded="false"> <c:url value="${user.profilepic}"
									var="profile" /> <img src="${profile}"
								class="rounded-circle mt-1" height="40"
								alt="Black and White Portrait of a Man" loading="lazy" />
							</a>
							<ul
								class="dropdown-menu dropdown-menu-sm-start dropdown-menu-md-end me-1"
								aria-labelledby="navbarDropdownMenuAvatar">
								<li><a class="dropdown-item" href="#"><i
										class="fa-solid fa-gear"></i> Settings</a></li>
								<li><sf:form action="/logout">
										<button type="submit" class="dropdown-item">
											<i class="fa-solid fa-arrow-right-from-bracket"></i> Log Out
										</button>
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
				style="margin-left: 12px">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand d-none d-lg-block d-xl-block d-xxl-block"
				href="/" style="padding-left: 12px; padding-right: 12px">Navbar</a>
			
			<c:url value="/search" var="searchUrl"></c:url>
			<sf:form action="${searchUrl}" method="get">
				<div class="input-group d-lg-none w-auto">
					<input type="text" class="form-control" name="name"
						placeholder="Search Products" aria-label="Search Products"
						aria-describedby="button-addon2">
					<button class="btn btn-outline-secondary" type="button"
						id="button-addon2">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
			</sf:form>	
			
			<a href="/cart-details"
				class="d-lg-none d-xl-none d-xxl-none btn btn-outline-secondary me-1">
				<i class="fa-solid fa-bag-shopping fa-lg"></i>
			</a>
			<div class="offcanvas offcanvas-start w-75" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel">Navbar</h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body ms-lg-auto">
					<ul class="navbar-nav me-2 mt-1">
						<li class="nav-item mt-1 mx-lg-2"><a class="nav-link active"
							href="/"><i class="fa-solid fa-house"></i> Home</a></li>
						<li class="nav-item mt-1 mx-lg-2"><a class="nav-link active"
							href="/menu"> <i class="fa-solid fa-bread-slice"></i> Menu
						</a></li>

						<li class="nav-item mt-1 mx-lg-2"><a class="nav-link active"
							href="#"> <i class="fa-regular fa-address-card"></i> About
						</a></li>

						<li class="nav-item mt-1 mx-lg-2">
						<c:url value="/orders" var="order"></c:url>
						<a class="nav-link active"
							href="${order}"> <i class="fa-solid fa-list-check"></i> Orders
						</a></li>

						
						<c:url value="/search" var="searchUrl"></c:url>
						<sf:form action="${searchUrl}" method="get">
							<div class="input-group w-auto d-none d-lg-inline-flex d-xl-inline-flex d-xxl-flex mt-1 mx-lg-2">
								<input type="text" class="form-control" name="name"
									placeholder="Search Product" aria-label="Search Product">
								<button class="btn btn-outline-secondary" type="submit">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</sf:form>
						

						<li
							class="nav-item d-none d-lg-inline d-xl-inline d-xxl-inline mt-1 mx-lg-2">
							<a class="nav-link active" href="/cart-details"><i
								class="fa-solid fa-bag-shopping fa-lg"></i> Cart</a>
						</li>

						<hr class="d-lg-none">

						<li class="nav-item mt-1 mx-lg-2"><a class="nav-link active"
							href="/login"> <i
								class="fa-solid fa-arrow-right-from-bracket"></i> Log In
						</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</c:otherwise>
</c:choose>