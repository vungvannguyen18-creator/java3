<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

</div>
<!-- End Main Content (col-md-9) -->
</div>
<!-- End Row -->
</div>
<!-- End Container -->

<!-- Footer -->
<footer class="bg-dark text-light py-4 mt-5">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h5>Về ABC News</h5>
				<p>ABC News là trang tin tức cập nhật nhanh chóng,
					chính xác những sự kiện trong nước và quốc tế.</p>
			</div>
			<div class="col-md-6">
				<h5>Đăng ký nhận bản tin</h5>
				<c:if test="${not empty sessionScope.message}">
					<div class="alert alert-success">${sessionScope.message}</div>
					<c:remove var="message" scope="session"/>
				</c:if>
				<c:if test="${not empty sessionScope.error}">
					<div class="alert alert-danger">${sessionScope.error}</div>
					<c:remove var="error" scope="session"/>
				</c:if>
				<form class="d-flex" action="${pageContext.request.contextPath}/reader/subscribe" method="POST">
					<input type="email" name="email" class="form-control me-2"
						placeholder="Nhập email của bạn..." required>
					<button type="submit" class="btn btn-primary">Đăng ký</button>
				</form>
			</div>
		</div>
		<hr>
		<div class="text-center">
			<p class="mb-0">&copy; 2026 ABC News. All rights reserved.</p>
		</div>
	</div>
</footer>

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
