<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<title>得点管理システム</title>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
		<div class="logout-page">
		
		    <%@ include file="/common/sidebar.jsp" %>
		
		    <div class="logout-content">
		
		        <h2>ログアウト</h2>
		
		        <p class="logout-message">
		            ログアウトしました
		        </p>
		
		        <a href="Login.action"
		           class="login-button">
		
		            ログイン
		
		        </a>
		
		    </div>
		
		</div>
	<%@ include file="/common/footer.jsp" %>
</body>
</html>