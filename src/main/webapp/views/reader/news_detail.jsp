<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		<jsp:include page="../layout/reader_header.jsp" />

		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reader/home">Trang chủ</a></li>
				<li class="breadcrumb-item active" aria-current="page">${news.title}</li>
			</ol>
		</nav>

		<article>
			<h1 class="mb-3">${news.title}</h1>
			<div class="d-flex justify-content-between align-items-center mb-3">
				<p class="text-muted mb-0">
					<i class="bi bi-clock me-1"></i> <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" /> &nbsp;|&nbsp;
					<i class="bi bi-person-fill me-1"></i> ${news.author} &nbsp;|&nbsp;
					<i class="bi bi-eye ms-1 me-1"></i> Lượt xem: ${news.viewCount}
				</p>
				<c:if test="${not empty sessionScope.currentUser}">
					<form action="${pageContext.request.contextPath}/reader/favorite" method="post" class="m-0">
						<input type="hidden" name="newsId" value="${news.id}">
						<c:choose>
							<c:when test="${isFavorite}">
								<input type="hidden" name="action" value="remove">
								<button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-heart-fill"></i> Bỏ yêu thích</button>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="action" value="add">
								<button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-heart"></i> Yêu thích</button>
							</c:otherwise>
						</c:choose>
					</form>
				</c:if>
			</div>

			<div class="mb-4 text-center">
				<c:choose>
					<c:when test="${not empty news.image and news.image.startsWith('http')}">
						<img src="${news.image}" class="img-fluid rounded" alt="Chi tiết bản tin">
					</c:when>
					<c:when test="${not empty news.image}">
						<img src="${pageContext.request.contextPath}/${news.image}" class="img-fluid rounded" alt="Chi tiết bản tin">
					</c:when>
					<c:otherwise>
						<img src="https://images.unsplash.com/photo-1586339949916-3e9457bef6d3?w=800&q=80" class="img-fluid rounded" alt="Chi tiết bản tin">
					</c:otherwise>
				</c:choose>
			</div>

			<div class="content fs-5" style="line-height: 1.8;">
				${news.content}
			</div>
		</article>

		<hr class="my-5">

		<!-- Bình luận -->
		<section class="mb-5">
			<h4 class="mb-4">BÌNH LUẬN</h4>
			
			<c:choose>
				<c:when test="${empty sessionScope.currentUser}">
					<div class="alert alert-info">Vui lòng <a href="${pageContext.request.contextPath}/auth/login">đăng nhập</a> để bình luận.</div>
				</c:when>
				<c:otherwise>
					<form action="${pageContext.request.contextPath}/reader/comment" method="post" class="mb-4">
						<input type="hidden" name="newsId" value="${news.id}">
						<div class="mb-3">
							<textarea name="content" class="form-control" rows="3" placeholder="Nhập bình luận của bạn..." required></textarea>
						</div>
						<button type="submit" class="btn btn-primary">Gửi bình luận</button>
					</form>
				</c:otherwise>
			</c:choose>

			<div class="list-group">
				<c:forEach var="c" items="${comments}">
					<div class="list-group-item">
						<div class="d-flex w-100 justify-content-between">
							<h6 class="mb-1 fw-bold text-primary"><i class="bi bi-person-circle"></i> ${c.userId}</h6>
						</div>
						<p class="mb-1">${c.content}</p>
					</div>
				</c:forEach>
			</div>
		</section>

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