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
<script>
  $(document).ready(function() {
	  $('#change-email').on("click", function() {
		  const email = $('#email').val();
		  if(email==='') {
			  alert('이메일을 입력하세요');
			  return;
		  }
			const html = `
			  <form action="/member/change-email" method="post">
				  <input type="hidden" name="email" value="\${email}">
			  </form>
			`;
			$(html).appendTo($('body')).submit();
	  });
	  
	  $('#quit').on("click", function() {
		  const choice = confirm('정말 탈퇴하시겠습니까?');
		  if(choice===false)
			  return;
		  const html=`
			  <form action="/member/quit" method="post">
	      </form>
		  `;
		  $(html).appendTo($('body')).submit();
	  });
  })
  
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
        <table class="table">
          <tr>
            <td colspan="2">
              <img src="${member.profile}">
            </td>
          </tr>
          <tr>
            <td>아이디</td>
            <td>${member.username}</td>
          </tr>
          <tr>
            <td>
              이메일
            </td>
            <td>
              <input type="text" name="email" id="email" value="${member.email}">
              <button id="change-email" class="btn btn-primary">이메일 변경</button>
            </td>
          </tr>
          <tr>
            <td>가입정보</td>
            <td>
              생일 : ${member.birthday }<br>
              가입일 : ${member.joinday }(${member.days }일)
            </td>
          </tr>
        </table>
        <button class='btn btn-warning' id="quit">회원 탈퇴</button>			 
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