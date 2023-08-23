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
	  $('#find-id').on("click", async function() {
		  const email = $('#email').val();
		  if(email==="") {
			  alert("이메일을 입력하세요");
			  return;
		  }
		  try {
			  const username = await $.ajax('/member/username/' + email);
			  $('#email-msg').text("당신의 아이디 : " + username);
		  } catch(err) {
			  $('#email-msg').text("아이디를 찾지 못했습니다");
		  }
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
			  <div class="mb-3 mt-3">
          <label for="email" class="form-label">이메일:</label>
          <input type="text" class="form-control" id="email" name="email">
          <span id="email-msg"></span>
        </div>
        <button id="find-id">아이디 찾기</button>
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