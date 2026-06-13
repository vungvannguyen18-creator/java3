<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<jsp:include page="../layout/reader_header.jsp" />

		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reader/home">Trang chủ</a></li>
				<li class="breadcrumb-item active" aria-current="page">${news.title}</li>
			</ol>
		</nav>

		<article>
			<h1 class="mb-3">${news.title}</h1>
			<p class="text-muted">
				<i class="bi bi-eye"></i> Lượt xem: ${news.viewCount}
			</p>

			<div class="mb-4">
				<img src="<c:choose><c:when test=" ${not empty news.image and
					news.image.startsWith('http')}">${news.image}</c:when>
				<c:when test="${not empty news.image}">${pageContext.request.contextPath}/${news.image}</c:when>
				<c:otherwise>https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=800&q=80</c:otherwise>
				</c:choose>"
				class="img-fluid rounded" alt="Chi tiết bản tin">
			</div>

			<div class="content fs-5" style="line-height: 1.8;">
				${news.content}
			</div>
		</article>

		<hr class="my-5">

		<h4 class="mb-4">TIN CÙNG CHUYÊN MỤC</h4>
		<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach var="rel" items="${relatedNews}">
			<div class="col">
				<div class="card h-100 news-card">
					<img src="<c:choose><c:when test="${not empty rel.image and rel.image.startsWith('http')}">${rel.image}</c:when><c:when test="${not empty rel.image}">${pageContext.request.contextPath}/${rel.image}</c:when><c:otherwise>https://images.unsplash.com/photo-1508921340878-ba53e1f016ec?w=800&q=80</c:otherwise></c:choose>"
						class="card-img-top news-img" alt="News Image">
					<div class="card-body">
						<h6 class="card-title">
							<a href="${pageContext.request.contextPath}/reader/detail?id=${rel.id}" class="text-decoration-none text-dark">${rel.title}</a>
						</h6>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>

		<jsp:include page="../layout/reader_footer.jsp" />