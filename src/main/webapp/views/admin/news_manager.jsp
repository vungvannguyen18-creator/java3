<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/admin_header.jsp" />
<jsp:include page="../layout/admin_sidebar.jsp" />

<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Quản lý Tin Tức</h1>
</div>

<!-- Form CRUD -->
<div class="card mb-4 shadow-sm">
	<div class="card-header bg-primary text-white">Cập nhật tin tức</div>
	<div class="card-body">
		<c:if test="${not empty sessionScope.message}">
			<div class="alert alert-success">${sessionScope.message}</div>
			<c:remove var="message" scope="session"/>
		</c:if>
		<c:if test="${not empty sessionScope.error}">
			<div class="alert alert-danger">${sessionScope.error}</div>
			<c:remove var="error" scope="session"/>
		</c:if>
		<form method="POST" enctype="multipart/form-data">
			<div class="row mb-3">
				<div class="col-md-4">
					<label class="form-label">Mã bản tin</label> <input type="text"
						class="form-control" name="id" id="newsIdInput" placeholder="Tự động tạo khi lưu" readonly>
				</div>
				<div class="col-md-8">
					<label class="form-label">Tiêu đề</label> <input type="text"
						class="form-control" name="title" placeholder="Nhập tiêu đề...">
				</div>
			</div>

			<div class="row mb-3">
				<div class="col-md-4">
					<label class="form-label">Loại tin</label> <select
						class="form-select" name="categoryId">
						<c:forEach var="c" items="${categories}">
							<option value="${c.id}">${c.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label">Hình ảnh (Chọn tệp HOẶC dán Link)</label> 
					<div class="input-group">
						<input type="file" class="form-control" name="image" title="Chọn tệp từ máy tính">
						<input type="text" class="form-control" name="imageUrl" placeholder="Hoặc dán Link URL ảnh...">
					</div>
				</div>
				<div class="col-md-3 mt-4 d-flex align-items-center">
					<div class="form-check me-3">
						<input class="form-check-input" type="checkbox" name="home"
							id="homeCheck" value="true"> <label
							class="form-check-label" for="homeCheck">Hiển thị trang
							nhất</label>
					</div>
				</div>
				<div class="col-md-2">
					<label class="form-label">Lượt xem</label>
					<input type="number" class="form-control" name="viewCount" placeholder="0" value="0" min="0">
				</div>
			</div>

			<c:if test="${sessionScope.currentUser.role == 2}">
			<div class="row mb-3">
				<div class="col-md-4">
					<label class="form-label">Trạng thái (Chỉ Admin)</label>
					<select class="form-select" name="status">
						<option value="3">Đã duyệt (Công khai)</option>
						<option value="1">Chờ duyệt</option>
						<option value="2">Từ chối</option>
					</select>
				</div>
			</div>
			</c:if>

			<div class="mb-3">
				<label class="form-label">Nội dung</label>
				<textarea class="form-control" rows="5" name="content" id="contentEditor"></textarea>
			</div>

			<div>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/news/insert" class="btn btn-primary" onclick="return validateImage()">
					<i class="bi bi-plus-circle"></i> Thêm
				</button>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/news/update" class="btn btn-warning text-white">
					<i class="bi bi-pencil-square"></i> Cập nhật
				</button>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/news/delete" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">
					<i class="bi bi-trash"></i> Xóa
				</button>
				<a href="${pageContext.request.contextPath}/admin/news" class="btn btn-secondary">
					<i class="bi bi-arrow-counterclockwise"></i> Mới
				</a>
			</div>
		</form>
	</div>
</div>

<!-- Data Table -->
<div class="card shadow-sm mb-5">
	<div class="card-header">Danh sách tin tức</div>
	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-striped table-hover">
				<thead class="table-dark">
					<tr>
						<th>Mã tin</th>
						<th>Tiêu đề</th>
						<th>Loại tin</th>
						<th>Lượt xem</th>
						<th>Tác giả</th>
						<th>Trạng thái</th>
						<th>Trang nhất</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${listNews}">
					<tr>
						<td>${item.id}</td>
						<td>${item.title}</td>
						<td>
							<c:forEach var="c" items="${categories}">
								<c:if test="${c.id == item.categoryId}">${c.name}</c:if>
							</c:forEach>
						</td>
						<td>${item.viewCount}</td>
						<td>${item.author}</td>
						<td>
							<c:choose>
								<c:when test="${item.status == 3}"><span class="badge bg-success">Đã duyệt</span></c:when>
								<c:when test="${item.status == 2}"><span class="badge bg-danger">Từ chối</span></c:when>
								<c:otherwise><span class="badge bg-warning text-dark">Chờ duyệt</span></c:otherwise>
							</c:choose>
						</td>
						<td>${item.home ? 'Trang nhất' : 'Bình thường'}</td>
						<td>
							<button type="button" class="btn btn-sm btn-info text-white" 
								data-id="${item.id}" 
								data-title="<c:out value='${item.title}'/>" 
								data-category="${item.categoryId}" 
								data-content="<c:out value='${item.content}'/>"
								data-home="${item.home}"
								data-status="${item.status}" 
								data-viewcount="${item.viewCount}"
								onclick="editNews(this)"><i class="bi bi-pencil"></i></button>
							<form action="${pageContext.request.contextPath}/admin/news/delete" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin này?');">
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

<script>
    function validateImage() {
        var fileInput = document.querySelector('input[name="image"]').value;
        var urlInput = document.querySelector('input[name="imageUrl"]').value;
        if (!fileInput && !urlInput.trim()) {
            alert("Bắt buộc phải chọn tệp hoặc dán Link URL ảnh khi thêm bài viết!");
            return false;
        }
        return true;
    }

    function editNews(btn) {
        document.querySelector('input[name="id"]').value = btn.getAttribute('data-id');
        document.querySelector('input[name="id"]').setAttribute('readonly', true);
        document.querySelector('input[name="title"]').value = btn.getAttribute('data-title');
        document.querySelector('select[name="categoryId"]').value = btn.getAttribute('data-category');
        
        var content = btn.getAttribute('data-content');
        document.getElementById('contentEditor').value = content;
        
        document.querySelector('input[name="home"]').checked = (btn.getAttribute('data-home') === 'true');
        
        var viewCountInput = document.querySelector('input[name="viewCount"]');
        if (viewCountInput) {
            viewCountInput.value = btn.getAttribute('data-viewcount') || 0;
        }
        
        var statusSelect = document.querySelector('select[name="status"]');
        if (statusSelect) {
            statusSelect.value = btn.getAttribute('data-status');
        }
    }
</script>

<jsp:include page="../layout/admin_footer.jsp" />
