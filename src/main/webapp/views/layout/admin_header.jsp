<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Trị - ABC News</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
body {
	font-size: .875rem;
}

.sidebar {
	min-height: calc(100vh - 56px);
}
</style>
</head>
<body>
	<header
		class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
		<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="#">ABC
			NEWS ADMIN</a>
		<button class="navbar-toggler position-absolute d-md-none collapsed"
			type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
			aria-controls="sidebarMenu" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div
			class="navbar-nav w-100 d-flex flex-row justify-content-end align-items-center pe-3">
			<div class="nav-item text-nowrap text-light me-3">
				Xin chào, <strong>${sessionScope.currentUser.fullname}</strong>
			</div>
			<div class="nav-item text-nowrap">
				<a class="nav-link px-3"
					href="${pageContext.request.contextPath}/auth/logout">Đăng
					xuất</a>
			</div>
		</div>
	</header>

	<div class="container-fluid">
		<div class="row">