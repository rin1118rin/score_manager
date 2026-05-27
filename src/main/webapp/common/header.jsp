<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<header>
	<h1>得点管理システム</h1>
	<nav>
		<c:if test="${not empty loginUserName}">
			<span>${user.name}</span>様
			<a href="Logout.action">ログアウト</a>
		</c:if>
	</nav>
</header>
</html>