<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/reader_header.jsp" />

<h3 class="mb-4 border-bottom pb-2">TIN TRANG NHẤT</h3>
<div class="row row-cols-1 row-cols-md-2 g-4">
	<c:forEach var="item" items="${listNews}">
	<div class="col">
		<div class="card h-100 news-card">
			<img src="<c:choose><c:when test="${not empty item.image and item.image.startsWith('http')}">${item.image}</c:when><c:when test="${not empty item.image}">${pageContext.request.contextPath}/${item.image}</c:when><c:otherwise>https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=800&q=80</c:otherwise></c:choose>"
				class="card-img-top news-img" alt="News Image">
			<div class="card-body">
				<h5 class="card-title">
					<a href="${pageContext.request.contextPath}/reader/detail?id=${item.id}" class="text-decoration-none text-dark">${item.title}</a>
				</h5>
				<p class="card-text text-muted small">
					<i class="bi bi-eye"></i> ${item.viewCount} lượt xem
				</p>
				<p class="card-text text-truncate">${item.summary}</p>
			</div>
		</div>
	</div>
	</c:forEach>
</div>

<jsp:include page="../layout/reader_footer.jsp" />
