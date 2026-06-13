<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/admin_header.jsp" />
<jsp:include page="../layout/admin_sidebar.jsp" />

<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Quản lý Người Dùng</h1>
</div>

<!-- Form CRUD -->
<div class="card mb-4 shadow-sm">
	<div class="card-header bg-info text-white fw-bold">Cập nhật
		Người dùng</div>
	<div class="card-body">
		<!-- Hiển thị thông báo (nếu có) -->
		<c:if test="${not empty sessionScope.message}">
			<div class="alert alert-success">${sessionScope.message}</div>
			<c:remove var="message" scope="session"/>
		</c:if>
		<c:if test="${not empty sessionScope.error}">
			<div class="alert alert-danger">${sessionScope.error}</div>
			<c:remove var="error" scope="session"/>
		</c:if>

		<form action="${pageContext.request.contextPath}/admin/user" method="POST">
			<div class="row mb-3">
				<div class="col-md-6">
					<label class="form-label">Mã Đăng Nhập (ID)</label> <input type="text"
						class="form-control" name="id" required>
				</div>
				<div class="col-md-6">
					<label class="form-label">Mật khẩu</label>
					<div class="input-group">
						<input type="password" class="form-control" name="password" id="passwordInput" required>
						<button class="btn btn-outline-secondary" type="button" id="togglePassword">
							<i class="bi bi-eye"></i>
						</button>
					</div>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-md-6">
					<label class="form-label">Họ và tên</label> <input type="text"
						class="form-control" name="fullname" required>
				</div>
				<div class="col-md-6">
					<label class="form-label">Email</label> <input type="email"
						class="form-control" name="email" required>
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-md-4">
					<label class="form-label">Điện thoại</label> <input type="text"
						class="form-control" name="mobile">
				</div>
				<div class="col-md-4">
					<label class="form-label">Ngày sinh</label> <input type="date"
						class="form-control" name="birthday">
				</div>
				<div class="col-md-4">
					<label class="form-label d-block">Giới tính</label>
					<div class="form-check form-check-inline mt-2">
						<input class="form-check-input" type="radio" name="gender"
							id="genderMale" value="true" checked> <label
							class="form-check-label" for="genderMale">Nam</label>
					</div>
					<div class="form-check form-check-inline mt-2">
						<input class="form-check-input" type="radio" name="gender"
							id="genderFemale" value="false"> <label
							class="form-check-label" for="genderFemale">Nữ</label>
					</div>
				</div>
			</div>

			<div class="mb-4">
				<label class="form-label d-block">Vai trò</label>
				<div class="form-check form-check-inline mt-1">
					<input class="form-check-input" type="radio" name="role"
						id="roleUser" value="0" checked> <label
						class="form-check-label" for="roleUser">Người dùng</label>
				</div>
				<div class="form-check form-check-inline mt-1">
					<input class="form-check-input" type="radio" name="role"
						id="roleWriter" value="1"> <label
						class="form-check-label" for="roleWriter">Người viết bài</label>
				</div>
				<div class="form-check form-check-inline mt-1">
					<input class="form-check-input" type="radio" name="role"
						id="roleAdmin" value="2"> <label
						class="form-check-label" for="roleAdmin">Quản trị viên (Admin)</label>
				</div>
			</div>

			<div>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/user/insert" class="btn btn-primary">
					<i class="bi bi-plus-circle"></i> Thêm
				</button>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/user/update" class="btn btn-warning text-white">
					<i class="bi bi-pencil-square"></i> Cập nhật
				</button>
				<a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary">
					<i class="bi bi-arrow-counterclockwise"></i> Mới
				</a>
			</div>
		</form>
	</div>
</div>

<script>
// Toggle Password Visibility
document.getElementById('togglePassword').addEventListener('click', function () {
    const passwordInput = document.getElementById('passwordInput');
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

// Script to fill form when clicking edit
function editUser(btn) {
    document.querySelector('input[name="id"]').value = btn.getAttribute('data-id');
    document.querySelector('input[name="id"]').setAttribute('readonly', true);
    document.querySelector('input[name="password"]').value = btn.getAttribute('data-password');
    document.querySelector('input[name="fullname"]').value = btn.getAttribute('data-fullname');
    document.querySelector('input[name="email"]').value = btn.getAttribute('data-email');
    document.querySelector('input[name="mobile"]').value = btn.getAttribute('data-mobile');
    
    // date formatting
    let dob = btn.getAttribute('data-birthday');
    if(dob && dob !== '') {
        document.querySelector('input[name="birthday"]').value = dob;
    }
    
    let isGender = btn.getAttribute('data-gender') === 'true';
    if(isGender) {
        document.getElementById('genderMale').checked = true;
    } else {
        document.getElementById('genderFemale').checked = true;
    }
    
    let role = btn.getAttribute('data-role');
    if(role === '2') document.getElementById('roleAdmin').checked = true;
    else if(role === '1') document.getElementById('roleWriter').checked = true;
    else document.getElementById('roleUser').checked = true;
}
</script>

<!-- Data Table -->
<div class="card shadow-sm mb-5">
	<div class="card-header">Danh sách Người dùng</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead class="table-dark">
					<tr>
						<th>Mã ĐN</th>
						<th>Họ tên</th>
						<th>Email</th>
						<th>SĐT</th>
						<th>Giới tính</th>
						<th>Vai trò</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${listUser}">
						<tr>
							<td>${item.id}</td>
							<td>${item.fullname}</td>
							<td>${item.email}</td>
							<td>${item.mobile}</td>
							<td>${item.gender ? 'Nam' : 'Nữ'}</td>
							<td>
								<c:choose>
									<c:when test="${item.role == 2}"><span class="badge bg-danger">Admin</span></c:when>
									<c:when test="${item.role == 1}"><span class="badge bg-success">Phóng viên</span></c:when>
									<c:otherwise><span class="badge bg-secondary">Độc giả</span></c:otherwise>
								</c:choose>
							</td>
							<td>
								<button type="button" class="btn btn-sm btn-info text-white" 
									data-id="${item.id}" 
									data-password="${item.password}"
									data-fullname="<c:out value='${item.fullname}'/>"
									data-email="${item.email}"
									data-mobile="${item.mobile}"
									data-gender="${item.gender}"
									data-role="${item.role}"
									data-birthday="${item.birthday}"
									onclick="editUser(this)"><i class="bi bi-pencil"></i></button>
								<form action="${pageContext.request.contextPath}/admin/user/delete" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
									<input type="hidden" name="id" value="${item.id}">
									<button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../layout/admin_footer.jsp" />
