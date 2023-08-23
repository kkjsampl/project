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
<link  href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/summernote-lite.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.js"></script>
<script>
  var jq = jQuery.noConflict();
  jq(document).ready(function() {
  	var fontList = ['맑은 고딕','굴림','돋움','바탕','궁서','NotoSansKR'];
    jq('#summernote').summernote({
    	height: 450,
  	  lang: "ko-KR",
      fontNames: fontList,
      fontNamesIgnoreCheck: fontList,
		});
	});
</script>
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
				<form action="/product/add" method="post" enctype="multipart/form-data">
				  <input type="hidden" name="_csrf" value="${_csrf.token}">
					<div class="mb-3 mt-3">
    				<label for="vendor" class="form-label">제조사:</label>
    				<input type="text" class="form-control" id="vendor" placeholder="제조사 입력" name="vendor">
  				</div>
  				<div class="mb-3 mt-3">
    				<label for="name" class="form-label">제품명:</label>
    				<input type="text" class="form-control" id="name" placeholder="제품 이름 입력" name="name">
  				</div>
  				<div class="mb-3 mt-3">
  				  <!--  name이 모두 같다  -->
  					<input type="file" class="form-control" name="images">
  					<input type="file" class="form-control" name="images">
  					<input type="file" class="form-control" name="images">
  				</div>
  				<textarea id="summernote" name="info"></textarea>
  				<div class="mb-3 mt-3">
    				<label for="price" class="form-label">가격:</label>
    				<input type="number" class="form-control" id="price" placeholder="가격 입력" name="price">
  				</div>
  				<div class="mb-3 mt-3">
    				<label for="stock" class="form-label">재고:</label>
    				<input type="number" class="form-control" id="stock" placeholder="재고 수량 입력" name="stock">
  				</div>
  				<button class="btn btn-outline-success">추가</button>
				</form>
			</section>
		</main>
		<footer>
			<jsp:include page="/WEB-INF/views/include/footer.jsp" />
		</footer>
	</div>
</body>
</html>