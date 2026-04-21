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
			<span>${loginUserName}</span>様
			<a href="">ログアウト</a>
		</c:if>
	</nav>
</header>
</html>