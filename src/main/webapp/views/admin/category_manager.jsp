<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/admin_header.jsp" />
<jsp:include page="../layout/admin_sidebar.jsp" />

<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Quản lý Loại Tin</h1>
</div>

<div class="row">
	<!-- Form CRUD -->
	<div class="col-md-5">
		<div class="card mb-4 shadow-sm">
			<div class="card-header bg-success text-white">Cập nhật Loại
				tin</div>
			<div class="card-body">
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success">${sessionScope.message}</div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>
				<form action="${pageContext.request.contextPath}/admin/category" method="POST">
					<div class="mb-3">
						<label class="form-label">Mã loại tin</label> <input type="text"
							class="form-control" name="id" required>
					</div>
					<div class="mb-4">
						<label class="form-label">Tên loại tin</label> <input type="text"
							class="form-control" name="name" required>
					</div>

					<div class="d-grid gap-2 d-md-block">
						<button type="submit" formaction="${pageContext.request.contextPath}/admin/category/insert" class="btn btn-primary">
							<i class="bi bi-plus-circle"></i> Thêm
						</button>
						<button type="submit" formaction="${pageContext.request.contextPath}/admin/category/update" class="btn btn-warning text-white">
							<i class="bi bi-pencil-square"></i> Cập nhật
						</button>
						<a href="${pageContext.request.contextPath}/admin/category" class="btn btn-secondary">
							<i class="bi bi-arrow-counterclockwise"></i> Mới
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

    <script>
    function editCategory(id, name) {
        document.querySelector('input[name="id"]').value = id;
        document.querySelector('input[name="id"]').setAttribute('readonly', true);
        document.querySelector('input[name="name"]').value = name;
    }
    </script>

	<!-- Data Table -->
	<div class="col-md-7">
		<div class="card shadow-sm mb-5">
			<div class="card-header">Danh sách Loại tin</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-striped table-hover">
						<thead class="table-dark">
							<tr>
								<th>Mã loại</th>
								<th>Tên loại</th>
								<th>Thao tác</th>
							</tr>
						</thead>
						<tbody>
                            <c:forEach var="item" items="${listCategory}">
                                <tr>
                                    <td>${item.id}</td>
                                    <td>${item.name}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-info text-white" 
                                            onclick="editCategory('${item.id}', '${item.name}')"><i class="bi bi-pencil"></i></button>
                                        <form action="${pageContext.request.contextPath}/admin/category/delete" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
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
	</div>
</div>

<jsp:include page="../layout/admin_footer.jsp" />
