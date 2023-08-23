<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>제품들</title>
<script>
	$(document).ready(function() {
		const querystring = location.search.substr(1);
		if(querystring==='error')
			alert('잘못된 작업입니다');
	})
</script>
</head>
<body>
	<div id="page">
		<header>
			<jsp:include page="/WEB-INF/views/include/header.jsp" />
		</header>
		<nav>
			<jsp:include page="/WEB-INF/views/include/nav.jsp" />
		</nav>
		<main>
			<aside>
				<jsp:include page="/WEB-INF/views/include/aside.jsp" />
			</aside>
			<section>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제조사</th>
							<th>이름</th>
							<th>가격</th>
							<th>판매량</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.products}" var="product">
							<tr>
								<td>${product.pno}</td>
								<td>${product.vendor}</td>
								<td>
									<a href="/product/read?pno=${product.pno}">${product.name}</a>
								</td>
								<td>${product.price}</td>
								<td>${product.salesCount}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<ul class="pagination">
					<c:if test="${page.prev>0}">
						<li class="page-item">
							<a class="page-link" href="/product/list?pno=${page.prev}">이전</a>
						</li>
					</c:if>
					<c:forEach begin="${page.start}" end="${page.end}" var="i">
						<li class="page-item">
							<a class="page-link" href="/product/list?pno=${i}">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${page.next>0}">
						<li class="page-item">
							<a class="page-link" href="/product/list?pno=${page.next}">다음</a>
						</li>
					</c:if>
				</ul>
			</section>
			<aside>
				<jsp:include page="/WEB-INF/views/include/aside.jsp" />
			</aside>
		</main>
		<footer>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</footer>
	</div>
</body>
</html>