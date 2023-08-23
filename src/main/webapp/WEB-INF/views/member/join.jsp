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
<style>
  .fail { color: red; }
</style>
<script src="/script/join.js"></script>
<script>
  // $.ajax의 data 속성은 urlencode형식이어야 한다
  // 즉 아래 params는 name=spring&nai=20으로 변환되어야만 한다
  const params = {
		 name: 'spring',
		 nai:20
  };
  $.ajax({url:'', data:params});
  
  // $.ajax는 자바스크립트 객체를 자동으로 urlencoded 형식으로 변환한다
  // 그걸 processData라고 하며 기본값은 true

  // ajax로 파일 업로드를 하려면 js의 FormData() 내장 객체
  const formData = new FormData(document.querySelector('#join-form'));
  $.ajax({
	  url: '어쩌구', 
	  method: 'post',
	  data: formData,
	  processData: false,
	  contentType: false     // 넘기는 데이터의 형식은 multirpart/form-data이다
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
        <!-- 프사 업로드, 아이디, 비밀번호, 이메일, 생일 -->
        <h1>회원 가입</h1>			 
			  <form action="/member/join" method="post" enctype="multipart/form-data" id="join-form">
			    <div style="height:240px;">
			      <img id="show-profile" style="height:240px; display:none;" alt="프로필 사진">
			    </div>
			    <div class="mb-3 mt-3">
            <label for="profile" class="form-label">프로필:</label>
            <input type="file" class="form-control" id="profile" name="profile">
          </div>
			    <div class="mb-3 mt-3">
            <label for="username" class="form-label">아이디:</label>
            <input type="text" class="form-control" id="username" name="username" maxlength="10">
            <span id="username-msg"></span>
          </div>
          <div class="mb-3 mt-3">
            <label for="password" class="form-label">비밀번호:</label>
            <input type="password" class="form-control" id="password" name="password" maxlength="10">
            <span id="password-msg"></span>
          </div>
          <div class="mb-3 mt-3">
            <label for="email" class="form-label">이메일:</label>
            <input type="text" class="form-control" id="email" name="email">
            <span id="email-msg"></span>
          </div>
          <div class="mb-3 mt-3">
            <label for="birthday" class="form-label">생일:</label>
            <input type="date" class="form-control" id="birthday" name="birthday">
            <span id="birthday-msg"></span>
          </div>
          <button type="button" id="join" class="btn btn-primary">가입</button>
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