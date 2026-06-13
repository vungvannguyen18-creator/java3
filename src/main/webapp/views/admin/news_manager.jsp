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
						class="form-control" name="id" placeholder="Nhập mã bản tin...">
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
				<div class="col-md-4 mt-4 d-flex align-items-center">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="home"
							id="homeCheck" value="true"> <label
							class="form-check-label" for="homeCheck">Hiển thị trang
							nhất</label>
					</div>
				</div>
			</div>

			<div class="mb-3">
				<label class="form-label">Nội dung</label>
				<textarea class="form-control" rows="5" name="content" id="contentEditor"></textarea>
			</div>

			<div>
				<button type="submit" formaction="${pageContext.request.contextPath}/admin/news/insert" class="btn btn-primary">
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
						<th>Mã Loại tin</th>
						<th>Lượt xem</th>
						<th>Tác giả</th>
						<th>Trang nhất</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${listNews}">
					<tr>
						<td>${item.id}</td>
						<td>${item.title}</td>
						<td>${item.categoryId}</td>
						<td>${item.viewCount}</td>
						<td>${item.author}</td>
						<td>${item.home ? 'Trang nhất' : 'Bình thường'}</td>
						<td>
							<button type="button" class="btn btn-sm btn-info text-white" 
								data-id="${item.id}" 
								data-title="<c:out value='${item.title}'/>" 
								data-category="${item.categoryId}" 
								data-content="<c:out value='${item.content}'/>"
								data-home="${item.home}" 
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

<!-- Thêm CKEditor 4 -->
<script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
<script>
    // Khởi tạo CKEditor
    CKEDITOR.replace('contentEditor');

    function editNews(btn) {
        document.querySelector('input[name="id"]').value = btn.getAttribute('data-id');
        document.querySelector('input[name="id"]').setAttribute('readonly', true);
        document.querySelector('input[name="title"]').value = btn.getAttribute('data-title');
        document.querySelector('select[name="categoryId"]').value = btn.getAttribute('data-category');
        
        // Gán dữ liệu vào CKEditor
        var content = btn.getAttribute('data-content');
        CKEDITOR.instances.contentEditor.setData(content);
        
        document.querySelector('input[name="home"]').checked = (btn.getAttribute('data-home') === 'true');
    }
</script>

<jsp:include page="../layout/admin_footer.jsp" />
