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
<title>Insert title here</title>
<script>
  $(document).ready(function() {
	  const querystring = location.search.substr(1);
	  if(querystring==="error") 
		  alert("비밀번호를 확인하지 못했습니다");
	  
	  $('#check-password').on("click", async function() {
		  const password = $('#password').val();
		  if(password==="") {
			  alert("비밀번호를 입력하세요");
			  return;
		  }
			$('#check-password-form').submit();
	  })
  });
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
				<h1>비밀번호 확인</h1>
				<form action="/member/check-password" method="post" id="check-password-form">
			  <div class="mb-3 mt-3">
          <label for="password" class="form-label">비밀번호:</label>
          <input type="password" class="form-control" id="password" name="password">
        </div>
        <button id="check-password">비밀번호 확인하기</button>
        </form>
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