<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script>
  $(document).ready(function() {
	  $('#logout').on('click', function() {
		  // JS에서 EL값을 받아오는 방법
		  const csrf = '${_csrf.token}';
		  const html = `
			  <form action='/member/logout' method='post'>
			    <input type='hidden' name='_csrf' value='\${csrf}'>
			  </form>
		  `;
		  // const 부모 = 부모.append(자식);
		  // const 자식 = 자식.appendTo(부모);
		  // 지금은 html을 body에 붙인 다음 submit(form은 반드시 body에 붙여야 한다)
		  $(html).appendTo($('body')).submit();
	  });
  })
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
  logo 
  비로그인 : 회원가입 로그인
  사용자 : 아이디찾기 내정보 장바구니  로그아웃
  관리자 : 상품등록  로그아웃
 -->
<div class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">Shop</a>
    <ul class="navbar-nav">
	    <sec:authorize access="isAnonymous()">
	      <li class="nav-item">
	        <a class="nav-link" href="/member/join">회원가입</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/member/login">로그인</a>
	      </li>
	      <li class="nav-item">
          <a class="nav-link" href="/member/find">아이디찾기</a>
        </li>
	    </sec:authorize>
	    <sec:authorize access="hasRole('USER')">
	      <li class="nav-item">
	        <a class="nav-link" href="/member/read">내정보</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">장바구니</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="logout">로그아웃</a>
	      </li>
	    </sec:authorize>
	    <sec:authorize access="hasRole('ADMIN')">
	      <li class="nav-item">
	        <a class="nav-link" href="#">상품등록</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="logout">로그아웃</a>
	      </li>
	    </sec:authorize>
    </ul>
  </div>
</div>
</body>
</html>



