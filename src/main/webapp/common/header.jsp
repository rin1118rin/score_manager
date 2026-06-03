<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;500&family=Rajdhani:wght@300;400;500;600&display=swap"
      rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<header>
	<h1>得点管理システム</h1>
	<nav>
		<c:if test="${not empty user}">
			<span>${user.name}</span>様
			<a href="Logout.action">ログアウト</a>
		</c:if>
	</nav>
</header>
</html>