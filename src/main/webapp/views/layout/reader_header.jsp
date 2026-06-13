<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ABC News</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
.news-card {
	transition: transform 0.2s;
}

.news-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.news-img {
	height: 200px;
	object-fit: cover;
}
</style>
</head>
<body>
	<!-- Top Header -->
	<header class="bg-dark text-white py-2">
		<div
			class="container d-flex justify-content-between align-items-center">
			<div>
				<a href="${pageContext.request.contextPath}/reader/home"
					class="text-white text-decoration-none fs-4 fw-bold">ABC NEWS</a>
			</div>
			<div>
				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
						<span class="text-white me-3">Xin chào, <strong>${sessionScope.currentUser.fullname}</strong></span>
						<c:if test="${sessionScope.currentUser.role > 0}">
							<a href="${pageContext.request.contextPath}/admin/news" class="btn btn-sm btn-outline-light me-2">Trang Quản Trị</a>
						</c:if>
						<a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-sm btn-danger">Đăng xuất</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/auth/login"
							class="btn btn-sm btn-primary">Đăng nhập</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<!-- Navigation -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light mb-4 shadow-sm">
		<div class="container">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-toggle="collapse"
				data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/reader/home">Trang
							chủ</a></li>
					<c:forEach var="c" items="${categories}">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/reader/category?id=${c.id}">${c.name}</a></li>
					</c:forEach>
				</ul>
				<form class="d-flex" action="${pageContext.request.contextPath}/reader/search" method="GET">
					<input class="form-control me-2" type="search" name="keyword"
						placeholder="Tìm kiếm tin tức..." aria-label="Search" required>
					<button class="btn btn-outline-primary" type="submit">Tìm</button>
				</form>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<!-- Left Sidebar (Menu & Hot News) -->
			<div class="col-md-3">
				<div class="card mb-4">
					<div class="card-header bg-primary text-white fw-bold">DANH
						MỤC</div>
					<ul class="list-group list-group-flush">
						<c:forEach var="c" items="${categories}">
							<a href="${pageContext.request.contextPath}/reader/category?id=${c.id}" class="list-group-item list-group-item-action">${c.name}</a>
						</c:forEach>
					</ul>
				</div>

				<div class="card mb-4">
					<div class="card-header bg-danger text-white fw-bold">TIN NỔI BẬT</div>
					<ul class="list-group list-group-flush">
						<c:forEach var="hn" items="${hotNews}">
						<a href="${pageContext.request.contextPath}/reader/detail?id=${hn.id}"
							class="list-group-item list-group-item-action">${hn.title}</a>
						</c:forEach>
					</ul>
				</div>

				<div class="card mb-4">
					<div class="card-header bg-info text-white fw-bold">TIN MỚI
						NHẤT</div>
					<ul class="list-group list-group-flush">
						<c:forEach var="ln" items="${latestNews}">
						<a href="${pageContext.request.contextPath}/reader/detail?id=${ln.id}"
							class="list-group-item list-group-item-action">${ln.title}</a>
						</c:forEach>
					</ul>
				</div>
			</div>

			<!-- Main Content Area -->
			<div class="col-md-9">