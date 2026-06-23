<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
	<title>得点管理システム</title>
	<%@ include file="/common/head.jsp" %>
</head>
<body>
	<%@ include file="/common/header.jsp" %>
	
	<div class="container">
	    <%@ include file="/common/sidebar.jsp" %>
		<div class="main score-complete-page">
		
		    <div class="complete-card">
		
		        <h2>成績管理</h2>
		
		        <p class="complete-message">
		            登録が完了しました
		        </p>
		
		        <div class="complete-button-area">
		
		            <a href="TestRegist.action"
		               class="sub-button">
		
		                戻る
		
		            </a>
		
		            <a href="TestList.action"
		               class="main-button">
		
		                成績参照
		
		            </a>
		
		        </div>
		
		    </div>
		
		</div>
	<%@ include file="/common/footer.jsp" %>
</body>
</html>