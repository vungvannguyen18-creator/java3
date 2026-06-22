<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng nhập - ABC News</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
body {
	background-color: #f8f9fa;
}

.login-container {
	max-width: 400px;
	margin-top: 100px;
}
</style>
</head>
<body>
	<div class="container login-container">
		<div class="card shadow">
			<div class="card-body p-4">
				<div class="text-center mb-4">
					<h2 class="text-primary fw-bold">ABC NEWS</h2>
					<p class="text-muted">Đăng nhập hệ thống quản trị</p>
				</div>
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>
				<form action="${pageContext.request.contextPath}/auth/login" method="POST">
					<div class="mb-3">
						<label for="email" class="form-label">Địa chỉ Email</label>
						<div class="input-group">
							<span class="input-group-text"><i class="bi bi-envelope"></i></span>
							<input type="email" class="form-control" id="email"
								name="email" required>
						</div>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">Mật khẩu</label>
						<div class="input-group">
							<span class="input-group-text"><i class="bi bi-lock"></i></span>
							<input type="password" class="form-control" id="password" name="password" required>
							<button class="btn btn-outline-secondary" type="button" id="togglePassword">
								<i class="bi bi-eye"></i>
							</button>
						</div>
					</div>
					<div class="mb-3 form-check">
						<input type="checkbox" class="form-check-input" id="remember">
						<label class="form-check-label" for="remember">Nhớ mật
							khẩu</label>
					</div>
					<div class="d-grid gap-2">
						<button type="submit" class="btn btn-primary">Đăng Nhập</button>
					</div>
				</form>
				<div class="text-center mt-3">
					<a href="${pageContext.request.contextPath}/reader/home"
						class="text-decoration-none">← Quay lại trang chủ</a>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	document.getElementById('togglePassword').addEventListener('click', function () {
	    const passwordInput = document.getElementById('password');
	    const icon = this.querySelector('i');
	    
	    if (passwordInput.type === 'password') {
	        passwordInput.type = 'text';
	        icon.classList.remove('bi-eye');
	        icon.classList.add('bi-eye-slash');
	    } else {
	        passwordInput.type = 'password';
	        icon.classList.remove('bi-eye-slash');
	        icon.classList.add('bi-eye');
	    }
	});
	</script>
</body>
</html>
