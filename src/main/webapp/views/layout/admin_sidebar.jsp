<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav id="sidebarMenu"
	class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
	<div class="position-sticky pt-3 sidebar-sticky">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/reader/home"
				target="_blank"> <i class="bi bi-house-door me-2"></i> Xem trang
					đọc giả
			</a></li>
			<h6
				class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted text-uppercase">
				<span>Quản lý</span>
			</h6>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/news">
					<i class="bi bi-newspaper me-2"></i> Quản lý Tin Tức
			</a></li>
			<c:if test="${sessionScope.currentUser.role == 2}">
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/category">
					<i class="bi bi-tags me-2"></i> Quản lý Loại Tin
			</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/user">
					<i class="bi bi-people me-2"></i> Quản lý Người Dùng
			</a></li>
			<li class="nav-item"><a class="nav-link"
				href="${pageContext.request.contextPath}/admin/newsletter">
					<i class="bi bi-envelope me-2"></i> Quản lý Newsletter
			</a></li>
			</c:if>
		</ul>
	</div>
</nav>
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-4">
