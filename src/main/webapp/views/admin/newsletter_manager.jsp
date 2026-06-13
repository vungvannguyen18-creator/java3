<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/admin_header.jsp" />
<jsp:include page="../layout/admin_sidebar.jsp" />

<div
	class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Quản lý Newsletter (Email Đăng Ký)</h1>
</div>

<div class="card shadow-sm mb-5">
    <div class="card-header bg-info text-white fw-bold">Danh sách Email đăng ký nhận tin</div>
    <div class="card-body">
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Email</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${listNewsletter}">
                        <tr>
                            <td>${item.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.enabled}">
                                        <span class="badge bg-success">Đang gửi tin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Ngừng gửi tin</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/newsletter/toggle" method="POST" class="d-inline">
                                    <input type="hidden" name="email" value="${item.email}">
                                    <input type="hidden" name="enabled" value="${item.enabled}">
                                    <button type="submit" class="btn btn-sm btn-warning text-white"><i class="bi bi-arrow-repeat"></i> Đổi TT</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/newsletter/delete" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa email này?');">
                                    <input type="hidden" name="email" value="${item.email}">
                                    <button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i> Xóa</button>
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
