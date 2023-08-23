<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/main.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/fontawesome.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="loginId"/>
</sec:authorize>
<script>
	$(document).ready(function() {
		let star=0;
		$('.images:first-of-type').css('opacity', '1.0').css('border', '1px solid red');
		
		// 상품의 메인 이미지 변경
		$('.images').on('click', function() {
			$('.images').css('opacity', '0.5').css('border', 'none');
			$(this).css('opacity', '1.0').css('border', '1px solid red');
			$("#main-image").attr("src", $(this).attr('src'));
		});
		
		// 리뷰 작성
		$('#add_review').on("click", function() {
			const content = $('#content').val();
			if(content==='' || star===0) {
				alert("리뷰를 작성하려면 내용을 입력하고 별점은 선택하세요");
				return;
			} 
			const form = `
				<form action='/review/create' method='post'>
					<input type='hidden' name='content' value='\${content}'>
					<input type='hidden' name='star' value='\${star}'>  
					<input type='hidden' name='pno' value='${dto.product.pno}'>
				</form>
			`;
			$(form).appendTo($('body')).submit();
		});
		
		// 별점 주기
		$('.fa-star').on("click", function() {
			$(this).prevAll().removeClass('fa-regular');
			$(this).prevAll().addClass('fa-solid');
			$(this).removeClass('fa-regular');
			$(this).addClass('fa-solid');
			$(this).nextAll().removeClass('fa-solid');
			$(this).nextAll().addClass('fa-regular');
			star = $(this).attr('data-star');
		});
		
		// 상품 삭제
		$('#delete-product').on("click", function() {
			const form = `
				<form action='/product/delete' method='post'>
					<input type='hidden' name='pno' value='${dto.product.pno}'>
				</form>
			`;
			$(form).appendTo($('body')).submit();
		})
		
		// 리뷰 삭제
		$('.delete-review').on("click", function() {
			const rno = $(this).attr('data-rno');
			const form = `
				<form action='/review/delete' method='post'>
					<input type='hidden' name='rno' value='\${rno}'>  
					<input type='hidden' name='pno' value='${dto.product.pno}'>
				</form>
			`;
			$(form).appendTo($('body')).submit();
		})
	});
</script>

<style>
	.images {
		opacity:0.5;
	}
	.upper {
		display:flex;
		justify-content: space-between;
		margin-bottom: 5px;
	}
	.upper .writer {
		font-weight: bold;
	}
</style>
<title>Insert title here</title>
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
				<table class="table">
					<tr>
						<td rowspan="5">
							<div>
								<div>
									<img src="${dto.images[0].name}" height="150px" id="main-image">
								</div>
								<div>
									<c:forEach items="${dto.images}" var="image">
										<img src="${image.name}" width="50px" class="images">
									</c:forEach>
								</div>
							</div>
						</td>
						<td>${dto.product.name}</td>
					</tr>
					<tr>
						<td>${dto.product.vendor}</td>
					</tr>
					<tr>						
						<td>${dto.product.price}</td>
					</tr>
					<tr>	
						<td>${dto.product.salesCount}</td>
					</tr>
					<tr>
						<td>${dto.product.salesVolume}</td>
					</tr>
					<tr>
						<td colspan="2">
							${dto.product.info}
						</td>
					</tr>
				</table>
				<sec:authorize access="hasRole('USER')">
					<hr>
						<button class="btn btn-outline-primary">장바구니로</button>
					<hr>
				</sec:authorize>
				<sec:authorize access="hasRole('ADMIN')">
					<hr>
						<button class="btn btn-outline-danger" id="delete-product">상품 삭제</button>
					<hr>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<!-- 비로그인이면 비활성화된 댓글 작성창을 보여준다 -->
					<div class="mb-3 mt-3">
      			<label for="comment">리뷰:</label>
	      		<textarea class="form-control" rows="5" id="content" placeholder="로그인 하세요" disabled></textarea>
    			</div>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<!-- 로그인이면 활성화된 댓글 작성창, 별점표시 영역을 보여준다-->
					<div class="mb-3 mt-3">
      			<label for="comment">리뷰:</label>
      			<textarea class="form-control" rows="5" id="content" placeholder="리뷰를 작성하세요"></textarea>
    			</div>
    			<div class="mb-3 mt-3">
	    			<div>
	    				<i class="fa-regular fa-star" data-star="1"></i>
	    				<i class="fa-regular fa-star" data-star="2"></i>
	    				<i class="fa-regular fa-star" data-star="3"></i>
	    				<i class="fa-regular fa-star" data-star="4"></i>
	    				<i class="fa-regular fa-star" data-star="5"></i>
	    			</div>
	    			<button id='add_review' class="btn btn-outline-success">리뷰 작성</button>
    			</div>
				</sec:authorize>
    		<div id="comments">
    			<c:forEach items="${dto.reviews }" var="review">
    				<hr>
    				<div>
    					<div class='upper'>
    						<div class='writer'>
    							<span>${review.writer }</span>&nbsp;
    							<div>
    								<c:forEach begin="1" end="${review.star}">
    									 <i class="fa-solid fa-star"></i>
    								</c:forEach>
    								<c:forEach begin="${review.star+1}" end="5">
    									<i class="fa-regular fa-star"></i>
    								</c:forEach>
	    						</div>
    							<c:if test="${review.writer==loginId }">
    								<button class="btn btn-outline-dark delete-review" data-rno="${review.rno}">삭제</button>
    							</c:if>
    						</div>
    						<div class='writeTime'>${review.writeTime }</div>
    					</div>
    					<div class='lower'>
    						${review.content}
    					</div>
    				</div>
    			</c:forEach>
    			<hr>
				</div>
			</section>
		</main>
		<footer>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</footer>
	</div>
</body>
</html>